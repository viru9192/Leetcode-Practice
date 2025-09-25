select
person_name
from (
    select
    person_name,
    sum(weight) over(
        order by turn
    ) as cumm_weight
    from queue
) as wp
where cumm_weight <= 1000
order by cumm_weight desc
limit 1;