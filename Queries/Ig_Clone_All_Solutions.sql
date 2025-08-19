USE ig_clone;

-- #TOPICS COVERED: "JOINS" ----  "WINDOW FUNCTION" ---- "SUBQUERY" ---- "AGGREGATION" ---- "DATE TIME"

-- BEGINNER

USE ig_clone;

-- 1. Show all users who signed up in 2016
SELECT username, created_at
FROM users
WHERE YEAR(created_at) = 2016;

-- 2. List all users who signed up, ordered by signup date
SELECT id, username, created_at
FROM users
ORDER BY created_at ASC;

-- 3. Find the most recent comment
SELECT comment_text, created_at
FROM comments
ORDER BY created_at DESC
LIMIT 1;

-- 4. Most Popular Registration Date
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;

-- INTERMEDIATE

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

-- ADVANCED

USE ig_clone;

-- 1. Find the user with the highest engagement rate
-- (engagement rate = (likes + comments) / total followers)
SELECT u.username,
       (IFNULL(like_count,0) + IFNULL(comment_count,0)) / NULLIF(follower_count,0) AS engagement_rate
FROM users u
LEFT JOIN (
    SELECT p.user_id, COUNT(l.user_id) AS like_count
    FROM photos p
    LEFT JOIN likes l ON p.id = l.photo_id
    GROUP BY p.user_id
) likes ON u.id = likes.user_id
LEFT JOIN (
    SELECT p.user_id, COUNT(c.id) AS comment_count
    FROM photos p
    LEFT JOIN comments c ON p.id = c.photo_id
    GROUP BY p.user_id
) comments ON u.id = comments.user_id
LEFT JOIN (
    SELECT followee_id, COUNT(follower_id) AS follower_count
    FROM follows
    GROUP BY followee_id
) followers ON u.id = followers.followee_id
ORDER BY engagement_rate DESC
LIMIT 1;

-- 2. Rank users by number of photos they posted (using RANK())
SELECT 
    users.username,
    COUNT(photos.id) AS total_photos,
    DENSE_RANK() OVER (ORDER BY COUNT(photos.id) DESC) AS photo_rank
FROM users
LEFT JOIN photos ON users.id = photos.user_id
GROUP BY users.id;