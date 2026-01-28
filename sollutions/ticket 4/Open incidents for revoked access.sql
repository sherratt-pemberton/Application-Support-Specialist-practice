/*Constraint violated: Incidents should not remain open after access revocation.
 Ticket: Open incidents exist for applications where user access is revoked.
 Goal: Resolve inappropriate incidents with audit timestamp.*/

/*confirm expected system status - open incidents exsist for user access that has been revoked
keys (incident.status = 'open', user_access.status = 'revoked')
*/

SELECT incidents.incident_id, incidents.user_id, incidents.status, incidents.created_at, incidents.resolved_at, user_access.status as 'user_access status', user_access.revoked_at as 'user_access revoked as' 
from incidents
inner join user_access on incidents.user_id = user_access.user_id
where (incidents.status = "open" and user_access.status = "revoked"); 

/*
creates a tempory table of incidents where incident is open and user access is revoked
update incidents from the tempory table data
*/

UPDATE incidents i
JOIN (
  SELECT i2.incident_id
  FROM incidents i2
  JOIN user_access ua2 ON ua2.user_id = i2.user_id
  WHERE i2.status = 'open'
    AND ua2.status = 'revoked'
) k ON k.incident_id = i.incident_id
SET i.status = 'resolved',
    i.resolved_at = NOW();

