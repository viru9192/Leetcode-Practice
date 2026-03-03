select
c.customer_id
from customer c
join product p
on c.product_key = p.product_key
group by c.customer_id
having count(distinct p.product_key) = (
    select 
    count(*) as total
    from product
);