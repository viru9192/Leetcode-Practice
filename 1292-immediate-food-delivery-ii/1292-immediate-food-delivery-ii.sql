select
round(
    sum(
        case when customer_pref_delivery_date = order_date then 1
        else 0 end
    ) * 100 / count(*), 2
) as immediate_percentage
from (
    select d.*
    from delivery d
    join (
        select 
        delivery_id,
        customer_id,
        min(order_date) as f_order
        from delivery 
        group by customer_id
    ) as f_del
    on d.customer_id = f_del.customer_id
    and d.order_date = f_del.f_order
) as o;