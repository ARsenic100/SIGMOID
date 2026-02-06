-- top 3 stores by revenue
CREATE DATABASE IF NOT EXISTS usecase_db;
USE usecase_db;

DROP TABLE IF EXISTS sales_raw_source1;

CREATE TABLE sales_raw_source1 (
    store_id         VARCHAR(10),
    store_name       VARCHAR(50),
    product_category VARCHAR(50),
    sales_date       DATE,
    unit_sales       DECIMAL(10,2),
    dollar_sales     DECIMAL(10,2),
    store_zip        INT,
    promotion_flag   VARCHAR(5)
);
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/Users/as-mac-1255/Desktop/SIGMOID/SQL/sales_2024-09-01.csv'
INTO TABLE sales_raw_source1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(store_id,
 store_name,
 product_category,
 sales_date,
 unit_sales,
 dollar_sales,
 store_zip,
 promotion_flag);

-- Top 3 stores with highest total sales
SELECT
    store_id,
    store_name,
    SUM(dollar_sales) AS total_sales
FROM sales_raw_source1
GROUP BY store_id, store_name
ORDER BY total_sales DESC
LIMIT 3;
