select
name,
population,
area as 'area'
from world
where area >= 3000000 or population >= 25000000;