with first_order as (
    select 
    customer_id,
    min(order_date) as fo_date
    from delivery
    group by customer_id
)
select
round(
    sum(
        case
            when d.order_date = d.customer_pref_delivery_date then 1
            else 0
        end) * 100.0 / 
        count(*), 2
) as immediate_percentage
from delivery d
join first_order fo
on d.customer_id = fo.customer_id
and d.order_date = fo.fo_date;