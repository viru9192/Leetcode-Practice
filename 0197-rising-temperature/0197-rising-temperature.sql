select
w2.id
from weather w1
join weather w2
on datediff(w2.recorddate, w1.recorddate) = 1
and w2.temperature > w1.temperature;