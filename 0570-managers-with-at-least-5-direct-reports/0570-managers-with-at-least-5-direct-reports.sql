SELECT m.name
FROM employee e
JOIN employee m ON e.managerid = m.id
GROUP BY m.id, m.name
HAVING COUNT(*) >= 5;
