-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)
-- Write your SQL seed here.
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)
TRUNCATE TABLE users RESTART IDENTITY CASCADE; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO users (username, email) VALUES ('shahhussain', 'shah@test.com');
INSERT INTO users (username, email) VALUES ('ishowspeed', 'speed@test.com');

-- psql -h 127.0.0.1 social_network_test < seeds_users.sql