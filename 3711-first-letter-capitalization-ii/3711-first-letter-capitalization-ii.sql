WITH RECURSIVE
-- Build positions 1..len for every row
temp1 AS (
  SELECT
    content_id,
    content_text,
    CHAR_LENGTH(content_text) AS len,
    1 AS id
  FROM user_content
  UNION ALL
  SELECT
    content_id,
    content_text,
    len,
    id + 1
  FROM temp1
  WHERE id < len
),

-- Grab the character at each position
temp2 AS (
  SELECT
    content_id,
    content_text,
    len,
    id,
    SUBSTRING(content_text, id, 1) AS text
  FROM temp1
),

-- Previous character (NULL for first char)
temp3 AS (
  SELECT
    content_id,
    content_text,
    len,
    id,
    LAG(text) OVER (PARTITION BY content_id ORDER BY id) AS prev,
    text
  FROM temp2
),

-- Apply casing rules per the screenshot
temp4 AS (
  SELECT
    content_id,
    id,
    content_text,
    len,
    prev,
    CASE
      WHEN prev IS NULL OR prev = ' ' OR prev = '-'                 THEN UPPER(text)
      WHEN (prev BETWEEN 'A' AND 'Z' OR prev BETWEEN 'a' AND 'z')
           AND text BETWEEN 'A' AND 'Z'                              THEN LOWER(text)
      ELSE text
    END AS next
  FROM temp3
)

-- Reassemble the string
SELECT
  content_id,
  content_text AS original_text,
  GROUP_CONCAT(next ORDER BY id SEPARATOR '') AS converted_text
FROM temp4
GROUP BY content_id, content_text
ORDER BY content_id;
