with top3 as (
    select 
    id,
    name,
    salary,
    departmentid,
    dense_rank() over(
        partition by departmentid 
        order by salary desc
    ) as rnk
    from employee
)
select
d.name as Department,
t.name as Employee,
t.salary as Salary
from top3 t
join department d
on t.departmentid = d.id
where t.rnk <= 3;