select (
    select
    num
    from myNumbers
    group by num
    having count(*) = 1
    order by num desc
    limit 1
) as num;