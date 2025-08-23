select
p.product_name,
sum(o.unit) as unit
from products p
join orders o
on 
p.product_id = o.product_id
where
year(o.order_date) = 2020 and month(o.order_date) = 02
group by p.product_id, p.product_name
having 
sum(o.unit) >= 100;