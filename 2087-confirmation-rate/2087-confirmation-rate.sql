select u.user_id,
round(
    sum(case when c.action = 'confirmed' then 1 else 0 end) * 1.0
    /
    count(*), 2) as confirmation_rate
from signups u
left join confirmations c
on u.user_id = c.user_id
group by u.user_id;