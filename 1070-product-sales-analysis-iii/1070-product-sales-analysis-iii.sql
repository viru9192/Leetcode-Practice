with fyear as (
    select 
    product_id,
    min(year) as f_year
    from sales
    group by product_id
)
select
f.product_id,
f.f_year as first_year,
s.quantity,
s.price
from fyear f
join sales s
on f.product_id = s.product_id
and f.f_year = s.year;