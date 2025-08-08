with store_c as (
    select i.store_id,
    count(distinct i.product_name) as product_count
    from inventory i 
    group by i.store_id
),
rank_s as (
    select 
    i.store_id,
    i.product_name,
    i.quantity,
    i.price,
    row_number() over (partition by i.store_id order by i.price desc, i.product_name asc) as max_price_rank,
    row_number() over (partition by i.store_id order by i.price asc, i.product_name asc) as min_price_rank
    from inventory i

),
exp_product as (
    select 
    store_id,
    product_name as most_exp_p,
    quantity as most_exp_q
    from rank_s
    where max_price_rank = 1
),
cheap_product as (
   select 
    store_id,
    product_name as min_exp_p,
    quantity as min_exp_q
    from rank_s
    where min_price_rank = 1 
)
select 
s.store_id,
s.store_name,
s.location,
ep.most_exp_p as most_exp_product,
cp.min_exp_p as cheapest_product,
round((cp.min_exp_q * 1.0 / ep.most_exp_q), 2) as imbalance_ratio
from stores s
join store_c sc 
on sc.store_id = s.store_id and sc.product_count >= 3
join exp_product ep
on ep.store_id = s.store_id
join cheap_product cp
on cp.store_id = s.store_id
where ep.most_exp_q < cp.min_exp_q and ep.most_exp_q > 0
order by imbalance_ratio desc, s.store_name asc;