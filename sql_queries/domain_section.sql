-- User-defined data types

-- CREATE DOMAIN data types
-- 1. Create domain statement creates a user-defined data type with range, optional DEFAULT, NOT NULL and CHECK constraint.
-- 2. They have to be unique within a schema scope. Cannot be re-used of scope where they are defined.
-- 3. Help to STANDERDIZE your database types in one place.
-- 4. A domain data type is a COMMON data type and can be RE-USE in multiple columns. Write once and share everywhere.
-- 5. NULL is default.
-- 6. Composite Type: Only single Value return.

-- CREATE DOMAIN name AS data_type constraint

CREATE DOMAIN addr VARCHAR(100) NOT NULL


CREATE TABLE locations (
  address addr
);


CREATE DOMAIN positive_numeric INT NOT NULL CHECK (VALUE > 0);

CREATE TABLE sample(
  sample_id SERIAL PRIMARY KEY,
  sample_value positive_numeric
)


INSERT INTO sample (sample_value) VALUES (10);

INSERT INTO sample (sample_value) VALUES (-5); -- This will fail due to CHECK

SELECT * FROM sample;


CREATE DOMAIN us_postal_code AS VARCHAR(10) NOT NULL
  CHECK (
    VALUE ~ '^\d{5}$'
    OR VALUE ~ '^\d{5}(-\d{4})?$'
  );

CREATE TABLE addresses (
  id SERIAL PRIMARY KEY,
  postal_code us_postal_code
);

INSERT INTO addresses (postal_code) VALUES ('12345');

INSERT INTO addresses (postal_code) VALUES ('12345-6789');

INSERT INTO addresses (postal_code) VALUES ('1234'); -- This will fail due to CHECK ( condition )

CREATE DOMAIN proper_email AS VARCHAR(255) NOT NULL
  CHECK (
    VALUE ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );

CREATE TABLE client_names (
  id SERIAL PRIMARY KEY,
  email proper_email
);

INSERT INTO client_names (email) VALUES ('A@email.com');

INSERT INTO client_names (email) VALUES ('invalid-email'); -- This will fail due to CHECK ( condition )

-- Create an Enumeration Type (Enum or Set Of Values) domain

CREATE DOMAIN order_status AS VARCHAR(20) NOT NULL
  CHECK (VALUE IN ('pending', 'shipped', 'delivered', 'cancelled'));

CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  status order_status
);

INSERT INTO orders (status) VALUES ('pending');

INSERT INTO orders (status) VALUES ('shipped');

INSERT INTO orders (status) VALUES ('invalid_status'); -- This will fail due to CHECK ( condition )

-- Get all domain in a schema

-- SELECT typname
-- FROM pg_catalog.pg_type
-- JOIN pg_catalog.pg_namespace
-- ON pg_namespace.oid = pg_type.typnamespace
-- WHERE
-- typtype = 'd' AND nspname = 'public'; -- replace 'public' with your schema name

-- Drop a Domain data type
-- DROP DOMAIN domain_name;


DROP DOMAIN IF EXISTS addr;
-- This will fail if the domain is used in a table
DROP DOMAIN IF EXISTS addr CASCADE;
-- This will drop the domain and all dependent objects (rows, tables, etc.)


