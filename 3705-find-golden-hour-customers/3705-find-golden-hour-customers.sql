select
customer_id,
count(order_id) as total_orders,
round(sum(
    case 
        when hour(order_timestamp) between 11 and 13 
            or hour(order_timestamp) between 18 and 20
            then 1
        else 0
    end
) * 100 / count(*), 0) as peak_hour_percentage,
round(
    avg(
    case
        when order_rating is not null
        then order_rating
    end
), 2
) as average_rating
from restaurant_orders
group by customer_id
having count(*) >= 3
and (sum(
    case 
        when hour(order_timestamp) between 11 and 13 
            or hour(order_timestamp) between 18 and 20
            then 1
        else 0
    end
) * 100.0 / count(*)) >= 60
and average_rating >= 4.0
and (sum(
    case
        when order_rating is not null
        then 1
        else 0
    end
) * 100.0 / count(*)) >= 50
order by average_rating desc, customer_id desc;