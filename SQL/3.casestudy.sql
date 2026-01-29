-- Retail Database – Analytical Questions

use retail_db;
-- Question 1: Generate a daily revenue table by calculating the total order value per day for all completed and closed orders
select order_date, sum(order_items.order_item_subtotal) as daily_revenue
from orders join order_items on orders.order_id = order_items.order_item_order_id 
where order_status in ('COMPLETE' , 'CLOSED')
group by order_date
;

-- Question 2: Create a table by calculating revenue per product per day.
select order_date, product_id, sum(order_items.order_item_subtotal) as daily_revenue
from orders 
join order_items on orders.order_id = order_items.order_item_order_id 
join products on products.product_id = order_items.order_item_product_id 

where order_status in ('COMPLETE' , 'CLOSED')
group by order_date, product_id
;
-- Question 3: Compute monthly revenue while retaining daily rows.


-- 😂

--

SELECT 
    o.order_date,
    SUM(oi.order_item_subtotal) AS daily_revenue,
    SUM(SUM(oi.order_item_subtotal)) OVER (
        PARTITION BY DATE_FORMAT(o.order_date, '%Y-%m')
    ) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_item_order_id
WHERE o.order_status IN ('COMPLETE', 'CLOSED')
GROUP BY o.order_date;



-- Question 4: Rank products globally by revenue for a given date.
select rank() over(order by sum(order_items.order_item_subtotal) desc) as rnk, product_id, sum(order_items.order_item_subtotal) as revenue
from orders 
join order_items on orders.order_id = order_items.order_item_order_id 
join products on products.product_id = order_items.order_item_product_id 
where order_date = '2013-07-25 00:00:00' 
and order_status IN ('COMPLETE', 'CLOSED')
group by product_id;
-- Question 5: Retrieve top 5 products by revenue using dense ranking.

select dense_rank() over(order by sum(order_items.order_item_subtotal) desc) as rnk, product_id, sum(order_items.order_item_subtotal) as revenue
from orders 
join order_items on orders.order_id = order_items.order_item_order_id 
join products on products.product_id = order_items.order_item_product_id 
-- where order_date = '2013-07-25 00:00:00' 
and order_status IN ('COMPLETE', 'CLOSED')
group by product_id
limit 5;

-- notebook 25


-- NYSE Daily Stock Prices
-- The dataset contains daily OHLC (Open, High, Low, Close) prices along with volume and adjusted close values.

-- Dataset Structure
-- Each row in the CSV file contains:

-- Exchange (e.g., NYSE)
-- Stock Symbol (e.g., QTM)
-- Trade Date
-- Open Price
-- High Price
-- Low Price
-- Close Price
-- Volume
-- Adjusted Close Price
-- Create Database

CREATE DATABASE IF NOT EXISTS nyse;

     

USE nyse;
     
-- Create Table (DDL)

CREATE TABLE nyse_daily_prices (
    exchange        VARCHAR(10),
    symbol          VARCHAR(10),
    trade_date      DATE,
    open_price      DECIMAL(10,2),
    high_price      DECIMAL(10,2),
    low_price       DECIMAL(10,2),
    close_price     DECIMAL(10,2),
    volume          BIGINT,
    adj_close_price DECIMAL(10,2)
);
     
-- Load Data From CSV File
-- 👉 If the file is on your local machine, use LOAD DATA LOCAL INFILE.

-- Important: Adjust the file path as per your system. The below query was for Windows, refactor the path for Mac

LOAD DATA LOCAL INFILE
'/Users/as-mac-1255/Downloads/nyse_sample_data.csv'
INTO TABLE nyse_daily_prices
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(exchange,
 symbol,
 trade_date,
 open_price,
 high_price,
 low_price,
 close_price,
 volume,
 adj_close_price);


     
-- Verify Loaded Data

SELECT *
FROM nyse_daily_prices
LIMIT 10;

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;


     