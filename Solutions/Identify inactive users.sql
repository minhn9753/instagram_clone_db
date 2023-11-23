-- IDENTIFY INACTIVE USERS (USERS WITH NO PHOTOS)

SELECT users.id, username, IFNULL(image_url, 0) AS number_of_posts
FROM users
LEFT JOIN photos 
ON users.id = photos.user_id
WHERE image_url IS NULL;