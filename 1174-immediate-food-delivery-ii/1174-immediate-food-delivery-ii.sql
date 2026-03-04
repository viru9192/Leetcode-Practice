with fo as (
    select
    customer_id,
    min(order_date) as f_order
    from delivery
    group by customer_id
)
select
round(
    sum(
        case 
            when d.order_date = d.customer_pref_delivery_date then 1
            else 0 
        end
    ) * 100 / count(*), 2
) as immediate_percentage
from delivery d
join fo f
on d.customer_id = f.customer_id
and d.order_date = f.f_order;