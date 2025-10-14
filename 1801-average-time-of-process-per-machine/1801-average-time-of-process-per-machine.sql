select
a.machine_id,
round(
    avg(
        b.timestamp - a.timestamp
    ), 3
) as processing_time
from activity a
join activity b
on a.machine_id = b.machine_id
where b.activity_type = 'end' and a.activity_type = 'start'
group by a.machine_id;