select 
p.product_id as product_id,
ROUND(
  COALESCE( SUM(u.units * p.price) / NULLIF(SUM(u.units), 0), 0 )
, 2) AS average_price
from prices p
left join unitssold u
on p.product_id = u.product_id
and
u.purchase_date between p.start_date and p.end_date
group by p.product_id;