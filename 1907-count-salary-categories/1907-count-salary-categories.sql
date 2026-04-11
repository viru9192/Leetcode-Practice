with cat as (
    select 
    "Low Salary" as category
    union all
    select 
    "Average Salary" as category
    union all
    select 
    "High Salary" as category
),
cat_s as (
    select 
    (
        case    
            when income < 20000 then "Low Salary"
            when income between 20000 and 50000 then "Average Salary"
            when income > 50000 then "High Salary"
            else 0
        end
    ) as sal_cat
    from accounts
)
select 
c.category,
count(cs.sal_cat) as accounts_count
from cat c
left join cat_s cs
on c.category = cs.sal_cat
group by c.category;