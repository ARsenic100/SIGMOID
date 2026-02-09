/* =========================================================
   SILVER LAYER BUILD
   Input  : TSV787_aditya_raj_bronze_db
   Output : TSV787_aditya_raj_silver_db
   ========================================================= */

-- Drop and create Silver database
DROP DATABASE IF EXISTS TSV787_aditya_raj_silver_db;
CREATE DATABASE IF NOT EXISTS TSV787_aditya_raj_silver_db;
USE TSV787_aditya_raj_silver_db;

-- Drop and create Silver table
DROP TABLE IF EXISTS silver_sales_clean;

CREATE TABLE silver_sales_clean (
    order_id VARCHAR(20) PRIMARY KEY,
    source_system VARCHAR(20),
    customer_name VARCHAR(100),
    city VARCHAR(50),
    email VARCHAR(100),
    product_name VARCHAR(100),
    product_category VARCHAR(50),
    sale_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    load_timestamp TIMESTAMP
);

-- Full refresh strategy
TRUNCATE TABLE silver_sales_clean;

-- Insert cleansed, filtered, deduplicated data from Bronze
INSERT INTO silver_sales_clean (
    order_id,
    source_system,
    customer_name,
    city,
    email,
    product_name,
    product_category,
    sale_date,
    quantity,
    unit_price,
    load_timestamp
)
SELECT
    order_id,
    source_system,
    customer_name,
    city,
    TRIM(email) AS email,
    product_name,
    TRIM(product_category) AS product_category,
    sale_date,
    quantity,
    unit_price,
    load_timestamp
FROM (
    SELECT
        order_id,
        source_system,
        customer_name,

        -- City standardization rules
        CASE
            WHEN city IS NULL
              OR TRIM(city) = ''
              OR LOWER(TRIM(city)) = 'null'
                THEN 'Delhi'
            WHEN UPPER(TRIM(city)) = 'NY'
                THEN 'New York'
            WHEN UPPER(TRIM(city)) = 'HYD'
                THEN 'Hyderabad'
            ELSE TRIM(city)
        END AS city,

        email,
        product_name,
        product_category,
        sale_date,
        quantity,
        unit_price,
        load_timestamp,

        -- Deduplication logic
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY load_timestamp DESC
        ) AS rn

    FROM TSV787_aditya_raj_bronze_db.bronze_sales_raw
    WHERE product_category IS NULL
       OR product_category <> 'Beauty'
) ranked
WHERE rn = 1;
-- verify

SELECT COUNT(*) AS silver_rows FROM TSV787_aditya_raj_silver_db.silver_sales_clean;
     

SELECT COUNT(*) AS missing_city_after_cleaning
FROM TSV787_aditya_raj_silver_db.silver_sales_clean
WHERE city IS NULL OR TRIM(city) = '';
     

SELECT COUNT(*) AS beauty_rows_in_silver
FROM TSV787_aditya_raj_silver_db.silver_sales_clean
WHERE product_category = 'Beauty';
     

SELECT * FROM TSV787_aditya_raj_silver_db.silver_sales_clean ORDER BY load_timestamp, order_id;
