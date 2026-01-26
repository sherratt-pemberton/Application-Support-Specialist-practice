/*
Get all duplicate keys. Duplicates are entries where the user_id and application_id are the same
*/

SELECT user_id, application_id, COUNT(*) 
FROM user_access 
GROUP BY user_id, application_id 
HAVING COUNT(*) > 1;

/*
get all rows with the duplicate keys. Order them by application_id and user_id
*/

select * 
from user_access
where ( (user_id, application_id) and status = 'revoked' ) in (
	SELECT user_id, application_id 
	FROM user_access 
	GROUP BY user_id, application_id 
	HAVING COUNT(*) > 1
) order by application_id, user_id;

/*
update the duplicate rows from active to revoked using the following rule.
For each (user_id, application_id)
	if more than one row exists,
		keep the row with the smallest access_id
		and treat all others as duplicates.
*/

/*
determine which rows have the same user_id and application_id and the lowest access_id 
*/

SELECT
    user_access.access_id,
    user_access.user_id,
    user_access.application_id,
    user_access.access_id AS current_access_id,
    MIN(user_access.access_id) OVER (
        PARTITION BY user_access.user_id, user_access.application_id
    ) AS keeper_access_id
FROM user_access;

/*
Identify which rows to keep and which are duplicates.
duplicates are rows in which the user_id and application_id are the same but the keeper_access_id is not the access_id
*/

SELECT
    user_access.access_id,
    user_access.user_id,
    user_access.application_id,
    MIN(user_access.access_id) OVER (
        PARTITION BY user_access.user_id, user_access.application_id
    ) AS keeper_access_id,
    CASE
        WHEN user_access.access_id =
             MIN(user_access.access_id) OVER (
                 PARTITION BY user_access.user_id, user_access.application_id
             )
        THEN 'KEEP'
        ELSE 'DUPLICATE'
    END AS resolution
FROM user_access;

/*
Preview the rows which need to be changed
*/

SELECT *
FROM (
    SELECT
        user_access.access_id,
        user_access.user_id,
        user_access.application_id,
        MIN(user_access.access_id) OVER (
            PARTITION BY user_access.user_id, user_access.application_id
        ) AS keeper_access_id,
        COUNT(*) OVER (
            PARTITION BY user_access.user_id, user_access.application_id
        ) AS rows_per_key
    FROM user_access
) AS preview
WHERE
    preview.rows_per_key > 1
    AND preview.access_id <> preview.keeper_access_id;
    
/*
bulk update all of the duplicate rows
*/

UPDATE user_access
JOIN (
    SELECT
        access_id
    FROM (
        SELECT
            user_access.access_id,
            MIN(user_access.access_id) OVER (
                PARTITION BY user_access.user_id, user_access.application_id
            ) AS keeper_access_id,
            COUNT(*) OVER (
                PARTITION BY user_access.user_id, user_access.application_id
            ) AS rows_per_key
        FROM user_access
    ) AS preview
    WHERE
        preview.rows_per_key > 1
        AND preview.access_id <> preview.keeper_access_id
) AS rows_to_revoke
ON user_access.access_id = rows_to_revoke.access_id
SET
    user_access.status = 'revoked',
    user_access.revoked_at = NOW();
