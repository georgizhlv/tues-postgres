-- Question 1: the last 20 messages in #general, newest first (time, user, text)
SELECT m.created_at, u.username, m.content
FROM messages m
JOIN users u ON u.id = m.user_id
JOIN channels c ON c.id = m.channel_id
WHERE c.name = 'general'
ORDER BY m.created_at DESC
LIMIT 20;

-- Question 2: how many messages each user has written, users with 0 included
SELECT u.username, COUNT(m.id) AS message_count
FROM users u
LEFT JOIN messages m ON m.user_id = u.id
GROUP BY u.id, u.username
ORDER BY message_count DESC;
