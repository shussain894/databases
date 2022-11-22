-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE public.books RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO books (id, title, author_name) VALUES ('1', 'Nineteen Eighty-Four', 'George Orwell' );
INSERT INTO books (id, title, author_name) VALUES ('2', 'Mrs Dalloway', 'Virginia Woolf' );
INSERT INTO books (id, title, author_name) VALUES ('3', 'Emma', 'Jane Austen' );
INSERT INTO books (id, title, author_name) VALUES ('4', 'Dracula', 'Bram Stoker' );
INSERT INTO books (id, title, author_name) VALUES ('5', 'The Age of Innocence', 'Edith Wharton' );
