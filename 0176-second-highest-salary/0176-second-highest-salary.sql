select
max(e.salary) as SecondHighestSalary
from employee e
where 
e.salary < (
    select 
    max(salary) as salary
    from employee
);