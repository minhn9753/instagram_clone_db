-- FINDING BOTS - USERS WHO HAVE LIKED EVERY SINGLE PHOTO

SELECT username, COUNT(*) AS count FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY username
HAVING count = (SELECT COUNT(*) FROM photos);