with fyear as(
    select 
    product_id,
    min(year) as f_year
    from sales
    group by product_id
)
select
s.product_id,
f.f_year as first_year,
s.quantity,
s.price
from sales s
join fyear f
on s.product_id = f.product_id
and s.year = f.f_year;