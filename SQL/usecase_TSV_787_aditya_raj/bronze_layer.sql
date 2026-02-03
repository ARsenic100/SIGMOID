/* =========================================================
   BRONZE LAYER BUILD
   Input  : TSV787_aditya_raj_source_db
   Output : TSV787_aditya_raj_bronze_db
   ========================================================= */

DROP TABLE IF EXISTS TSV787_aditya_raj_bronze_db;
CREATE DATABASE IF NOT EXISTS TSV787_aditya_raj_bronze_db;
USE TSV787_aditya_raj_bronze_db;

CREATE TABLE IF NOT EXISTS bronze_sales_raw (
    source_system     VARCHAR(20),
    order_id          VARCHAR(20),
    customer_name     VARCHAR(100),
    city              VARCHAR(50),
    email             VARCHAR(100),
    product_name      VARCHAR(100),
    product_category  VARCHAR(50),
    sale_date         DATE,
    quantity          INT,
    unit_price        DECIMAL(10,2),
    load_timestamp    TIMESTAMP
);

TRUNCATE TABLE bronze_sales_raw;

INSERT INTO bronze_sales_raw (
    source_system,
    order_id,
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
    'flipkart' AS source_system,
    order_id,
    customer_name,
    city,
    email,
    product_name,
    product_category,
    sale_date,
    quantity,
    unit_price,
    load_timestamp
FROM TSV787_aditya_raj_source_db.sales_raw_source1;


INSERT INTO bronze_sales_raw (
    source_system,
    order_id,
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
    'amazon' AS source_system,
    order_id,
    customer_name,
    city,
    email,
    product_name,
    product_category,
    sale_date,
    quantity,
    unit_price,
    load_timestamp
FROM TSV787_aditya_raj_source_db.sales_raw_source2;

SELECT
    source_system,
    COUNT(*) AS rows_count
FROM bronze_sales_raw
GROUP BY source_system;

SELECT 'source1' AS src, COUNT(*) AS rows_count FROM source_db.sales_raw_source1
UNION ALL
SELECT 'source2' AS src, COUNT(*) AS rows_count FROM source_db.sales_raw_source2;
     

SELECT * FROM source_db.sales_raw_source1 ORDER BY load_timestamp, order_id;
     

SELECT * FROM source_db.sales_raw_source2 ORDER BY load_timestamp, order_id;
