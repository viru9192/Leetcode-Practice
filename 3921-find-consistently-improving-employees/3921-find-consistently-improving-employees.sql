with r_reviews as (
    select 
    pr.employee_id,
    pr.rating,
    pr.review_date,
    row_number() over (partition by pr.employee_id order by pr.review_date desc) as rn
    from performance_reviews pr
),
last_three as (
    select employee_id,
    max(case when rn = 1 then rating end) as r1,
    max(case when rn = 2 then rating end) as r2,
    max(case when rn = 3 then rating end) as r3
    from r_reviews 
    where rn <= 3
    group by employee_id
),
qualified as (
    select 
    e.employee_id,
    e.name,
    (r1 - r3) as improvement_score
    from last_three lt
    join employees e
    on lt.employee_id = e.employee_id
    where (r1 >r2) and (r2 > r3)
)
select 
employee_id,
name,
improvement_score
from qualified
order by improvement_score desc, name asc;