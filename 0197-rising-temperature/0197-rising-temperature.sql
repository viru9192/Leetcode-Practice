select w1.id as Id
from weather w1
join weather w2
on
date(w1.recordDate) = date_add(date(w2.recordDate), interval 1 day)
where 
w1.temperature > w2.temperature;