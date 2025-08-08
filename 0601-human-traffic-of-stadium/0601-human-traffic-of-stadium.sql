with elig as (
    select 
    id,
    visit_date,
    people,
    id - row_number() over(order by id) as grp
    from stadium
    where
    people >= 100
),
big_grp as (
    select 
    grp
    from elig
    group by grp
    having count(*) >= 3
)
select
id,
visit_date,
people
from elig
where grp in (
    select grp from big_grp
)
order by visit_date asc;