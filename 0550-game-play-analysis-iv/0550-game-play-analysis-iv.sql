with f_login as (
    select
    player_id,
    min(event_date) as flog
    from activity 
    group by player_id
)
select 
round(
    count(distinct a.player_id) / (
        select 
        count(distinct player_id)
        from activity
    ), 2
) as fraction
from activity a
join f_login fl
on a.player_id = fl.player_id
    and datediff(a.event_date, fl.flog) = 1;