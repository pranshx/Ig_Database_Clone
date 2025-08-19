USE ig_clone;

-- TOPIC COVERED ---- Window functions, complex analytics

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