with daily as(
    select
    visited_on,
    sum(amount) as amount
    from customer 
    group by visited_on
),
moving as (
    select
    visited_on,
    sum(amount) over(
        order by visited_on
        rows between 6 preceding and current row
    ) as amount,
    avg(amount) over(
        order by visited_on
        rows between 6 preceding and current row
    ) as average_amt,
    count(*) over(
        order by visited_on
        rows between 6 preceding and current row
    ) as cnt
    from daily
)
select
visited_on,
amount,
round(
    average_amt, 2
) as average_amount
from moving
where cnt = 7
order by visited_on;