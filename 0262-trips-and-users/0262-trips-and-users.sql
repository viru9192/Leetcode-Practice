with users as (
    select 
    t.client_id,
    t.driver_id,
    t.request_at,
    t.status
    from trips t
    join users c 
    on t.client_id = c.users_id 
        and c.role = 'client' and c.banned = 'No'
    join users d
    on t.driver_id = d.users_id 
        and d.role = 'driver' and d.banned = 'No'
    where request_at between '2013-10-01' and '2013-10-03'
)
select 
request_at as 'Day',
round(
    sum(
        case 
            when status in ('cancelled_by_driver', 'cancelled_by_client') then 1
            else 0
        end
    ) * 1.0 / count(*), 2
) as 'Cancellation Rate'
from users 
group by request_at;