/* =========================================================
   SOURCE DATA LOAD
   Input  : source1.csv, source2.csv
   Output : TSV787_aditya_raj_source_db
   ========================================================= */

create database TSV787_aditya_raj_source_db;
use TSV787_aditya_raj_source_db;


create table sales_raw_source1(
order_id VARCHAR(20),
customer_name VARCHAR(100),
city VARCHAR(50),
email VARCHAR(100),
product_name VARCHAR(100),
product_category VARCHAR(50),
sale_date DATE,
quantity INT,
unit_price DECIMAL(10,2),
load_timestamp TIMESTAMP );

create table sales_raw_source2(
order_id VARCHAR(20),
customer_name VARCHAR(100),
city VARCHAR(50),
email VARCHAR(100),
product_name VARCHAR(100),
product_category VARCHAR(50),
sale_date DATE,
quantity INT,
unit_price DECIMAL(10,2),
load_timestamp TIMESTAMP );

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/Users/as-mac-1255/Downloads/source1.csv'
INTO TABLE sales_raw_source1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/as-mac-1255/Downloads/source2.csv'
INTO TABLE sales_raw_source2
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from sales_raw_source1;
select * from sales_raw_source2;

