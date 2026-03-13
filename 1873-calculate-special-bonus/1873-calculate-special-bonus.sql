select
e.employee_id,
coalesce(e1.salary, 0) as bonus
from employees e
left join employees e1
on e.employee_id = e1.employee_id
and e.employee_id % 2 = 1
and e.name not like 'M%'
order by e.employee_id;