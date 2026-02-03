
-- Build Gold Layer (SQL)
-- Purpose: Star schema exposed via views

DROP DATABASE IF EXISTS gold;
CREATE DATABASE gold DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE gold;

-- dim_customers
CREATE OR REPLACE VIEW gold.dim_customers AS
SELECT
  ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,
  ci.cst_id        AS customer_id,
  ci.cst_key       AS customer_number,
  ci.cst_firstname AS first_name,
  ci.cst_lastname  AS last_name,
  la.cntry         AS country,
  ci.cst_marital_status AS marital_status,
  CASE 
    WHEN ci.cst_gndr <> 'n/a' THEN ci.cst_gndr
    ELSE COALESCE(ca.gen, 'n/a')
  END AS gender,
  ca.bdate         AS birthdate,
  ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la ON ci.cst_key = la.cid;
SELECT COUNT(*) AS dim_customers_rows FROM gold.dim_customers;

-- dim_products
CREATE OR REPLACE VIEW gold.dim_products AS
SELECT
  ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
  pn.prd_id       AS product_id,
  pn.prd_key      AS product_number,
  pn.prd_nm       AS product_name,
  pn.cat_id       AS category_id,
  pc.cat          AS category,
  pc.subcat       AS subcategory,
  pc.maintenance  AS maintenance,
  pn.prd_cost     AS cost,
  pn.prd_line     AS product_line,
  pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL;
SELECT COUNT(*) AS dim_products_rows FROM gold.dim_products;

-- fact_sales
CREATE OR REPLACE VIEW gold.fact_sales AS
SELECT
  sd.sls_ord_num  AS order_number,
  pr.product_key  AS product_key,
  cu.customer_key AS customer_key,
  sd.sls_order_dt AS order_date,
  sd.sls_ship_dt  AS shipping_date,
  sd.sls_due_dt   AS due_date,
  sd.sls_sales    AS sales_amount,
  sd.sls_quantity AS quantity,
  sd.sls_price    AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu ON sd.sls_cust_id = cu.customer_id;
SELECT COUNT(*) AS fact_sales_rows FROM gold.fact_sales;

Select * from gold.dim_customers;
Select * from gold.dim_products;
Select * from gold.fact_sales;
-- ques 1: Retrieve the oldest customer (by age).
SELECT 
    customer_key,
    customer_id,
    customer_number,
    first_name,
    last_name,
    birthdate,
    TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age
FROM dim_customers
WHERE birthdate IS NOT NULL
ORDER BY birthdate
LIMIT 1;


-- ques 2: Retrieve the youngest customer (by age).
Select * ,
TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age
from dim_customers
where birthdate is not null
order by birthdate desc limit 1;

-- ques 3: Compute revenue by category.
Select category_id, sum(cost) as total_revenue from dim_products
group by category_id;

-- ques 4: Compute units sold by country.
Select c.country, sum(f.quantity)
from fact_sales f 
join dim_customers c on f.customer_key = c.customer_key 
group by c.country;

-- ques 5: Find 3 customers with the fewest orders (consider only customers with ≥ 1 order).
Select f.customer_key , c.first_name, c.last_name, count(*)
from fact_sales f
join dim_customers c on c.customer_key = f.customer_key
group by f.customer_key , c.first_name, c.last_name
having count(*) >= 1
order by count(*), f.customer_key
limit 3;

-- ques 6 : find bottom 5 products by revenue
select product_key , sum(sales_amount)
from fact_sales 
group by product_key
order by sum(sales_amount)
limit 5;

-- ques 7: Compute yearly product sales.

Select YEAR(s.shipping_date) ,p.product_key, p.product_name , sum(s.price)
from fact_sales s
join dim_products p on p.product_key = s.product_key
group by year(s.shipping_date), p.product_name
order by year(s.shipping_date), p.product_name;

SELECT 
    YEAR(s.shipping_date) AS year,
    p.product_key,
    p.product_name,
    SUM(s.price) AS total_price
FROM fact_sales s
JOIN dim_products p 
    ON p.product_key = s.product_key
GROUP BY 
    p.product_name,
    YEAR(s.shipping_date)
    
ORDER BY 
	p.product_name,
    year;






