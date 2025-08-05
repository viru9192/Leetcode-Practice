WITH cte AS (
    SELECT 
        *, 
        distance_km / fuel_consumed AS fuel_efficiency
    FROM trips
),
cte2 AS (
    SELECT 
        c.driver_id, 
        d.driver_name, 
        AVG(CASE WHEN MONTH(trip_date) BETWEEN 1 AND 6 
                 THEN fuel_efficiency END) AS first_half_avg,
        AVG(CASE WHEN MONTH(trip_date) BETWEEN 7 AND 12 
                 THEN fuel_efficiency END) AS second_half_avg
    FROM cte AS c
    LEFT JOIN drivers AS d
        ON c.driver_id = d.driver_id
    GROUP BY c.driver_id, d.driver_name
)
SELECT 
    driver_id, 
    driver_name, 
    ROUND(first_half_avg, 2) AS first_half_avg,
    ROUND(second_half_avg, 2) AS second_half_avg,
    ROUND((second_half_avg - first_half_avg), 2) AS efficiency_improvement
FROM cte2
WHERE second_half_avg > first_half_avg
ORDER BY efficiency_improvement DESC, driver_name;
