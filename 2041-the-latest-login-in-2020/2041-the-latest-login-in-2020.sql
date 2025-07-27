select user_id, time_stamp as last_stamp
from logins l
where year(time_stamp) = '2020'
and not exists (
    select * 
    from logins l1
    where l.user_id = l1.user_id 
    and 
    year(l1.time_stamp) = '2020'
    and
    l1.time_stamp > l.time_stamp
);