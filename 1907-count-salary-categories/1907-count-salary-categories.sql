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
    select (
        case 
            when income < 20000 then "Low Salary"
            when income between 20000 and 50000 then "Average Salary"
            when income > 50000 then "High Salary"
        end
    ) as salary_cat
    from accounts
)
select
c.category,
count(cs.salary_cat) as accounts_count
from cat c
left join cat_s cs
on c.category = cs.salary_cat
group by c.category;