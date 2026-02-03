select
round(
    count(distinct a.player_id) / (
        select 
        count(distinct player_id) as cnt
        from activity
    ), 2
) as fraction
from activity a
join (
    select
    player_id,
    min(event_date) as flogin
    from activity
    group by player_id
) as fl
on a.player_id = fl.player_id
and datediff(a.event_date, fl.flogin) = 1;