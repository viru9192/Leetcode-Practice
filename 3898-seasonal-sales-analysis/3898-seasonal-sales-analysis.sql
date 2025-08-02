with season_sales as (
    select 
        case 
            when month(s.sale_date) in (12,1,2) then 'Winter'
            when month(s.sale_date) between 3 and 5 then 'Spring'
            when month(s.sale_date) between 6 and 8 then 'Summer'
            else 'Fall'
        end as season,
        p.category,
        sum(s.quantity) as total_quantity,
        sum(s.quantity*s.price) as total_revenue
    from sales s
    join products p on s.product_id = p.product_id
    group by season, p.category
)
select season, category, total_quantity, total_revenue
from (
    select *,
           row_number() over (
               partition by season
               order by total_quantity desc, total_revenue desc
           ) as rn
    from season_sales
) t
where rn = 1
order by case season
            when 'Fall' then 1
            when 'Spring' then 2
            when 'Summer' then 3
            when 'Winter' then 4
         end;
