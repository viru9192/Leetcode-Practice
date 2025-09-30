select
e1.name as Employee
from employee e1
join employee m
on e1.managerid = m.id
where e1.salary > m.salary;