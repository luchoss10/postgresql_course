-- Composite data types
-- 1. List of field names with corresponding data types.
-- 2. Used in a table as a 'column'.
-- 3. Used in functions or procedures.
-- 4. Can return multiple values, its a composite data type.

-- CREATE TYPE name AS (fields columns_properties);

-- Example #1: Create a address composite data type.

CREATE TYPE address AS (
  city VARCHAR(50),
  state VARCHAR(20),
  country VARCHAR(20),
);


CREATE TABLE companies (
  id SERIAL PRIMARY KEY,
  address address
);


INSERT INTO companies (address) VALUES (
  ROW('New York', 'NY', 'USA')
);

SELECT * FROM companies;
SELECT address FROM companies;
SELECT (address).country FROM companies;

CREATE TYPE currency AS ENUM(
  'USD',
  'EUR',
  'COP',
);


CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  price NUMERIC(10, 2) NOT NULL,
  currency currency NOT NULL
);

SELECT 'USD'::currency AS currency_example;

ALTER TYPE currency ADD VALUE 'GBP' AFTER 'EUR';

INSERT INTO products (name, price, currency) VALUES (
  'Laptop',
  999.99,
  'USD'
);


SELECT * FROM products;

DROP TYPE address;

DROP TYPE currency;

-- Alter Data types

CREATE TYPE myaddress(
  city VARCHAR(50),
  country VARCHAR(50)
)

-- Rename a data types
-- ALTER TYPE name RENAME TO new_name;

ALTER TYPE myaddress RENAME TO my_address;

-- Change the owner
-- ALTER TYPE name OWNER TO new_owner;

ALTER TYPE my_address OWNER TO postgres;

-- Change the schema
-- ALTER TYPE name SET SCHEMA new_schema;

ALTER TYPE my_address SET SCHEMA public;

-- To add a new atribute
-- ALTER TYPE name ADD ATTRIBUTE atribute_name data_type;

ALTER TYPE my_address ADD ATTRIBUTE state VARCHAR(20);

-- Alter an ENUM data type

-- Create a sample ENUM data type
-- CREATE TYPE name AS ENUM('value1', 'value2', ...);

CREATE TYPE order_status AS ENUM(
  'pending',
  'shipped',
  'delibered',
);

-- Update a value
-- ALTER TYPE name RENAME VALUE 'old_value' TO 'new_value';

ALTER TYPE order_status RENAME VALUE 'delibered' TO 'delivered';

-- List all ENUM values
-- SELECT enum_range(NULL::name);

SELECT enum_range(NULL::order_status);

-- To add a new value
-- ALTER TYPE name ADD VALUE 'new_value' [BEFORE 'existing_value' | AFTER 'existing_value'];

ALTER TYPE order_status ADD VALUE 'cancelled' AFTER 'shipped';


-- Update an ENUM data in a production server

CREATE TYPE status_enum AS ENUM(
  'queued',
  'waiting',
  'running',
  'done',
);

CREATE TABLE jobs (
  id SERIAL PRIMARY KEY,
  status status_enum 
);

INSERT INTO jobs (status) VALUES ('done');

SELECT * FROM jobs;

UPDATE jobs SET status = 'running' WHERE job_status = 'waiting';

ALTER TYPE status_enum RENAME TO status_enum_old;

CREATE TYPE status_enum AS ENUM(
  'queued',
  'running',
  'done',
  'failed',
)

ALTER TABLE jobs
  ALTER COLUMN status TYPE status_enum_old USING status::text::status_enum;

DROP TYPE status_enum_old;

-- An ENUM with a DEFAULT value in a table

-- First create an ENUM data type

CREATE TYPE status AS ENUM(
  'pending',
  'aproved',
  'declined',
);


CREATE TABLE cron_jobs (
  id SERIAL PRIMARY KEY,
  job_name VARCHAR(100) NOT NULL,
  status status DEFAULT 'pending'
);

INSERT INTO cron_jobs (job_name) VALUES ('Backup Job');
INSERT INTO cron_jobs (job_name, status) VALUES ('Cleanup Job', 'aproved');

SELECT * FROM cron_jobs;


-- How to create a TYPE if not exists using PL/pgSQL

DO 
$$
BEGIN
  IF NOT EXISTS (SELECT *
                  FROM pg_type typ
                  INNER JOIN pg_namespace nsp
                  ON nsp.oid = typ.typnamespace
                  WHERE nsp.nspname = current_schema()
                  AND typ.typname = 'ai') THEN
    CREATE TYPE ai AS (
      a text,
      i integer
    );
  END IF;
END;



