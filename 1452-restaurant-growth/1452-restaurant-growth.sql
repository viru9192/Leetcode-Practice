select 
visited_on,
sum(amount) over(
    rows between 6 preceding and current row
) as amount,
round(
    avg(amount) over(
        rows between 6 preceding and current row
    ), 2
) as average_amount
from (
    select 
    sum(amount) as amount,
    visited_on
    from customer
    group by visited_on
) as daily_paid
order by visited_on asc
limit 100 offset 6;