select
m.name
from employee e
join employee m
on e.managerid = m.id
group by m.id
having count(*) >= 5;