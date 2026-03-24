with can_s as(
    select
    t.status,
    t.request_at
    from trips t
    join users c
    on t.client_id = c.users_id
    and c.banned = 'No' and c.role = 'client'
    join users d
    on t.driver_id = d.users_id
    and d.banned = 'No' and d.role = 'driver'
    where t.request_at between '2013-10-01' and '2013-10-03'
)
select 
request_at as 'Day',
round(
    sum(
        case
            when status in ('cancelled_by_driver', 'cancelled_by_client') then 1
            else 0
        end
    ) / count(*), 2
) as 'Cancellation Rate'
from can_s
group by request_at;