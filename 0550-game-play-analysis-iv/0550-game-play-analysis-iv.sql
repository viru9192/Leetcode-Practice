with f_log as (
    select
    player_id,
    min(event_date) as flogin
    from activity 
    group by player_id
)
select
round (
    count(distinct a.player_id) /
    (
        select 
        count(distinct player_id)
        from activity 
    ), 2
) as fraction
from activity a
join f_log f
on a.player_id = f.player_id
and datediff(a.event_date, f.flogin) = 1;