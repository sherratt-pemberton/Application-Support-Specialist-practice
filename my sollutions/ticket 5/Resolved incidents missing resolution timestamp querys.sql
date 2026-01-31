select * 
from incidents 
where status = 'resolved' and resolved_at is null;

update incidents
join (
select * 
from incidents 
where status = 'resolved' and resolved_at is null
) i on incidents.incident_id = i.incident_id
set incidents.resolved_at = now();
