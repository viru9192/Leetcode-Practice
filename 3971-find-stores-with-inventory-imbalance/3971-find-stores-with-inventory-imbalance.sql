WITH store_prod_counts AS (
  SELECT
    i.store_id,
    COUNT(DISTINCT i.product_name) AS product_cnt
  FROM inventory i
  GROUP BY i.store_id
),
ranked AS (
  SELECT
    i.store_id,
    i.product_name,
    i.quantity,
    i.price,
    ROW_NUMBER() OVER (
      PARTITION BY i.store_id
      ORDER BY i.price DESC, i.product_name ASC
    ) AS rn_max_price,
    ROW_NUMBER() OVER (
      PARTITION BY i.store_id
      ORDER BY i.price ASC, i.product_name ASC
    ) AS rn_min_price
  FROM inventory i
),
most_exp AS (
  SELECT
    store_id,
    product_name AS most_exp_product,
    quantity    AS most_exp_qty
  FROM ranked
  WHERE rn_max_price = 1
),
cheapest AS (
  SELECT
    store_id,
    product_name AS cheapest_product,
    quantity    AS cheapest_qty
  FROM ranked
  WHERE rn_min_price = 1
)
SELECT
  s.store_id,
  s.store_name,
  s.location,
  me.most_exp_product,
  ch.cheapest_product,
  ROUND( ch.cheapest_qty * 1.0 / me.most_exp_qty, 2 ) AS imbalance_ratio
FROM stores s
JOIN store_prod_counts c ON c.store_id = s.store_id AND c.product_cnt >= 3
JOIN most_exp me         ON me.store_id = s.store_id
JOIN cheapest ch         ON ch.store_id = s.store_id
WHERE me.most_exp_qty < ch.cheapest_qty         -- imbalance condition
  AND me.most_exp_qty > 0                       -- (optional) avoid divide-by-zero
ORDER BY imbalance_ratio DESC, s.store_name ASC;
