select
u.name as Name,
sum(t.amount) as BALANCE
from users u
join transactions t
on u.account = t.account 
group by t.account
having sum(t.amount) > 10000;