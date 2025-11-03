select results from (
    select
    u.name as results
    from users u
    join movierating mr
    on u.user_id = mr.user_id
    group by u.user_id, u.name
    order by count(*) desc, u.name asc
    limit 1
) as user_m

union all

select results from (
    select 
    m.title as results
    from movies m
    join movierating mr
    on m.movie_id = mr.movie_id
    where year(mr.created_at) = 2020 and month(mr.created_at) = '02' 
    group by m.movie_id, m.title
    order by avg(mr.rating) desc, m.title asc
    limit 1
) as movie_r;