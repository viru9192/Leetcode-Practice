create function getNthHighestSalary(N int) returns int
begin return (
    select
    salary 
    from (
        select 
        salary,
        dense_rank() over(
            order by salary desc
        ) as rnk
        from employee
    ) as ranked
    where rnk = N
    limit 1
);
end