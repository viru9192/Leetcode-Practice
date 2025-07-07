select name 
from employee
where id in (
    select managerid 
    from employee
    where managerid is not null
    group by managerid 
    having count(*) >= 5
);