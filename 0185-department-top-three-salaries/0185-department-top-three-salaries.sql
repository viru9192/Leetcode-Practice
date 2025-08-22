with top_three as (
    select 
    d.name as Department,
    e.name as Employee,
    e.salary as Salary,
    dense_rank() over(
        partition by departmentId order by salary desc
    ) as rnk
    from employee e
    join department d
    on 
    e.departmentId = d.id
)
select 
Department,
Employee,
Salary 
from top_three
where rnk <= 3
order by Department asc, Salary desc;