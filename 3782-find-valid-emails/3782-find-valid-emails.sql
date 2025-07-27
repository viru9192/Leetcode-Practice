select *
from users 
where
email regexp '^[A-Za-z0-9_]+@[A-za-z]+\\.com$'
order by user_id;