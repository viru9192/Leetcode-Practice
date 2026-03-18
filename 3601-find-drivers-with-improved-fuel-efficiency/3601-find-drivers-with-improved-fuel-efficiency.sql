with cte as (
    select 
    *,
    (distance_km / fuel_consumed) as fuel_efficiency
    from trips
),
cte2 as (
    select 
    c.driver_id,
    d.driver_name,
    avg(case when month(trip_date) between 1 and 6 then c.fuel_efficiency end) as first_half_avg,
    avg(case when month(trip_date) between 7 and 12 then c.fuel_efficiency end) as second_half_avg
    from cte c
    left join drivers d
    on
    c.driver_id = d.driver_id
    group by c.driver_id, d.driver_name
)
select 
driver_id,
driver_name,
round(first_half_avg, 2) as first_half_avg,
round(second_half_avg, 2) as second_half_avg,
round((second_half_avg - first_half_avg), 2) as efficiency_improvement
from cte2
where second_half_avg > first_half_avg
order by efficiency_improvement desc, driver_name asc;