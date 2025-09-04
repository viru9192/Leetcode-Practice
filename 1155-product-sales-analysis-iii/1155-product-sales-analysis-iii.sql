select
s.product_id,
s.year as first_year,
s.quantity,
s.price
from sales s
join (
    select 
    product_id,
    min(year) as first_y
    from sales
    group by product_id
) as fp
on s.product_id = fp.product_id
and s.year = fp.first_y;