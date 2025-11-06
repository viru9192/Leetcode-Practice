with top3 as (
    select
    id,
    name,
    salary,
    departmentid,
    dense_rank() over(
        partition by departmentid
        order by salary desc
    ) as 'rnk'
    from employee 
)
select
d.name as Department,
t.name as Employee,
t.salary as Salary
from department d
join top3 t
on d.id = t.departmentid
where rnk <= 3;