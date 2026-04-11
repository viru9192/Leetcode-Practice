with latest as (
    select 
    product_id,
    new_price,
    change_date,
    row_number() over(
        partition by product_id
        order by change_date desc
    ) as rn
    from products
    where change_date <= '2019-08-16'
)
select 
p.product_id,
coalesce(
    l.new_price, 10
) as price
from (
    select 
    distinct product_id
    from products
) p
left join latest l
on p.product_id = l.product_id
and rn = 1;