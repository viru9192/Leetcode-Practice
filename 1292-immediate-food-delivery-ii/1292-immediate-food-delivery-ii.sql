select 
round(
    sum(case when order_date = customer_pref_delivery_date then 1 else 0 end) * 100 /
    count(*), 2
) as immediate_percentage
from (
    select d.*
    from delivery d
    join (
        select customer_id, min(order_date) as first_order_date
        from delivery 
        group by customer_id
    ) as first_customer_order
on
d.customer_id = first_customer_order.customer_id
and 
d.order_date = first_customer_order.first_order_date 
) as cf