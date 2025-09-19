select
s.product_id, 
s.year as first_year,
s.quantity,
s.price
from sales s
join (
    select
    sale_id,
    product_id,
    min(year) as f_year
    from sales
    group by product_id
) as fy
on s.product_id = fy.product_id
where s.year = fy.f_year;