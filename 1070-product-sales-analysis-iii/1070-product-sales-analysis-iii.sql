with fyear as (
    select 
    product_id,
    min(year) as fy
    from sales
    group by product_id
)
select 
f.product_id,
f.fy as first_year,
s.quantity,
s.price
from sales s
join fyear f
on s.product_id = f.product_id
and f.fy = s.year;