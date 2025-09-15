select 
round(
    sum(
        case when customer_pref_delivery_date = order_date then 1 else 0 end
    ) * 100 / count(*), 2
) as immediate_percentage
from (
    select d.*
    from delivery d
    join (
        select 
        customer_id,
        min(order_date) as first_order
        from delivery
        group by customer_id
    ) fo
    on d.customer_id = fo.customer_id
    and d.order_date = fo.first_order
) as o;