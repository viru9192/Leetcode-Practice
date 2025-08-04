WITH ranked_reviews AS (
    SELECT 
        pr.employee_id,
        pr.review_date,
        pr.rating,
        ROW_NUMBER() OVER (PARTITION BY pr.employee_id ORDER BY pr.review_date DESC) AS rn
    FROM performance_reviews pr
),
last_three AS (
    SELECT 
        employee_id,
        MAX(CASE WHEN rn = 1 THEN rating END) AS r1,  -- most recent
        MAX(CASE WHEN rn = 2 THEN rating END) AS r2,
        MAX(CASE WHEN rn = 3 THEN rating END) AS r3
    FROM ranked_reviews
    WHERE rn <= 3
    GROUP BY employee_id
),
qualified AS (
    SELECT 
        e.employee_id,
        e.name,
        (r1 - r3) AS improvement_score
    FROM last_three lt
    JOIN employees e ON e.employee_id = lt.employee_id
    WHERE r1 > r2 AND r2 > r3   -- strictly increasing
)
SELECT 
    employee_id,
    name,
    improvement_score
FROM qualified
ORDER BY improvement_score DESC, name ASC;
