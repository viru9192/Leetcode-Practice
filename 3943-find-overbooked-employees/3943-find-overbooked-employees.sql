WITH meeting_weeks AS (
  SELECT
    m.employee_id,
    DATE_SUB(m.meeting_date, INTERVAL WEEKDAY(m.meeting_date) DAY) AS week_start,
    SUM(m.duration_hours) AS total_weekly_meeting_hours
  FROM meetings m
  GROUP BY m.employee_id, DATE_SUB(m.meeting_date, INTERVAL WEEKDAY(m.meeting_date) DAY)
),
meeting_heavy_weeks AS (
  SELECT
    employee_id,
    week_start
  FROM meeting_weeks
  WHERE total_weekly_meeting_hours > 20
),
meeting_heavy_counts AS (
  SELECT
    employee_id,
    COUNT(*) AS meeting_heavy_weeks
  FROM meeting_heavy_weeks
  GROUP BY employee_id
  HAVING COUNT(*) >= 2
)
SELECT
  e.employee_id,
  e.employee_name,
  e.department,
  mhc.meeting_heavy_weeks
FROM meeting_heavy_counts mhc
JOIN employees e ON e.employee_id = mhc.employee_id
ORDER BY mhc.meeting_heavy_weeks DESC, e.employee_name ASC;
