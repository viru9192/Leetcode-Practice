with posit as (
    select 
    patient_id,
    test_date as pos,
    row_number() over (partition by patient_id order by test_date) as rn
    from covid_tests
    where result = 'Positive'
),
negat as (
    select
    patient_id,
    test_date as neg
    from covid_tests
    where result = 'Negative'
),
pair as (
    select 
    p.patient_id,
    p.pos,
    min(n.neg) as first_neg
    from posit p
    join negat n
    on p.patient_id = n.patient_id
    and n.neg > p.pos
    where rn = 1
    group by p.patient_id, p.pos
)
select 
pt.patient_id,
pt.patient_name,
pt.age,
datediff(pr.first_neg, pr.pos) as recovery_time
from patients pt
join pair pr
on pt.patient_id = pr.patient_id
order by recovery_time asc, pt.patient_name asc;