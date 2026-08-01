select 
eq.unique_id,
e.name
from employees e
left join employeeUNI eq
on e.id = eq.id;