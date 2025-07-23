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

-- 13. Attaching sequence to a table
-- To attach a sequence to an existing table 
-- Step 1 > Create a sequence and attached to a table

-- CREATE SEQUENCE name
-- START WITH value OWNED BY table_name.column_name;


-- Step 2 > Alter table column and set sequence
-- ALTER TABLE table_name
-- ALTER COLUMN column_name SET DEFAULT nextval('sequence_name');



