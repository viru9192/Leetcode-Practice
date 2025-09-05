with salary_rnk as (
    select 
    id,
    name,
    departmentId,
    salary,
    dense_rank() over (
        partition by departmentid
        order by salary desc
    ) as rnk
    from employee
)
select 
d.name as Department,
s.name as Employee,
s.salary as Salary
from salary_rnk s
left join department d
on s.departmentId = d.id
where s.rnk <= 3
order by Salary desc;