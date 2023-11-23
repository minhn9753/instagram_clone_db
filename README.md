1. I was trying to find the 5 oldest users, who have been around the longest:
----------------QUERY----------------
SELECT * 
FROM users 
ORDER BY created_at 
LIMIT 5;

+----+------------------+---------------------+
| id | username         | created_at          |
+----+------------------+---------------------+
| 80 | Darby_Herzog     | 2016-05-06 00:14:21 |
| 67 | Emilio_Bernier52 | 2016-05-06 13:04:30 |
| 63 | Elenor88         | 2016-05-08 01:30:41 |
| 95 | Nicole71         | 2016-05-09 17:30:22 |
| 38 | Jordyn.Jacobson2 | 2016-05-14 07:56:26 |
+----+------------------+---------------------+

--------------EXPLAINED--------------
- **SELECT *:**
  - Selects all columns (`*`) from the `users` table.

- **FROM users:**
  - Specifies the `users` table.

- **ORDER BY created_at:**
  - Orders the result set based on the `created_at` column ASC. 

- **LIMIT 5:**
  - Limits the output to only the first 5 rows.



2. I need to figure out what day of the week do most users register on?
----------------QUERY----------------
SELECT DAYNAME(created_at) AS day, 
	   COUNT(*) AS total
FROM users 
GROUP BY day 
ORDER BY total DESC
LIMIT 2;

+----------+-------+
| day      | total |
+----------+-------+
| Thursday |    16 | 
| Sunday   |    16 |
+----------+-------+

--------------EXPLAINED--------------
- **SELECT DAYNAME(created_at) AS day, COUNT(*) AS total:**
  - `DAYNAME(created_at) AS day`: Extracts the day name from the `created_at` timestamp column and aliases it as `day`.
  - `COUNT(*) AS total`: Counts the number of users for each day and aliases it as `total`.

- **FROM users:**
  - Specifies the main table from which the data is retrieved, in this case, the `users` table.

- **GROUP BY day:**
  - Groups the result set by the `day` column, which represents the extracted day names.

- **ORDER BY total DESC:**
  - Orders the result set by the total count in descending order.

- **LIMIT 2:**
  - Limits the result to the top 2 rows, effectively showing the two days with the highest user counts.



3. This query is to identify the users who have never posted a photo (inactive users with no photos):
----------------QUERY----------------
SELECT users.id, username, 
       IFNULL(image_url, 0) AS number_of_posts 
FROM users
LEFT JOIN photos 
ON users.id = photos.user_id
WHERE image_url IS NULL;

+----+---------------------+-----------------+
| id | username            | number_of_posts |
+----+---------------------+-----------------+
|  5 | Aniya_Hackett       | 0               |
| 83 | Bartholome.Bernhard | 0               |
| 91 | Bethany20           | 0               |
| 80 | Darby_Herzog        | 0               |
| 45 | David.Osinski47     | 0               |
| 54 | Duane60             | 0               |
| 90 | Esmeralda.Mraz57    | 0               |
| 81 | Esther.Zulauf61     | 0               |
| 68 | Franco_Keebler64    | 0               |
| 74 | Hulda.Macejkovic    | 0               |
| 14 | Jaclyn81            | 0               |
| 76 | Janelle.Nikolaus81  | 0               |
| 89 | Jessyca_West        | 0               |
| 57 | Julien_Schmidt      | 0               |
|  7 | Kasandra_Homenick   | 0               |
| 75 | Leslie67            | 0               |
| 53 | Linnea59            | 0               |
| 24 | Maxwell.Halvorson   | 0               |
| 41 | Mckenna17           | 0               |
| 66 | Mike.Auer39         | 0               |
| 49 | Morgan.Kassulke     | 0               |
| 71 | Nia_Haag            | 0               |
| 36 | Ollie_Ledner37      | 0               |
| 34 | Pearl7              | 0               |
| 21 | Rocio33             | 0               |
| 25 | Tierra.Trantow      | 0               |
+----+---------------------+-----------------+

--------------EXPLAINED--------------
- **SELECT users.id, username, IFNULL(image_url, 0) AS number_of_posts:**
  - `users.id`: Column from the `users` table representing the user ID.
  - `username`: Column from the `users` table representing the username.
  - `IFNULL(image_url, 0) AS number_of_posts`: Uses `IFNULL` to replace `NULL` values with 0 for the `image_url` column from the `photos` table.

- **FROM users:**
  - Specifies the `users` table.

- **LEFT JOIN photos ON users.id = photos.user_id:**
  - Performs a left join between the `users` and `photos` tables based on the condition that the `id` column in the `users` table matches the `user_id` column in the `photos` table.
  - This join includes all users, even those who haven't posted any photos.

- **WHERE image_url IS NULL:**
  - Filters the result set to include only those rows where the `image_url` is `NULL` or 0, indicating users who haven't posted any photos.



4. Who can get the most likes on a single photo? (Identify the most popular photo and its owner)
----------------QUERY----------------
SELECT username, 
       photos.id, 
	   photos.image_url, 
	   COUNT(*) AS total 
FROM photos
JOIN likes ON photos.id = likes.photo_id
JOIN users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESc
LIMIT 1;

+---------------+-----+---------------------+-------+
| username      | id  | image_url           | total |
+---------------+-----+---------------------+-------+
| Zack_Kemmer93 | 145 | https://jarret.name |    48 |
+---------------+-----+---------------------+-------+

--------------EXPLAINED--------------
- **SELECT username, photos.id, photos.image_url, COUNT(*) AS total:**
  - `username`: Column from the `users` table.
  - `photos.id`, `photos.image_url`: Columns from the `photos` table.
  - `COUNT(*) AS total`: Counts the number of likes for each photo and aliases the result as `total`.

- **FROM photos:**
  - Specifies the `photos` table.

- **JOIN likes ON photos.id = likes.photo_id:**
  - Performs an inner join between the `photos` and `likes` tables based on the condition that the `id` column in the `photos` table matches the `photo_id` column in the `likes` table.
  - This join links photos to their corresponding likes.

- **JOIN users ON photos.user_id = users.id:**
  - Performs an inner join between the `photos` and `users` tables based on the condition that the `user_id` column in the `photos` table matches the `id` column in the `users` table.
  - This join links photos to their respective users.

- **GROUP BY photos.id:**
  - Groups the result set by the `id` column in the `photos` table.
  - This is necessary when using aggregate functions like `COUNT()`.

- **ORDER BY total DESC:**
  - Orders the result set in descending order based on the total count of likes for each photo.

- **LIMIT 1:**
  - Limits the output to only the first row, which corresponds to the photo with the highest number of likes.



5. Identify how many times does the average user post? Calculate average number of photos per user
----------------QUERY----------------
SELECT 
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg;
	
+--------+
| avg    |
+--------+
| 2.5700 |
+--------+

--------------EXPLAINED--------------
- **SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg:**
  - Calculates the average by dividing the total number of photos by the total number of users.
  - `SELECT COUNT(*) FROM photos`: Subquery that counts the total number of rows in the `photos` table, representing the total number of photos.
  - `SELECT COUNT(*) FROM users`: Subquery that counts the total number of rows in the `users` table, representing the total number of users.
  - The division is performed between these two counts.
  - The result is aliased as `avg`.



6. What are the top 5 most commonly used hashtags?
----------------QUERY----------------
SELECT tag_name, 
       COUNT(*) AS count 
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tag_name
ORDER BY count DESC
LIMIT 5;

+----------+-------+
| tag_name | count |
+----------+-------+
| smile    |    59 |
| beach    |    42 |
| party    |    39 |
| fun      |    38 |
| concert  |    24 |
+----------+-------+

--------------EXPLAINED--------------
- **SELECT tag_name, COUNT(*) AS count:**
  - `tag_name`: Column from the `tags` table representing the tag name.
  - `COUNT(*) AS count`: Counts the number of occurrences for each tag and aliases the result as `count`.

- **FROM tags:**
  - Specifies the `tags` table.

- **JOIN photo_tags ON tags.id = photo_tags.tag_id:**
  - Performs an inner join between the `tags` and `photo_tags` tables based on the condition that the `id` column in the `tags` table matches the `tag_id` column in the `photo_tags` table.
  - This join links tags to their associated photos.

- **GROUP BY tag_name:**
  - Groups the result set by the `tag_name` column in the `tags` table.
  - This is necessary when using aggregate functions like `COUNT()`.

- **ORDER BY count DESC:**
  - Orders the result set in descending order based on the count of photos associated with each tag.

- **LIMIT 5:**
  - Limits the output to only the top 5 rows, representing the tags with the highest counts.



7. Find users who have liked every single photo on the site. In many real scenarios, we need to find bots (users):
----------------QUERY----------------
SELECT username, 
       COUNT(*) AS count 
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY username
HAVING count = (SELECT COUNT(*) FROM photos);

+--------------------+-------+
| username           | count |
+--------------------+-------+
| Aniya_Hackett      |   257 |
| Bethany20          |   257 |
| Duane60            |   257 |
| Jaclyn81           |   257 |
| Janelle.Nikolaus81 |   257 |
| Julien_Schmidt     |   257 |
| Leslie67           |   257 |
| Maxwell.Halvorson  |   257 |
| Mckenna17          |   257 |
| Mike.Auer39        |   257 |
| Nia_Haag           |   257 |
| Ollie_Ledner37     |   257 |
| Rocio33            |   257 |
+--------------------+-------+

--------------EXPLAINED--------------
- **SELECT username, COUNT(*) AS count:**
  - `username`: Column from the `users` table representing the username.
  - `COUNT(*) AS count`: Counts the number of likes for each user.

- **FROM users:**
  - Specifies the main table from which the data is retrieved, in this case, the `users` table.

- **JOIN likes ON users.id = likes.user_id:**
  - Performs an inner join between the `users` and `likes` tables based on the condition that the `id` column in the `users` table matches the `user_id` column in the `likes` table.
  - This join links users to their associated likes.

- **GROUP BY username:**
  - Groups the result set by the `username` column in the `users` table.
  - This is necessary when using aggregate functions like `COUNT()`.

- **HAVING count = (SELECT COUNT(*) FROM photos):**
  - Filters the result set to include only those rows where the count of likes matches the total count of photos in the `photos` table.



8. Find users who never likes a single photo:
----------------QUERY----------------
SELECT users.id, 
       IFNULL(likes.photo_id, 0) AS photo_id 
FROM users
LEFT JOIN likes ON users.id = likes.user_id 
WHERE photo_id IS NULL
ORDER BY users.id;

+----+----------+
| id | photo_id |
+----+----------+
|  1 |        0 |
|  7 |        0 |
| 23 |        0 |
| 25 |        0 |
| 29 |        0 |
| 34 |        0 |
| 45 |        0 |
| 49 |        0 |
| 51 |        0 |
| 53 |        0 |
| 58 |        0 |
| 59 |        0 |
| 64 |        0 |
| 68 |        0 |
| 74 |        0 |
| 77 |        0 |
| 80 |        0 |
| 81 |        0 |
| 83 |        0 |
| 86 |        0 |
| 88 |        0 |
| 89 |        0 |
| 90 |        0 |
+----+----------+

--------------EXPLAINED--------------
- **SELECT users.id, IFNULL(likes.photo_id, 0) AS photo_id:**
  - `users.id`: Column from the `users` table representing the user ID.
  - `IFNULL(likes.photo_id, 0) AS photo_id`: Uses `IFNULL` to replace `NULL` values with 0 for the `photo_id` column from the `likes` table.

- **FROM users:**
  - Specifies the main table from which the data is retrieved, in this case, the `users` table.

- **LEFT JOIN likes ON users.id = likes.user_id:**
  - Performs a left join between the `users` and `likes` tables based on the condition that the `id` column in the `users` table matches the `user_id` column in the `likes` table.
  - This join includes all users, even those who haven't liked any photos.

- **WHERE photo_id IS NULL:**
  - Filters the result set to include only those rows where the `photo_id` is `NULL` or 0, indicating users who haven't liked any photos.

- **ORDER BY users.id:**
  - Orders the result set by the user ID in ascending order.
