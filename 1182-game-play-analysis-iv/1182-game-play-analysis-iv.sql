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
    min(event_date) as f_login
    from activity
    group by player_id
) as md
on a.player_id = md.player_id
and datediff(a.event_date, md.f_login) = 1;