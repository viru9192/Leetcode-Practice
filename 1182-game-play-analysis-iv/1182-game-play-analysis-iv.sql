select
round(
    count(distinct a.player_id) /
    (
        select count(distinct player_id) from activity
    ), 2
) as fraction
from activity a
join (
    select
    player_id,
    min(event_date) as f_login
    from activity
    group by player_id
) as first
on a.player_id = first.player_id
where 
datediff(a.event_date, first.f_login) = 1;