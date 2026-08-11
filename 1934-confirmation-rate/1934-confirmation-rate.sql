with cte as (
    select 
    user_id,
    round(
        count(
                case
                    when action = 'confirmed' then 1
                end
            ) * 1.0 / count(*), 2
        ) as confirmation_rate
    from confirmations
    group by user_id
)
select 
s.user_id,
coalesce(c.confirmation_rate, 0) as confirmation_rate
from signups s
left join cte c
on s.user_id = c.user_id
group by s.user_id;