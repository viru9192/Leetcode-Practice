with recursive
temp1 as (
  select
    content_id,
    content_text,
    char_length(content_text) as len,
    1 as id
  from user_content
  union all
  select
    content_id,
    content_text,
    len,
    id + 1
  from temp1
  where id < len
),
temp2 as (
  select
    content_id,
    content_text,
    len,
    id,
    substring(content_text, id, 1) as text
  from temp1
),
temp3 as (
  select
    content_id,
    content_text,
    len,
    id,
    lag(text) over (partition by content_id order by id) as prev,
    text
  from temp2
),
temp4 as (
  select
    content_id,
    id,
    content_text,
    len,
    prev,
    case
      when prev is null or prev = ' ' or prev = '-' then upper(text)
      when (prev between 'a' and 'z' or prev between 'A' and 'Z')
           and text between 'A' and 'Z' then lower(text)
      else text
    end as next
  from temp3
)
select
  content_id,
  content_text as original_text,
  group_concat(next order by id separator '') as converted_text
from temp4
group by content_id, content_text
order by content_id;