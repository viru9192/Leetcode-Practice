with u_cat as (
    select
    distinct pp.user_id as user_id,
    pr.category as category
    from productpurchases pp
    join productinfo pr
    on pp.product_id = pr.product_id
),
u_pair as (
    select
    uc.user_id,
    uc.category as category1,
    uc1.category as category2
    from u_cat uc
    join u_cat uc1
    on uc.user_id = uc1.user_id
    and uc.category < uc1.category
)
select 
up.category1,
up.category2,
count(up.user_id) as customer_count
from u_pair up
group by up.category1, up.category2
having count(*) >= 3
order by customer_count desc, category1 asc, category2 asc;