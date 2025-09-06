select
max(salary) as SecondHighestSalary
from 
employee
where 
salary < (
    select 
    max(e.salary)
    from employee e
);