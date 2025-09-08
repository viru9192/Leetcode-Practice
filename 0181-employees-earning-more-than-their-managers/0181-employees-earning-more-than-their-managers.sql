select
e.name as Employee
from employee e
join employee m
on e.managerid = m.id
and e.salary > m.salary;