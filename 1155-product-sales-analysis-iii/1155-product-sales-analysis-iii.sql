select
s.product_id,
s.year as first_year,
s.quantity,
s.price
from sales s
join (
    select 
    product_id,
    min(year) as f_year
    from sales
    group by product_id
) as first_y
on s.product_id = first_y.product_id
where s.year = first_y.f_year;