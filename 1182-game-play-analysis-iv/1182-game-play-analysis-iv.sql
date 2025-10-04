select
round(
    count(distinct a.player_id) /
    (
        select 
        count(distinct player_id)
        from activity
    ), 2
) as fraction
from activity a
join (
    select
    player_id,
    min(event_date) as first_ld
    from activity
    group by player_id
) as first_log
on a.player_id = first_log.player_id
where
datediff(a.event_date, first_log.first_ld) = 1;