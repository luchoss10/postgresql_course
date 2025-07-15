-- Introduction to constraints


-- 1. Contraints are like 'gate keppers'.
-- 2. Controls the kind of data goes into the database.
-- 3. Constraints are the rules enforced on data columns on a table.
-- 4. These are used to prevent invalid data from being entered into the database.
-- 5. They ensures the accuracy and realiability of the data in the database.
-- 6. Constraints can be added on
--    -Table 
--    -columns
-- 7. Column level constraints are applied only to one column
-- table level constraints are applied to the whole table.
-- 8. Types of Contraints.
--    - NOT NULL Field must have values.
--    - UNIQUE Field must have unique values.
--    - DEFAULT Field must have a default value.
--    - PRIMARY KEY Uniquely identifies each row/record in a database table.
--    - FOREIGN KEY Constrains data based on columns in other table.
--    - CHECK Checks all values meet specific criterias.

-- ALTER TABLE table_name
-- ALTER COLUMN column_name
-- SET NOT NULL;

-- ALTER TABLE table_name
-- ADD CONSTRAINT constraint_name UNIQUE(column_name, column_name, ...);

-- ALTER TABLE table_name
-- ALTER COLUMN column_name
-- SET DEFAULT default_value;

-- ALTER TABLE table_name
-- ALTER COLUMN column_name
-- DROP DEFAULT;


-- ALTER TABLE table_name
-- ADD PRIMARY KEY (column_name, column_name, ...);

-- ALTER TABLE table_name
-- ADD CONSTRAINT constraint_name
-- PRIMARY KEY (column_name, column_name, ...);

-- CREATE TABLE table_name (
--     column_name data_type PRIMARY KEY,
--     ...,
--     ...,
--     FOREIGN KEY (column_name) REFERENCES other_table(column_name)
-- );

-- ALTER TABLE table_name
-- DROP CONSTRAINT constraint_name;

-- ALTER TABLE table_name
-- ADD CONSTRAINT constraint_name
-- FOREIGN KEY (column_name) REFERENCES other_table(column_name);


-- Check Constraints
-- A CHECK constraint is a kind of contraint that allows you to specify if values in a column must meet a specific requirement.
-- The CHECK constraint uses a Boolean expression to evaluate the values before thay are inserted or updated to the column.
-- If the values pass the check PostgreSQL will insert or update these values to the column. Otherwise, PostgreSQL will reject the changes and issue a constraint violation error. 

-- Define CHECK constraint for new tables

CREATE TABLE staff (
  staff_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  birth_date DATE CHECK (birth_date > '1900-01-01'),
  join_date DATE CHECK (join_date >= birth_date),
  salary NUMERIC CHECK (salary > 0)
);

SELECT * FROM staff;

INSERT INTO staff (first_name, last_name, birth_date, join_date, salary)
VALUES ('John', 'Doe', '1985-05-15', '2020-01-01', 50000);

INSERT INTO staff (first_name, last_name, birth_date, join_date, salary)
VALUES ('Jane', 'Smith', '2000-01-01', '2021-06-15', 60000);

INSERT INTO staff (first_name, last_name, birth_date, join_date, salary)
VALUES ('Alice', 'Johnson', '1890-12-31', '2019-03-10', 70000); -- This will fail due to CHECK constraint on birth_date.

-- Define CHECK constraint for existing tables

-- ALTER TABLE table_name
-- ADD CONSTRAINT constraint_name CHECK (condition);

CREATE TABLE prices (
  price_id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  price NUMERIC NOT NULL,
  discount NUMERIC NOT NULL,
  valid_from DATE NOT NULL,
);

ALTER TABLE prices 
ADD CONSTRAINT check_price
CHECK (
  price > 0 AND 
  discount >= 0 AND 
  discount <= price AND 
);


INSERT INTO prices (product_id, price, discount, valid_from)
VALUES (1, 100.00, 10.00, '2023-01-01');

INSERT INTO prices (product_id, price, discount, valid_from)
VALUES (2, 200.00, 20.00, '2023-02-01');

INSERT INTO prices (product_id, price, discount, valid_from)
VALUES (3, 0.00, 5.00, '2023-03-01'); -- This will fail due to CHECK constraint on price.

-- Rename constraint on new table

ALTER TABLE staff
RENAME CONSTRAINT staff_birth_date_check TO check_birth_date;


ALTER TABLE prices
RENAME CONSTRAINT check_price TO check_prices_and_discount;

-- Drop CHECK constraint on existing table

ALTER TABLE prices
DROP CONSTRAINT check_prices_and_discount;
