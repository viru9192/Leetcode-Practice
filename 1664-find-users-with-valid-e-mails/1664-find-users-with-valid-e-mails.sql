select *
from users
where
mail regexp '^[A-Za-z][A-Za-z0-9._-]*@leetcode\\.com$'
and binary mail like '%@leetcode.com';