with first as (
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
from first f
join sales s
on s.product_id = f.product_id
and s.year = f.f_year;