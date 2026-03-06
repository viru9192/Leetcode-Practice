with valid_s as (
    select
    t.request_at,
    t.status
    from trips t
    join users c 
    on t.client_id = c.users_id
        and c.role = 'client' and c.banned = 'No'
    join users d
    on t.driver_id = d.users_id
        and d.role = 'driver' and d.banned = 'No'
)
select
v.request_at as 'Day',
round(
    sum(
        case 
            when v.status in ('cancelled_by_driver', 'cancelled_by_client') then 1
            else 0
        end
    ) / count(*), 2
) as 'Cancellation Rate'
from valid_s v
where v.request_at between '2013-10-01' and '2013-10-03'
group by v.request_at;