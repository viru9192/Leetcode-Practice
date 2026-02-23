WITH total_stats AS (
    SELECT
        user_id,
        COUNT(*) AS total_reactions,
        COUNT(DISTINCT content_id) AS content_cnt
    FROM reactions
    GROUP BY user_id
),

reaction_counts AS (
    SELECT
        user_id,
        reaction,
        COUNT(*) AS reaction_count
    FROM reactions
    GROUP BY user_id, reaction
),

ranked_reactions AS (
    SELECT
        r.user_id,
        r.reaction,
        r.reaction_count,
        t.total_reactions,
        t.content_cnt,
        ROUND(r.reaction_count * 1.0 / t.total_reactions, 2) AS reaction_ratio,
        ROW_NUMBER() OVER (
            PARTITION BY r.user_id
            ORDER BY r.reaction_count DESC
        ) AS rn
    FROM reaction_counts r
    JOIN total_stats t
        ON r.user_id = t.user_id
)

SELECT
    user_id,
    reaction AS dominant_reaction,
    reaction_ratio
FROM ranked_reactions
WHERE rn = 1
  AND content_cnt >= 5
  AND reaction_ratio >= 0.6
ORDER BY reaction_ratio DESC, user_id ASC;