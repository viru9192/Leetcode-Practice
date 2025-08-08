with store_prod_counts as (
  select
    i.store_id,
    count(distinct i.product_name) as product_cnt
  from inventory i
  group by i.store_id
),
ranked as (
  select
    i.store_id,
    i.product_name,
    i.quantity,
    i.price,
    row_number() over (
      partition by i.store_id
      order by i.price desc, i.product_name asc
    ) as rn_max_price,
    row_number() over (
      partition by i.store_id
      order by i.price asc, i.product_name asc
    ) as rn_min_price
  from inventory i
),
most_exp as (
  select
    store_id,
    product_name as most_exp_product,
    quantity    as most_exp_qty
  from ranked
  where rn_max_price = 1
),
cheapest as (
  select
    store_id,
    product_name as cheapest_product,
    quantity    as cheapest_qty
  from ranked
  where rn_min_price = 1
)
select
  s.store_id,
  s.store_name,
  s.location,
  me.most_exp_product,
  ch.cheapest_product,
  round(ch.cheapest_qty * 1.0 / me.most_exp_qty, 2) as imbalance_ratio
from stores s
join store_prod_counts c on c.store_id = s.store_id and c.product_cnt >= 3
join most_exp me         on me.store_id = s.store_id
join cheapest ch         on ch.store_id = s.store_id
where me.most_exp_qty < ch.cheapest_qty
  and me.most_exp_qty > 0
order by imbalance_ratio desc, s.store_name asc;