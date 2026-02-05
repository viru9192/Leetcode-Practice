select 
p.product_id,
coalesce(t.new_price, 10) as price
from (
    select
    distinct product_id 
    from products
) p
left join (
    select 
    product_id,
    new_price,
    row_number() over(
        partition by product_id
        order by change_date desc
    ) as rn
    from products
    where change_date <= '2019-08-16'
) t
on p.product_id = t.product_id
and t.rn = 1;