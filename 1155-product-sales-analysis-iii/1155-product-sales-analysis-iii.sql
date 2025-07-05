select s.product_id, s.year as first_year, s.quantity, s.price
from sales s
join (
    select product_id, min(year) as first_year
    from sales
    group by product_id
) p
on
s.product_id = p.product_id
and 
s.year = p.first_year
order by s.product_id;