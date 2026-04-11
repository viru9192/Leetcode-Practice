with frd as (
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
    count(*) as num
    from frd
    group by id
)
select 
id, 
num
from total 
order by num desc
limit 1;