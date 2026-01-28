select
eu.unique_id,
e.name
from employees e
left join employeeUNI as eu
on e.id = eu.id;