select id, 
    case
    when p_id is null then 'Root'
    when p_id is not null and id in (
        select distinct p_id from tree where p_id is not null
    ) then 'Inner'
    else 'Leaf'
    end as type
from tree;