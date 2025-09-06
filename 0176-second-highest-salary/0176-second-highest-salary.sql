select
max(distinct salary) as SecondHighestSalary
from 
employee
where 
salary < (
    select 
    max(e.salary)
    from employee e
);