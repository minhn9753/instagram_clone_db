-- FIVE MOST POPULAR HASHTAGS

SELECT tag_name, COUNT(*) AS count FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tag_name
ORDER BY count DESC
LIMIT 5;