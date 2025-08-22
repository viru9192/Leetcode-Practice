with counts as (
    select 
    id,
    count(*) as num
    from (
        select requester_id as id from RequestAccepted
        union all
        select accepter_id as id from RequestAccepted
) as friends
group by id
) 
select 
id,
num
from counts
where num = (select max(num) from counts);