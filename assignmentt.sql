USE WAREHOUSE DEMO_WAREHOUSE;
USE DATABASE DEMO_DATABASE;

-- Create the SALES_DATA_FINAL table --
CREATE OR REPLACE TABLE SALES_DATA_FINAL (
order_id VARCHAR(60) PRIMARY KEY,
order_date DATE,
ship_date DATE,
ship_mode VARCHAR(40),
customer_name VARCHAR(60),
segment VARCHAR(60),
state VARCHAR(60),
country VARCHAR(60),
market VARCHAR(60),
region VARCHAR(60),
product_id VARCHAR(60),
category VARCHAR(60),
sub_category VARCHAR(60),
product_name STRING,
sales NUMBER(10,3),
quantity INT,
discount FLOAT,
profit FLOAT,
shipping_cost FLOAT,
order_priority VARCHAR(60),
year INT,
order_extract VARCHAR(25),
discount_flag STRING,
process_days STRING,
rating INT
);

-- Describe the SALES_DATA_FINAL table --
DESC TABLE SALES_DATA_FINAL;

-- Select all records from the SALES_DATA_FINAL table --
SELECT * FROM SALES_DATA_FINAL;

-- Create a new column called order_extract --
ALTER TABLE SALES_DATA_FINAL ADD COLUMN order_extract VARCHAR(25);

-- Update the order_extract column with substring of order_id --
UPDATE SALES_DATA_FINAL
SET order_extract = SUBSTRING(order_id, 9, 10);

-- Create a new column called discount_flag --
ALTER TABLE SALES_DATA_FINAL ADD COLUMN discount_flag STRING;

-- Update the discount_flag column based on the discount value --
UPDATE SALES_DATA_FINAL
SET discount_flag = CASE
WHEN discount > 0 THEN 'YES'
ELSE 'NO'
END;

-- Create a new column called process_days --
ALTER TABLE SALES_DATA_FINAL ADD COLUMN process_days STRING;

-- Set the timestamp input format to 'YYYY-MM-DD' --
ALTER SESSION SET TIMESTAMP_INPUT_FORMAT = 'YYYY-MM-DD';

-- Update the process_days column with the difference in days between order_date and ship_date --
UPDATE SALES_DATA_FINAL
SET process_days = DATEDIFF('day', order_date, ship_date);

-- Create a new column called rating --
ALTER TABLE SALES_DATA_FINAL ADD COLUMN rating INT;

-- Update the rating column based on the process_days value --
UPDATE SALES_DATA_FINAL
SET rating = CASE
WHEN process_days <= 3 THEN 5
WHEN process_days > 3 AND process_days <= 6 THEN 4
WHEN process_days > 6 AND process_days <= 10 THEN 3
WHEN process_days > 10 THEN 2
END;

-- Select all records from the SALES_DATA_FINAL table with the updated columns --
SELECT * FROM SALES_DATA_FINAL;