create function getNthHighestSalary(n int) returns int
begin return (
    select max(salary)
    from employee e
    where (n-1) = (
        select 
        count(distinct(e1.salary)) 
        from employee e1
        where e1.salary > e.salary
    )
);
end