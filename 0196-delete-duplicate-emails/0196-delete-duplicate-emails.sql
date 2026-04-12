delete 
p2
from person p1
join person p2
on p1.email = p2.email
and p2.id > p1.id;