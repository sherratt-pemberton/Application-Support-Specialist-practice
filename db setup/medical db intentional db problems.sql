-- ===============================
-- Intentional Data Problems
-- (Do NOT read during practice)
-- ===============================

-- 1 Create revoked access rows missing revoked_at
UPDATE user_access ua
JOIN (
  SELECT access_id
  FROM user_access
  ORDER BY access_id
  LIMIT 3
) t ON ua.access_id = t.access_id
SET ua.status = 'revoked',
    ua.revoked_at = NULL;
    
-- 2. Create duplicate active access rows
INSERT INTO user_access (user_id, application_id, access_level, status, granted_at)
SELECT user_id, application_id, access_level, 'active', NOW()
FROM user_access
WHERE status = 'active'
LIMIT 3;

-- 3. Create future-dated active access
UPDATE user_access
SET granted_at = DATE_ADD(NOW(), INTERVAL 7 DAY)
WHERE access_id IN (
  SELECT access_id
  FROM (
    SELECT access_id
    FROM user_access
    WHERE status = 'active'
    ORDER BY access_id
    LIMIT 2
  ) AS tmp
);

-- 4. Create open incidents tied to revoked access
INSERT INTO incidents (user_id, application_id, status, created_at)
SELECT ua.user_id, ua.application_id, 'open', NOW()
FROM user_access ua
JOIN (
  SELECT access_id
  FROM user_access
  WHERE status = 'revoked'
  ORDER BY access_id
  LIMIT 3
) t ON ua.access_id = t.access_id;

-- Create resolved incidents missing resolved_at
UPDATE incidents
SET status = 'resolved',
    resolved_at = NULL
WHERE incident_id IN (
  SELECT incident_id
  FROM (
    SELECT incident_id
    FROM incidents
    WHERE status = 'open'
    ORDER BY incident_id
    LIMIT 2
  ) AS tmp
);

-- 6. Create admin access in prod
UPDATE user_access ua
JOIN (
  SELECT access_id
  FROM (
    SELECT ua.access_id
    FROM user_access ua
    JOIN applications a ON a.application_id = ua.application_id
    WHERE a.environment = 'prod'
    ORDER BY ua.access_id
    LIMIT 3
  ) AS tmp
) t ON ua.access_id = t.access_id
SET ua.access_level = 'admin';
