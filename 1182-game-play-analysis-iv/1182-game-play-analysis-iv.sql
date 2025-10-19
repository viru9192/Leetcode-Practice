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
    min(event_date) as first_l
    from activity
    group by player_id
) as first_p
on a.player_id = first_p.player_id
where datediff(a.event_date, first_p.first_l) = 1;