select
e.name
from employee e
join employee m
on e.id = m.managerid
group by e.id, e.name
having count(*) >= 5;