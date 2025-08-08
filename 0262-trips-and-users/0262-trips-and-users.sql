select 
t.request_at as Day,
round(
    sum(case when t.status in ('cancelled_by_driver', 'cancelled_by_client') then 1 else 0 end) / count(*), 2
) as "Cancellation Rate"
from trips t
join users u
on t.client_id = u.users_id and u.banned = 'No' and u.role = 'client'
join users v
on t.driver_id = v.users_id and v.banned = 'No' and v.role = 'driver'
where 
t.request_at between "2013-10-01" and "2013-10-03"
group by t.request_at;