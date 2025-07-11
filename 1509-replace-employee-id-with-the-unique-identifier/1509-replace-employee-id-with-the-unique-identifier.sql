select e1.unique_id, e.name
from employees e
left join employeeuni e1
on e.id = e1.id;