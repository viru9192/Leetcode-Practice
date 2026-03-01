select
round(
    count(distinct a.player_id) / (
        select
        count(distinct player_id) as player
        from activity
    ), 2
) as fraction 
from activity a
join (
    select
    player_id,
    min(event_date) as f_login
    from activity
    group by player_id
) as fl
on a.player_id = fl.player_id
and datediff(a.event_date, fl.f_login) = 1;