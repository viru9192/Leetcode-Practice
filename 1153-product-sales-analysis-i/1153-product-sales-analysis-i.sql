select p.product_name as product_name, s.year as year, s.price as price 
from product p
join sales s
on 
p.product_id = s.product_id;