with department_r as (
    select d.name as Department, e.name as Employee, 
    e.salary, dense_rank() over(partition by departmentid order by salary desc) as rnk
    from employee e
    join department d
    on e.departmentid = d.id
)
select Department, Employee, Salary 
from department_r
where rnk <= 3
order by department asc, salary desc;