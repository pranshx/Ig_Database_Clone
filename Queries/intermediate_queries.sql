USE ig_clone;

-- TOPIC COVERED ---- Joins, subqueries, aggregation

-- 1. Finding Bots -- Users Who Have Liked Every Single Photo
SELECT username, Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) FROM   photos);

-- 2. Calculate Number Of Photos Posted By Each User
SELECT 
	username,
    COUNT(photos.id) AS photos_Posted
FROM users
LEFT JOIN photos
	ON photos.user_id = users.id
GROUP BY users.id
ORDER BY photos_Posted DESC;

-- 3. Most Popular Registration Date
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;

-- 4. Identify Inactive Users (Users Who Have Not Posted Any Photo Or Did Not Like Any Picture In LasT 10 Days)
SELECT users.username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
LEFT JOIN likes ON users.id = likes.user_id
GROUP BY users.id, users.username
HAVING COUNT(photos.id) = 0
   OR DATEDIFF(
        (SELECT MAX(DATE(created_at)) FROM likes),   -- global max like date
        MAX(DATE(likes.created_at))                  -- user’s last like date
      ) > 10;
      
-- 5. Identifying Most Popular Photo (And User Who Created It)

SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- 6. Calculate Average Number Of Post Per User
SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg; 
                          
-- Most Popular Hashtags
SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5;

-- 7. Calculate Number Of Photos Posted By Each User
SELECT 
	username,
    COUNT(photos.id) AS photos_Posted
FROM users
LEFT JOIN photos
	ON photos.user_id = users.id
GROUP BY users.id
ORDER BY photos_Posted DESC;
