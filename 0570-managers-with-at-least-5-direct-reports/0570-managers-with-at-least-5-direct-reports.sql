select 
m.name 
from employee e
join employee m
on e.managerid = m.id
group by m.id, m.name
having count(*) >= 5;