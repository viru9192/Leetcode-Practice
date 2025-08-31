select
max(distinct salary) as SecondHighestSalary
from employee
where 
salary < (
    select 
    max(salary)
    from employee
);