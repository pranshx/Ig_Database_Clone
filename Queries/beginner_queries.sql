USE ig_clone;

-- TOPIC COVERED ---- Date functions, basic filtering, sorting

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

