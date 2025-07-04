select x, y, z, 
case 
    when (x + y <= z) or (y + z <= x) or (x + z <= y) then 'No'
    else 'Yes'
end as triangle
from triangle;