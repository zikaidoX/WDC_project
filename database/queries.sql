
/* get club posts for users - only from clubs which the user has a membership as well as public posts - latest posts first*/
SELECT DISTINCT Club_Posts.id, Club_Posts.created, Club_Posts.content, Clubs.club_name FROM Club_Posts
INNER JOIN Clubs ON Club_Posts.club_id = Clubs.id
INNER JOIN Memberships ON Memberships.club_id = Clubs.id
WHERE Memberships.user_id = 1 OR Club_Posts.is_public = 0
ORDER BY Club_Posts.created DESC;

SELECT Club_Posts.id, Club_Posts.created, Club_Posts.content, Clubs.club_name FROM Club_Posts
INNER JOIN Clubs ON Club_Posts.club_id = Clubs.id
INNER JOIN Memberships ON Memberships.club_id = Clubs.id;
WHERE Club_Posts.content LIKE '%keyword%';
