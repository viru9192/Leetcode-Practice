select
max(e.salary) as SecondHighestSalary
from employee e
where salary < (
    select
    max(salary) as salary
    from employee
);