-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table title.
TRUNCATE TABLE artists RESTART IDENTITY; -- replace with your own table title.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES ('Red', '2010', '3');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Carter 2', '2008', '1');
INSERT INTO artists (name, genre) VALUES ('Lil Wayne', 'Rap');
INSERT INTO artists (name, genre) VALUES ('Taylor Swift', 'Pop');



