USE RETAIL_DB;

-- NOTEBOOK 16
-- Scenario 1: No Index on order_status
EXPLAIN
SELECT DISTINCT order_status
FROM orders
ORDER BY order_status;

-- Scenario 2: Index Present on order_status

CREATE INDEX idx_orders_order_status ON orders(order_status);
     
EXPLAIN analyze
SELECT DISTINCT order_status
FROM orders
ORDER BY order_status;


-- notebook 17
-- SQL Window Functions



CREATE DATABASE IF NOT EXISTS retail_analytics;

USE retail_analytics;
     
-- Create Products Table
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50),
    product_name VARCHAR(100),
    total_sales INT
);
-- Load Sample Data

INSERT INTO products (category, product_name, total_sales) VALUES
('Electronics', 'iPhone 17', 120),
('Electronics', 'Samsung Galaxy S25', 115),
('Electronics', 'OnePlus Nord CE5', 115),
('Electronics', 'Redmi A4', 100),
('Electronics', 'Vivo V27', 100),
('Electronics', 'Realme Narzo', 95),
('Electronics', 'Samsung Galaxy A55', 90),
('Electronics', 'iPhone 16 Pro', 85);

     
-- View the Table
SELECT *
FROM products order by total_sales desc;

-- rank
select rank() over(order by total_sales desc), product_name 
from products;

-- row_number, rank , dense_rank , ntile
select product_name, total_sales,
row_number() over(order by total_sales desc) as row_num,
rank() over(order by total_sales desc ) as rank_num,
dense_rank() over( order by total_sales desc) as dense_rank_num,
ntile(4) over(order by total_sales desc) as performance_bucket
from products;
 

SELECT 
DATE_FORMAT(order_date, '%Y-%m') as order_month,
SUM(amount) as monthly_total
FROM sales
GROUP BY order_month;

SELECT 
 order_id,
 order_date,
 product,
 amount,
 SUM(amount) OVER (ORDER BY order_date) as running_total
FROM sales
;

SELECT 
 order_id,
 order_date,
 product,
 amount,
 SUM(amount) OVER (
 PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
 ORDER BY order_date )
FROM sales;

SELECT 
 order_id,
 order_date,
 product,
 amount,
 LEAD(amount) OVER (
 PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
 ORDER BY order_date ) as next_order_amount,
 SUM(amount) OVER (
 PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
 ORDER BY order_date ) as running_total
FROM sales;



Window Functions - LEAD() and LAG()
Create Sample Sales Table
We create a simple sales table with orders, products, and amounts to demonstrate window functions.


CREATE TABLE sales (
    order_id   INT,
    order_date DATE,
    product    VARCHAR(50),
    amount     INT
);
     

INSERT INTO sales VALUES
(1, '2025-01-05', 'Laptop', 1000),
(2, '2025-01-10', 'Phone',  500),
(3, '2025-01-20', 'Tablet', 300),
(4, '2025-02-02', 'Laptop', 1200),
(5, '2025-02-05', 'Phone',  600),
(6, '2025-02-15', 'Tablet', 400);
     
View Data
Check the contents of the sales table.


SELECT *
FROM sales
ORDER BY order_date;
     
SELECT order_id, order_date, product, amount FROM sales;

Extract the month (so we can group by month)

SELECT
  order_id,
  order_date,
  product,
  amount,
  DATE_FORMAT(order_date, '%Y-%m') AS order_month
FROM sales;

     
Monthly total (basic aggregation)

SELECT
  DATE_FORMAT(order_date, '%Y-%m') AS order_month,
  SUM(amount) AS monthly_total
FROM sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m');

     
Add a running total across the whole table

SELECT
  order_id,
  order_date,
  product,
  amount,
  SUM(amount) OVER (ORDER BY order_date) AS running_total
FROM sales;

     
Running total for each month

SELECT
  order_id,
  order_date,
  product,
  amount,
  SUM(amount) OVER (
    PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
    ORDER BY order_date
  ) AS running_total
FROM sales;

     
Using LEAD Function
The LEAD function allows you to look ahead at the value of a column in the next row within the same partition. Here, we find the next order's amount within the same month, along with the monthly total.


SELECT order_id,
       order_date,
       product,
       amount,
       LEAD(amount) OVER (
         PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
         ORDER BY order_date, order_id
       ) AS next_order_amount,
       SUM(amount) OVER (
         PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
       ) AS monthly_total
FROM sales
ORDER BY order_date;

     
Using LAG Function
The LAG function allows you to look back at the value of a column in the previous row within the same partition. Here, we find the previous order's amount within the same month, along with the monthly total.


SELECT order_id,
       order_date,
       product,
       amount,
       LAG(amount) OVER (
         PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
         ORDER BY order_date, order_id
       ) AS previous_order_amount,
       SUM(amount) OVER (
         PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
       ) AS monthly_total
FROM sales
ORDER BY order_date;
     
-- notebook 18

-- Window Functions - LEAD() and LAG()
-- Create Sample Sales Table
-- We create a simple sales table with orders, products, and amounts to demonstrate window functions.


CREATE TABLE sales (
    order_id   INT,
    order_date DATE,
    product    VARCHAR(50),
    amount     INT
);
     

INSERT INTO sales VALUES
(1, '2025-01-05', 'Laptop', 1000),
(2, '2025-01-10', 'Phone',  500),
(3, '2025-01-20', 'Tablet', 300),
(4, '2025-02-02', 'Laptop', 1200),
(5, '2025-02-05', 'Phone',  600),
(6, '2025-02-15', 'Tablet', 400);
     
-- View Data
-- Check the contents of the sales table.


SELECT 
 order_id,
 order_date,
 product,
 amount,
 SUM(amount) OVER (
 PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
 ORDER BY order_date ) as running_total
FROM sales;

SELECT 
 order_id,
 order_date,
 product,
 amount,
 LEAD(amount) OVER (
 PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
 ORDER BY order_date ) as next_order_amount,
 SUM(amount) OVER (
 PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
 ORDER BY order_date ) as running_total
FROM sales;


-- Window Functions - LEAD() and LAG()
-- Create Sample Sales Table
-- We create a simple sales table with orders, products, and amounts to demonstrate window functions.


CREATE TABLE sales (
    order_id   INT,
    order_date DATE,
    product    VARCHAR(50),
    amount     INT
);
     

INSERT INTO sales VALUES
(1, '2025-01-05', 'Laptop', 1000),
(2, '2025-01-10', 'Phone',  500),
(3, '2025-01-20', 'Tablet', 300),
(4, '2025-02-02', 'Laptop', 1200),
(5, '2025-02-05', 'Phone',  600),
(6, '2025-02-15', 'Tablet', 400);
     
-- View Data
-- Check the contents of the sales table.


SELECT *
FROM sales
ORDER BY order_date;
     
SELECT order_id, order_date, product, amount FROM sales;

-- Extract the month (so we can group by month)

SELECT
  order_id,
  order_date,
  product,
  amount,
  DATE_FORMAT(order_date, '%Y-%m') AS order_month
FROM sales;

     
-- Monthly total (basic aggregation)

SELECT9835

  DATE_FORMAT(order_date, '%Y-%m') AS order_month,
  SUM(amount) AS monthly_total
FROM sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m');

     
-- Add a running total across the whole table

SELECT
  order_id,
  order_date,
  product,
  amount,
  SUM(amount) OVER (ORDER BY order_date) AS running_total
FROM sales;

     
-- Running total for each month

SELECT
  order_id,
  order_date,
  product,
  amount,
  SUM(amount) OVER (
    PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
    ORDER BY order_date
  ) AS running_total
FROM sales;

     
-- Using LEAD Function
-- The LEAD function allows you to look ahead at the value of a column in the next row within the same partition. Here, we find the next order's amount within the same month, along with the monthly total.


SELECT order_id,
       order_date,
       product,
       amount,
       LEAD(amount) OVER (
         PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
         ORDER BY order_date, order_id
       ) AS next_order_amount,
       SUM(amount) OVER (
         PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
       ) AS monthly_total
FROM sales
ORDER BY order_date;

     
-- Using LAG Function
-- The LAG function allows you to look back at the value of a column in the previous row within the same partition. Here, we find the previous order's amount within the same month, along with the monthly total.


SELECT order_id,
       order_date,
       product,
       amount,
       LAG(amount) OVER (
         PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
         ORDER BY order_date, order_id
       ) AS previous_order_amount,
       SUM(amount) OVER (
         PARTITION BY DATE_FORMAT(order_date, '%Y-%m')
       ) AS monthly_total
FROM sales
ORDER BY order_date;
     

WITH orders_needing_action AS (
    SELECT
        order_id,
        order_status
    FROM orders
    WHERE order_status IN (
        'PENDING_PAYMENT',
        'PROCESSING',
        'PAYMENT_REVIEW',
        'ON_HOLD'
    )
)
SELECT *
FROM orders_needing_action;
Second Highest Salary (Using Subquery)
SELECT MAX(sal) AS second_highest_salary
FROM emp
WHERE sal < (
    SELECT MAX(sal)
    FROM emp
);
Second Highest Salary (Using CTE)
WITH max_salary AS (
    SELECT MAX(sal) AS highest_salary
    FROM emp
)
SELECT MAX(sal) AS second_highest_salary
FROM emp
WHERE sal < (
    SELECT highest_salary
    FROM max_salary
);

 -- notebook 19

SELECT
    order_id,
    order_date,
    order_status,
    CASE
        WHEN order_status IN ('COMPLETE', 'CLOSED') 
            THEN 'No Action Needed'

        WHEN order_status IN (
            'PENDING_PAYMENT',
            'PROCESSING',
            'PAYMENT_REVIEW',
            'PENDING',
            'ON_HOLD'
        )
            THEN 'Action Needed'

        WHEN order_status = 'SUSPECTED_FRAUD'
            THEN 'Risky'

        WHEN order_status = 'CANCELED'
            THEN 'Closed / No Action'

        ELSE 'Unknown / Review Required'
    END AS order_status_category
FROM orders
ORDER BY order_date;
 

WITH orders_needing_action AS (
    SELECT
        order_id,
        order_status
    FROM orders
    WHERE order_status IN (
        'PENDING_PAYMENT',
        'PROCESSING',
        'PAYMENT_REVIEW',
        'ON_HOLD'
    )
)
SELECT *
FROM orders_needing_action;
-- Second Highest Salary (Using Subquery)
SELECT MAX(sal) AS second_highest_salary
FROM emp
WHERE sal < (
    SELECT MAX(sal)
    FROM emp
);
-- Second Highest Salary (Using CTE)
WITH max_salary AS (
    SELECT MAX(sal) AS highest_salary
    FROM emp
)
SELECT MAX(sal) AS second_highest_salary
FROM emp
WHERE sal < (
    SELECT highest_salary
    FROM max_salary
);

-- notebook 20
use retail_db;

DELIMITER $$

DROP PROCEDURE IF EXISTS get_monthly_orders $$

CREATE PROCEDURE get_monthly_orders()
BEGIN
  SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS order_count
  FROM orders
  GROUP BY order_month
  ORDER BY order_month;
END $$

DELIMITER ;
-- Running the stored procedure
CALL get_monthly_orders();
-- TRY / CATCH
-- During a batch step, inserts might fail (e.g., bad foreign key, duplicates). We want to:

-- capture the error
-- return a controlled message (or log it)
-- avoid confusing failures
-- MySQL uses:

-- DECLARE ... HANDLER FOR SQLEXCEPTION inside stored procedures or blocks.
DELIMITER $$

DROP PROCEDURE IF EXISTS demo_error_handler $$

CREATE PROCEDURE demo_error_handler()
BEGIN
  DECLARE had_error TINYINT DEFAULT 0;

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  SET had_error = 1;

  -- Intentional example: this may fail if customer_id does not exist
  INSERT INTO orders(order_date, order_customer_id, order_status)
  VALUES (NOW(), 99999999, 'CREATED');

  IF had_error = 1 THEN
    SELECT 'An error occurred during the insert. The handler captured it.' AS message;
  ELSE
    SELECT 'Insert succeeded.' AS message;
  END IF;
END $$

DELIMITER ;
-- Execute the handler demo
-- CALL demo_error_handler();
-- Top-N queries — Top 10 products by revenue
-- Merchandising needs the top performers for promotion planning.

-- Aggregate revenue by product
-- Sort descending
-- Return Top-N using LIMIT
SELECT
  oi.order_item_product_id AS product_id,
  SUM(oi.order_item_subtotal) AS total_revenue
FROM order_items oi
GROUP BY oi.order_item_product_id
ORDER BY total_revenue DESC
LIMIT 10;

CREATE INDEX idx_orders_customer_id
ON orders(order_customer_id);
select * from orders;


-- CTAS (CREATE TABLE AS SELECT)
-- CTAS is commonly used to create a new table from the result of a query.

-- Create a Sample Source Table
-- We create a small table and insert sample data.


CREATE TABLE sales (
    order_id INT,
    order_date DATE,
    amount DECIMAL(10,2)
);
     

INSERT INTO sales VALUES
(1, '2025-01-01', 100.00),
(2, '2025-01-01', 150.00),
(3, '2025-01-02', 200.00),
(4, '2025-01-02', 50.00);
     
-- Query the Source Table
-- Calculate total sales amount per day.


SELECT order_date, SUM(amount) AS daily_total
FROM sales
GROUP BY order_date;
     
-- Create a Table Using CTAS
-- CTAS creates a new table directly from the SELECT query.


CREATE TABLE daily_sales_summary AS
SELECT
    order_date,
    SUM(amount) AS daily_total
FROM sales
GROUP BY order_date;
     
-- Query the New Table

SELECT * FROM daily_sales_summary;
     
