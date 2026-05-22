with friend as (
    select 
    requester_id as id
    from requestaccepted

    union all

    select
    accepter_id as id
    from requestaccepted
),
total as (
    select
    id,
    count(*) as total_frd
    from friend
    group by id
)
select
id, 
total_frd as num
from total
order by num desc
limit 1;