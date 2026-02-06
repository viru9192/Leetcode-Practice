select 
employee_id 
from employees
where 
salary < 30000
and 
manager_id not in (
    select 
    employee_id 
    from employees
)
and 
manager_id is not null
order by employee_id;