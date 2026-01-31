/*Constraint enforced:
 Production access levels must be limited to approved, non-elevated roles by default.
Ticket:
 User access records exist in production where the access_level is set to an elevated value (e.g. admin or equivalent) that exceeds standard operational requirements.
Goal:
 Downgrade elevated access levels in production to the standard write level.*/

select * 
from user_access
join applications on user_access.application_id = applications.application_id
where (
	applications.environment = 'prod' and user_access.status = "active" and user_access.access_level = 'admin'
);

update user_access as ua
join (
	select ua2.user_id
	from user_access as ua2
	join applications on ua2.application_id = applications.application_id
	where (
		applications.environment = 'prod' and ua2.status = "active" and ua2.access_level = 'admin'
	)
) uatmp on uatmp.user_id = ua.user_id
set ua.access_level = 'write';
