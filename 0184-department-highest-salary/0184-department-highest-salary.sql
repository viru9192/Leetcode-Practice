select 
d.name as Department,
e.name as Employee,
e.salary as Salary
from employee e
join department d
on e.departmentId = d.id
where e.salary = (
    select
    max(e1.salary) as salary
    from employee e1
    where e.departmentId = e1.departmentId
);