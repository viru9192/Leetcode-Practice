select 
case
    when s1.id % 2 = 1 and s2.id is not null then s1.id + 1
    when s1.id % 2 = 0 then s1.id - 1
    else s1.id
end as id,
s1.student
from seat s1
left join seat s2
on 
s1.id + 1 = s2.id
order by id;