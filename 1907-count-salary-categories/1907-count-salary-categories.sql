with cat as (
    select 'Low Salary' as category
    union all 
    select 'Average Salary' as category
    union all
    select 'High Salary' as category
),
cat_acc as (
    select 
    (
        case 
        when income < 20000 then 'Low Salary'
        when income between 20000 and 50000 then 'Average Salary'
        when income > 50000 then 'High Salary'
        end
    ) as category
    from accounts
)
select 
c.category,
count(ca.category) as accounts_count
from cat c
left join cat_acc ca
on c.category = ca.category
group by c.category;