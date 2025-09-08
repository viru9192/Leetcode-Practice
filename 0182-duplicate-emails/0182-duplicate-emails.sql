select
distinct p.email as Email
from person p
left join person p1
on p.id != p1.id
where
p.email = p1.email;