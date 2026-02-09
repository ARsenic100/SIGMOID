/* =========================================================
   ETL QUALITY ASSURANCE (QA)
   Input  : TSV787_aditya_raj_bronze_db
            TSV787_aditya_raj_silver_db
            TSV787_aditya_raj_gold_db
   Output : TSV787_aditya_raj_qa_db
   ========================================================= */

-- Create QA database and table
DROP DATABASE TSV787_aditya_raj_qa_db;
CREATE DATABASE IF NOT EXISTS TSV787_aditya_raj_qa_db;
USE TSV787_aditya_raj_qa_db;

DROP TABLE IF EXISTS test_results;

CREATE TABLE test_results (
    test_run_id   VARCHAR(20),
    test_name     VARCHAR(100),
    status        VARCHAR(10),
    actual_value  INT,
    expected_desc VARCHAR(100),
    details       VARCHAR(255),
    run_ts        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Initialize test run id
SET @test_run_id = DATE_FORMAT(NOW(), '%Y%m%d_%H%i%s');


-- Test Cases
--    TEST 1: Bronze - Duplicate order_id Check
--    Expected: 0 duplicates
INSERT INTO TSV787_aditya_raj_qa_db.test_results
(test_run_id, test_name, status, actual_value, expected_desc, details)
SELECT
    @test_run_id,
    'Bronze Duplicate order_id Check',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*) AS actual_value,
    '0 expected',
    'Detects duplicate order_id values in Bronze'
FROM (
    SELECT order_id
    FROM TSV787_aditya_raj_bronze_db.bronze_sales_raw
    GROUP BY order_id
    HAVING COUNT(*) > 1
) dup;


--    TEST 2: Silver - NULL / Blank City Check
--    Expected: 0 rows

INSERT INTO TSV787_aditya_raj_qa_db.test_results
(test_run_id, test_name, status, actual_value, expected_desc, details)
SELECT
    @test_run_id,
    'Silver NULL or Blank City Check',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*) AS actual_value,
    '0 expected',
    'Ensures city is populated after Silver standardization'
FROM TSV787_aditya_raj_silver_db.silver_sales_clean
WHERE city IS NULL OR TRIM(city) = '';


--    TEST 3: Silver - Beauty Product Exclusion Rule
--    Expected: 0 rows

INSERT INTO TSV787_aditya_raj_qa_db.test_results
(test_run_id, test_name, status, actual_value, expected_desc, details)
SELECT
    @test_run_id,
    'Silver Beauty Product Exclusion Check',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*) AS actual_value,
    '0 expected',
    'Validates Beauty products are excluded from Silver'
FROM TSV787_aditya_raj_silver_db.silver_sales_clean
WHERE TRIM(product_category) = 'Beauty';



--    TEST 4: Silver - Invalid Email Format Check
--    Rule: must contain @ and .
--    Expected: 0 invalid emails

INSERT INTO TSV787_aditya_raj_qa_db.test_results
(test_run_id, test_name, status, actual_value, expected_desc, details)
SELECT
    @test_run_id,
    'Silver Invalid Email Format Check',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*) AS actual_value,
    '0 expected',
    'Checks basic email validity (@ and .)'
FROM TSV787_aditya_raj_silver_db.silver_sales_clean
WHERE email IS NOT NULL
  AND (email NOT LIKE '%@%' OR email NOT LIKE '%.%');


--    TEST 5: Gold - total_amount Calculation Check
--    Rule: ABS(total_amount - quantity*unit_price) <= 0.01
--    Expected: 0 mismatches

INSERT INTO TSV787_aditya_raj_qa_db.test_results
(test_run_id, test_name, status, actual_value, expected_desc, details)
SELECT
    @test_run_id,
    'Gold total_amount Calculation Check',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*) AS actual_value,
    '0 expected',
    'Validates total_amount calculation accuracy'
FROM TSV787_aditya_raj_gold_db.fact_sales
WHERE ABS(total_amount - (quantity * unit_price)) > 0.01;



--    TEST 6: Completeness - Silver to Gold order_id Check
--    Expected: 0 missing order_ids

INSERT INTO TSV787_aditya_raj_qa_db.test_results
(test_run_id, test_name, status, actual_value, expected_desc, details)
SELECT
    @test_run_id,
    'Silver to Gold order_id Completeness Check',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*) AS actual_value,
    '0 expected',
    'Ensures every Silver order_id exists in Gold fact'
FROM TSV787_aditya_raj_silver_db.silver_sales_clean s
LEFT JOIN TSV787_aditya_raj_gold_db.fact_sales f
    ON s.order_id = f.order_id
WHERE f.order_id IS NULL;



-- View QA results for this run
SELECT *
FROM TSV787_aditya_raj_qa_db.test_results
WHERE test_run_id = @test_run_id
ORDER BY run_ts;
