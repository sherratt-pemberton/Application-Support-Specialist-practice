select access_id, user_id, status, granted_at
from user_access
where (( user_access.granted_at > now() ) and user_access.status = 'active')
order by granted_at;

update user_access
join (
select access_id, user_id, status, granted_at
from user_access
where (( user_access.granted_at > now() ) and user_access.status = 'active')
) ua on user_access.user_id = ua.user_id
set user_access.status = 'revoked', user_access.revoked_at = now()