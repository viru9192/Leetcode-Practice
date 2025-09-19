select
max(salary) as SecondHighestSalary
from employee
where 
salary < (
    select
    max(e.salary) as m_salary
    from employee e
);