with cumm_w as (
    select 
    person_id,
    person_name,
    sum(weight) over(
        order by turn
    ) as cumm_weight
    from queue
)
select 
person_name
from cumm_w
where cumm_weight <= 1000
order by cumm_weight desc
limit 1;