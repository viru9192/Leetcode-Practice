WITH daily AS (
  SELECT visited_on, SUM(amount) AS amount
  FROM customer
  GROUP BY visited_on
),
roll AS (
  SELECT
    visited_on,
    SUM(amount) OVER (
      ORDER BY visited_on
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS amount,
    AVG(amount) OVER (
      ORDER BY visited_on
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS avg_amount,
    COUNT(*) OVER (
      ORDER BY visited_on
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS cnt
  FROM daily
)
SELECT
  visited_on,
  amount,
  ROUND(avg_amount, 2) AS average_amount
FROM roll
WHERE cnt = 7
ORDER BY visited_on;
