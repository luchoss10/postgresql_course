-- A secuencie is a sequence is a database object that generates
-- a unique sequence of numbers, typically used as primary keys or unique identifiers in tables.                            
-- 1. Create a sequence
-- CREATE SEQUENCE IF NOT EXISTS name
-- CREATE SEQUENCE name

CREATE SEQUENCE IF NOT EXISTS test_seq;

-- 2. Advance sequence and return new value
-- SELECT nextval('name');

SELECT nextval('test_seq');

-- 3. Return most current value of the sequence
-- SELECT currval('name');

SELECT currval('test_seq');

-- 4. Set a sequence
-- SELECT setval('name', value);


SELECT setval('test_seq', 100);

-- 5. Set a sequence and do not skip over
-- SELECT setval('name', value, false);

SELECT setval('test_seq', 50, false);

-- 6. Control the sequence START value
-- CREATE SEQUENCE IF NOT EXISTS name START WITH value;
-- CREATE SEQUENCE name START WITH value;

CREATE SEQUENCE IF NOT EXISTS test_seq2 START WITH 100;


-- 7. Use multiple sequence parameters to create a SEQUENCE
-- CREATE A SEQUENCE name
-- START WITH value
-- INCREMENT BY value
-- MINVALUE value
-- MAXVALUE value

CREATE SEQUENCE IF NOT EXISTS test_seq3
INCREMENT BY 50
MINVALUE 400
MAXVALUE 5000
START WITH 500;

-- 8. Specify the data type of a sequence (SMALLINT| INT | BIGINT) 
-- DEFAULT is BIGINT
-- CREATE SEQUENCE IF NOT EXISTS name AS data_type;
-- CREATE SEQUENCE name AS data_type;

CREATE SEQUENCE IF NOT EXISTS test_seq4 AS SMALLINT;

-- 9. Create a Descending sequence and CYCLE | NO CYCLE
-- CREATE SEQUENCE seq_desc
-- INCREMENT -1
-- MINVALUE 1
-- MAXVALUE 3
-- START WITH 3 
-- CYCLE;

CREATE SEQUENCE seq_asc;

CREATE SEQUENCE seq_desc
INCREMENT -1
MINVALUE 1
MAXVALUE 3
START WITH 3
CYCLE;

-- 10. Alter a sequence
-- ALTER SEQUENCE name RESTART WITH value;
-- ALTER SEQUENCE name RENAME TO new_name;

SELECT nextval('test_seq2');

ALTER SEQUENCE test_seq2 RESTART WITH 200;
SELECT nextval('test_seq2');

ALTER SEQUENCE test_seq2 RENAME TO test_seq2_renamed;

-- 11. Delete/Drop a sequence
-- DROP SEQUENCE name;

DROP SEQUENCE IF EXISTS test_seq;

-- 12. Listing all sequences in a database
-- SELECT relname AS sequence_name
-- FROM pg_class
-- WHERE relkind = 'S';

SELECT relname AS sequence_name
FROM pg_class
WHERE relkind = 'S';

-- 13. Attaching sequence to a table
-- To attach a sequence to an existing table 
-- Step 1 > Create a sequence and attached to a table

CREATE TABLE users(
  user_id SERIAL PRIMARY KEY,
  usern_name VARCHAR(50)
)

INSERT INTO users (usern_name) VALUES ('user1'), ('user2');

SELECT * FROM users;

ALTER SEQUENCE users_user_id_seq RESTART WITH 100;

CREATE TABLE users2(
  user2_id PRIMARY KEY,
  user2_name VARCHAR(50)
)
-- CREATE SEQUENCE name
-- START WITH value OWNED BY table_name.column_name;

CREATE SEQUENCE users2_user2_id_seq
START WITH 100 OWNED BY users2.user2_id;

-- Step 2 > Alter table column and set sequence
-- ALTER TABLE table_name
-- ALTER COLUMN column_name SET DEFAULT nextval('sequence_name');


ALTER TABLE users2
ALTER COLUMN user2_id SET DEFAULT nextval('users2_user2_id_seq');

INSERT INTO users2 (user2_name) VALUES ('user3'), ('user4');

SELECT * FROM users2;


-- 15. Share sequence among tables

CREATE SEQUENCE shared_seq START WITH 100;

CREATE TABLE apples(
  fruit_id INT DEFAULT nextval('shared_seq'),
  fruit_name VARCHAR(50)
);

CREATE TABLE oranges(
  fruit_id INT DEFAULT nextval('shared_seq'),
  fruit_name VARCHAR(50)
);

INSERT INTO apples (fruit_name) VALUES ('apple1'), ('apple2');

INSERT INTO oranges (fruit_name) VALUES ('orange1'), ('orange2');

SELECT * FROM apples; -- fruit_id will be 100, 101
SELECT * FROM oranges; -- fruit_id will be 102, 103

-- How to create an Alpha-numeric sequence

-- By default sequences are only consist of numbers.
-- First, lets see how normally sequence are worked

-- Create a table with SERIAL data type for sequene

CREATE TABLE contacts (
  contact_id SERIAL PRIMARY KEY,
  contact_name VARCHAR(150)
);

-- Insert some data, and see the sequence

INSERT INTO contacts (contact_name) VALUES ('John Doe'), ('Jane Smith');

SELECT * FROM contacts;

-- How, Drop the Table

DROP TABLE IF EXISTS contacts;

-- Create a sequence

CREATE SEQUENCE alpha_numeric_seq

CREATE TABLE contacts (
  contact_id TEXT NOT NULL DEFAULT (
    'ID' || nextval('alpha_numeric_seq')
  ),
  contact_name VARCHAR(150)
);


-- Alter Sequence and attached to table column

ALTER SEQUENCE alpha_numeric_seq OWNED BY contacts.contact_id;

-- Insert some data

INSERT INTO contacts (contact_name) VALUES ('John Doe'), ('Jane Smith');

SELECT * FROM contacts;
