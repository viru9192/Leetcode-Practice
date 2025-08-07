with meet_w as (
    select 
    m.employee_id,
    date_sub(m.meeting_date, interval weekday(m.meeting_date) day) as week_start,
    sum(m.duration_hours) as meet_hour
    from meetings m
    group by m.employee_id,
    date_sub(m.meeting_date, interval weekday(m.meeting_date) day)
),
meet_heavy as (
    select 
    employee_id,
    week_start
    from meet_w
    where meet_hour > 20

),
meet_count as (
    select 
    employee_id,
    count(*) as meet_h
    from meet_heavy
    group by employee_id
    having count(*) >= 2
)
select 
e.employee_id,
e.employee_name,
e.department,
mc.meet_h as meeting_heavy_weeks
from meet_count mc
join employees e
on mc.employee_id = e.employee_id
order by meeting_heavy_weeks desc, e.employee_name asc;