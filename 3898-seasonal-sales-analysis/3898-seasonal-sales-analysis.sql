WITH season_sales AS (
    SELECT 
        CASE 
            WHEN MONTH(s.sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(s.sale_date) BETWEEN 3 AND 5 THEN 'Spring'
            WHEN MONTH(s.sale_date) BETWEEN 6 AND 8 THEN 'Summer'
            WHEN MONTH(s.sale_date) BETWEEN 9 AND 11 THEN 'Fall'
        END AS season,
        p.category,
        SUM(s.quantity) AS total_quantity,
        SUM(s.quantity * s.price) AS total_revenue
    FROM sales s
    JOIN products p 
        ON s.product_id = p.product_id
    GROUP BY 
        CASE 
            WHEN MONTH(s.sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(s.sale_date) BETWEEN 3 AND 5 THEN 'Spring'
            WHEN MONTH(s.sale_date) BETWEEN 6 AND 8 THEN 'Summer'
            WHEN MONTH(s.sale_date) BETWEEN 9 AND 11 THEN 'Fall'
        END,
        p.category
),
ranked_sales AS (
    SELECT 
        season,
        category,
        total_quantity,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY season
            ORDER BY total_quantity DESC, total_revenue DESC
        ) AS rn
    FROM season_sales
)
SELECT 
    season,
    category,
    total_quantity,
    total_revenue
FROM ranked_sales
WHERE rn = 1
ORDER BY 
    CASE season
        WHEN 'Fall'   THEN 1
        WHEN 'Spring' THEN 2
        WHEN 'Summer' THEN 3
        WHEN 'Winter' THEN 4
    END;
