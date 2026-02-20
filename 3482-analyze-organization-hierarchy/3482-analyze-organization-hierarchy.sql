WITH RECURSIVE hierarchy AS (
   
    SELECT 
        employee_id,
        employee_name,
        manager_id,
        salary,
        department,
        1 AS level
    FROM Employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        e.department,
        h.level + 1
    FROM Employees e
    JOIN hierarchy h
        ON e.manager_id = h.employee_id
),

subordinates AS (
    SELECT 
        employee_id AS manager_id,
        employee_id AS subordinate_id
    FROM Employees

    UNION ALL

    SELECT 
        s.manager_id,
        e.employee_id
    FROM subordinates s
    JOIN Employees e
        ON e.manager_id = s.subordinate_id
)

SELECT 
    h.employee_id,
    h.employee_name,
    h.level,
    COUNT(s.subordinate_id) - 1 AS team_size,  
    SUM(e2.salary) AS budget
FROM hierarchy h
JOIN subordinates s
    ON h.employee_id = s.manager_id
JOIN Employees e2
    ON s.subordinate_id = e2.employee_id
GROUP BY 
    h.employee_id,
    h.employee_name,
    h.level
ORDER BY 
    h.level ASC,
    budget DESC,
    h.employee_name ASC;