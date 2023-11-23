-- IDENTIFY MOST POPULAR PHOTO (AND USER WHO CREATED IT)

SELECT username, photos.id, photos.image_url, COUNT(*) AS total FROM photos
JOIN likes ON photos.id = likes.photo_id
JOIN users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESc
LIMIT 1;