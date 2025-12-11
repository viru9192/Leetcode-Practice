select
visited_on,
sum(amount) over(
    order by visited_on
    rows between 6 preceding and current row
) as amount,
round(
    avg(amount) over(
        order by visited_on
        rows between 6 preceding and current row
    ), 2
) as average_amount
from (
    select 
    visited_on,
    sum(amount) as amount
    from customer
    group by visited_on
) as cs
order by visited_on
limit 100 offset 6;