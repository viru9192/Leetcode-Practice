with top3 as (
    select 
    e.*,
    dense_rank() over(
        partition by e.departmentid
        order by e.salary desc
    ) as rnk
    from employee e
)
select 
d.name as Department,
t.name as Employee,
t.salary as Salary
from department d
join top3 t
on d.id = t.departmentid
where t.rnk <= 3;