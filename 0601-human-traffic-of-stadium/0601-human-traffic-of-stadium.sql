with consec as (
    select
    id,
    visit_date,
    people,
    id - row_number() over(
        order by id 
    ) as grp
    from stadium
    where people >= 100
),
consec_grp as (
    select 
    grp 
    from consec
    group by grp
    having count(*) >= 3
)
select
id,
visit_date,
people
from consec
where grp in (
    select
    grp 
    from consec_grp
)
order by visit_date;