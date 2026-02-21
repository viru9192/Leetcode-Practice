with polarised as (
    select
    book_id,
    (max(session_rating) - min(session_rating)) as rating_spread,
    round (
        sum(
        case when session_rating >= 4 or session_rating <=2 then 1 else 0 end 
    ) / count(*) , 2
    ) as polarization_score
    from reading_sessions
    group by book_id
    having count(session_id) >= 5
    and max(session_rating) >= 4
    and min(session_rating) <= 2
)
select
b.book_id,
b.title,
b.author,
b.genre,
b.pages,
p.rating_spread,
p.polarization_score
from books b
join polarised p
on b.book_id = p.book_id
where p.polarization_score >= 0.6
order by p.polarization_score desc, b.title desc;