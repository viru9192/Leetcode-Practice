select player_id, min(event_date) as first_login
from activity
group by player_id
order by first_login asc;