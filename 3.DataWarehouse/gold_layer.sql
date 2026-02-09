/* =========================================================
   GOLD LAYER BUILD
   Input  : TSV787_aditya_raj_silver_db
   Output : TSV787_aditya_raj_gold_db
   ========================================================= */

-- 1. Create Gold Database
DROP DATABASE IF EXISTS TSV787_aditya_raj_gold_db;
CREATE DATABASE TSV787_aditya_raj_gold_db;
USE TSV787_aditya_raj_gold_db;

-- 2. Create Dimension Tables

-- a)Customer Dimension
DROP TABLE IF EXISTS dim_customer;
CREATE TABLE dim_customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    last_seen_ts TIMESTAMP
);

-- b)Product Dimension
DROP TABLE IF EXISTS dim_product;
CREATE TABLE dim_product (
    product_key INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    product_category VARCHAR(50),
    UNIQUE (product_name, product_category)
);

-- 3. Create Fact Table

DROP TABLE IF EXISTS fact_sales;
CREATE TABLE fact_sales (
    sales_key INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(20) UNIQUE,
    customer_key INT,
    product_key INT,
    sale_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(12,2),
    load_timestamp TIMESTAMP,
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);


-- 4. Full Refresh (TRUNCATE)
TRUNCATE TABLE fact_sales;

-- 5. Load Customer Dimension
INSERT INTO dim_customer (
    email,
    customer_name,
    city,
    last_seen_ts
)
SELECT
    email,
    customer_name,
    city,
    load_timestamp
FROM (
    SELECT
        email,
        customer_name,
        city,
        load_timestamp,
        ROW_NUMBER() OVER (
            PARTITION BY email
            ORDER BY load_timestamp DESC
        ) AS rn
    FROM TSV787_aditya_raj_silver_db.silver_sales_clean
    WHERE email IS NOT NULL
      AND TRIM(email) <> ''
) ranked
WHERE rn = 1;

-- 6. Load Product Dimension
INSERT INTO dim_product (
    product_name,
    product_category
)
SELECT DISTINCT
    product_name,
    product_category
FROM TSV787_aditya_raj_silver_db.silver_sales_clean
WHERE product_name IS NOT NULL
  AND product_category IS NOT NULL;

-- 7. Load Sales Fact Table
INSERT INTO fact_sales (
    order_id,
    customer_key,
    product_key,
    sale_date,
    quantity,
    unit_price,
    total_amount,
    load_timestamp
)
SELECT
    s.order_id,
    c.customer_key,
    p.product_key,
    s.sale_date,
    s.quantity,
    s.unit_price,
    ROUND(s.quantity * s.unit_price, 2) AS total_amount,
    s.load_timestamp
FROM TSV787_aditya_raj_silver_db.silver_sales_clean s
JOIN dim_customer c
    ON s.email = c.email
JOIN dim_product p
    ON s.product_name = p.product_name
   AND s.product_category = p.product_category;

-- 8. gold verify

SELECT COUNT(*) AS customers FROM TSV787_aditya_raj_gold_db.dim_customer;
SELECT COUNT(*) AS products  FROM TSV787_aditya_raj_gold_db.dim_product;
SELECT COUNT(*) AS facts     FROM TSV787_aditya_raj_gold_db.fact_sales;
     

SELECT * FROM TSV787_aditya_raj_gold_db.fact_sales ORDER BY sale_date, order_id;
