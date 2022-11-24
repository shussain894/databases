TRUNCATE TABLE users RESTART IDENTITY CASCADE; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO users (username, email) VALUES ('shahhussain', 'shah@test.com');
INSERT INTO users (username, email) VALUES ('ishowspeed', 'speed@test.com');
INSERT INTO posts (title, content, views, user_id) VALUES ('day1', 'makers', 5, '1');
INSERT INTO posts (title, content, views, user_id) VALUES ('day2', 'golden square', 10, '2');

-- psql -h 127.0.0.1 social_network_test < seeds_posts.sql
