select
distinct p1.email as Email
from person p1
left join person p2
on p1.id != p2.id 
where p1.email = p2.email;