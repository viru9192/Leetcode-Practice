WITH positives AS (
    SELECT 
        patient_id,
        test_date AS pos_date,
        ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY test_date) AS rn
    FROM covid_tests
    WHERE result = 'Positive'
),
negatives AS (
    SELECT 
        patient_id,
        test_date AS neg_date
    FROM covid_tests
    WHERE result = 'Negative'
),
paired AS (
    SELECT 
        p.patient_id,
        p.pos_date,
        MIN(n.neg_date) AS first_neg_date
    FROM positives p
    JOIN negatives n
      ON p.patient_id = n.patient_id
     AND n.neg_date > p.pos_date
    WHERE p.rn = 1   -- only the first positive per patient
    GROUP BY p.patient_id, p.pos_date
)
SELECT 
    pt.patient_id,
    pt.patient_name,
    pt.age,
    DATEDIFF(pr.first_neg_date, pr.pos_date) AS recovery_time
FROM paired pr
JOIN patients pt ON pt.patient_id = pr.patient_id
ORDER BY recovery_time ASC, pt.patient_name ASC;
