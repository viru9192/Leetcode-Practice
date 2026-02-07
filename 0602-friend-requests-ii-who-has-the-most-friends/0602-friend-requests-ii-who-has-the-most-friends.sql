with counts as (
    select
    id,
    count(*) as num
    from (
        select
        requester_id as id
        from requestaccepted

        union all

        select 
        accepter_id as id
        from requestaccepted
    ) as friends
    group by id
)
select 
id,
num
from counts
order by num desc
limit 1;