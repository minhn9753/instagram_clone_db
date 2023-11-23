-- FIND USERS WHO NEVER LIKES A SINGLE PHOTO

SELECT users.id, IFNULL(likes.photo_id, 0) AS photo_id FROM users
LEFT JOIN likes ON users.id = likes.user_id 
WHERE photo_id IS NULL
ORDER BY users.id;