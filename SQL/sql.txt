create database emp;
use emp;
show tables;

-- 1) ALTER TABLE
-- Used to modify the structure of an existing table.

-- a) Add Column

DROP TABLE IF EXISTS cust_alter;
     

CREATE TABLE cust_alter (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

     

DESCRIBE cust_alter;
     

ALTER TABLE cust_alter ADD phone VARCHAR(15);
     

DESCRIBE cust_alter;
     
-- b) Modify Column

ALTER TABLE cust_alter MODIFY phone VARCHAR(30);
     

DESCRIBE cust_alter;
     
-- c) Drop Column

ALTER TABLE cust_alter DROP COLUMN phone;
     

DESCRIBE cust_alter;


-- 2) Add / Drop Constraints using ALTER TABLE

DROP TABLE IF EXISTS cust_cons;
     

CREATE TABLE cust_cons (
    customer_id INT,
    customer_name VARCHAR(50)
);
     

DESCRIBE cust_cons;
     
-- a) Add Primary Key Constraint

ALTER TABLE cust_cons
ADD CONSTRAINT pk_cust PRIMARY KEY (customer_id);
     

DESCRIBE cust_cons;
     
-- b) Drop Primary Key Constraint

ALTER TABLE cust_cons DROP PRIMARY KEY;
     

DESCRIBE cust_cons;

-- 3) DROP TABLE
-- Deletes the entire table structure and data. Cannot be recovered.

-- Example

DROP TABLE IF EXISTS orders_drop;
     

CREATE TABLE orders_drop (
    order_id INT,
    order_date DATE
);
     

DESCRIBE orders_drop;
     

DROP TABLE IF EXISTS orders_drop;

-- 4) TRUNCATE TABLE
-- Deletes all rows from a table quickly. Table structure remains.

-- Example

DROP TABLE IF EXISTS orders_trunc;
     

CREATE TABLE orders_trunc (
    order_id INT,
    order_date DATE
);
     

INSERT INTO orders_trunc (order_id, order_date) VALUES
(101, '2025-01-10'),
(102, '2025-01-11');
Describe orders_trunc;
     

SELECT * FROM orders_trunc;
     

TRUNCATE TABLE orders_trunc;
     

SELECT * FROM orders_trunc;

-- 5) RENAME TABLE
-- Used to rename a table.

-- Example

DROP TABLE IF EXISTS cust_rename;
     
CREATE TABLE cust_rename (
    customer_id INT,
    customer_name VARCHAR(50)
);

     

DESCRIBE cust_rename;
     

RENAME TABLE cust_rename TO cust_rename_new;
     

DESCRIBE cust_rename_new;


-- SQL Operators
-- Arithmetic Operators (+, -, *, /)
-- Perform mathematical calculations on numeric data.


DROP TABLE IF EXISTS products_op;
     

CREATE TABLE products_op (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT,
    quantity INT
);

DESCRIBE products_op;
     

INSERT INTO products_op (product_id, product_name, price, quantity) VALUES
(1, 'Laptop', 50000, 2),
(2, 'Mouse', 500, 10),
(3, 'Keyboard', 1500, 5);

     

SELECT * FROM products_op;
     

SELECT product_name, price + quantity AS add_result
FROM products_op;

     

SELECT product_name, price - quantity AS sub_result
FROM products_op;

-- Invalid query (division by zero)

SELECT price / 0
FROM products_op;

     
-- Use NULLIF function

SELECT price / NULLIF(quantity, 0)
FROM products_op;

     
-- Relational Operators (=, <, >, <=, >=, <>, !=)
-- Compare values to return TRUE/FALSE.


DROP TABLE IF EXISTS emp_rel;

CREATE TABLE emp_rel (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT
);

INSERT INTO emp_rel (emp_id, emp_name, salary) VALUES
(1, 'Arjun Raj', 60000),
(2, 'Priya Nair', 45000),
(3, 'Ramesh Kumar', 70000);

SELECT * FROM emp_rel;

SELECT *
FROM emp_rel
WHERE salary >= 50000;

SELECT *
FROM emp_rel
WHERE salary <> 60000;

SELECT *
FROM emp_rel
WHERE salary = 45000;

DESCRIBE emp_rel;

-- Invalid query (datatype mismatch)

SELECT *
FROM emp_rel
WHERE salary = 'ABC';

-- Logical Operators (AND, OR, NOT)
-- Combine multiple conditions in WHERE clause.

DROP TABLE IF EXISTS cust_logic;

CREATE TABLE cust_logic (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    status VARCHAR(20)
);

     

DESCRIBE cust_logic;

     
INSERT INTO cust_logic VALUES (1, 'Arjun Raj', 'Bengaluru', 'Active');

INSERT INTO cust_logic VALUES (2, 'Priya Nair', 'Chennai', 'Inactive');

INSERT INTO cust_logic VALUES (3, 'Ramesh Kumar', 'Hyderabad', 'Active');

INSERT INTO cust_logic VALUES (4, 'Kavita Desai', 'Mumbai', 'Active');

SELECT * FROM cust_logic;

SELECT *
FROM cust_logic
WHERE city = 'Chennai'
  AND status = 'Inactive';
  
SELECT *
FROM cust_logic
WHERE city = 'Mumbai'
   OR city = 'Chennai';

SELECT *
FROM cust_logic
WHERE NOT city = 'Delhi';

     

SELECT *
FROM cust_logic
WHERE status = 'Active'
  AND customer_id > 1;

-- Special Operators
-- Concatenation Operator

SELECT CONCAT(customer_name, ' from ', city) AS full_info
FROM cust_logic;

SELECT CONCAT(customer_name, status)
FROM cust_logic;

-- IN Operator

SELECT *
FROM cust_logic
WHERE city IN ('Mumbai', 'Chennai');

SELECT *
FROM cust_logic
WHERE customer_id IN (1, 2, 3);

-- BETWEEN Operator

SELECT *
FROM emp_rel
WHERE salary BETWEEN 45000 AND 70000;

     
-- LIKE Operator

SELECT *
FROM cust_logic
WHERE customer_name LIKE 'A%';

     

SELECT *
FROM cust_logic
WHERE customer_name LIKE '%S';

-- IS NULL Operator

SELECT *
FROM cust_logic
WHERE status IS NULL;

     

SELECT *
FROM cust_logic
WHERE status IS NOT NULL;

     

SELECT * 
FROM cust_logic 
WHERE Status != NULL; -- No results
     

SELECT *
FROM emp_rel
WHERE salary > (
    SELECT salary
    FROM emp_rel
    WHERE emp_name = 'Priya Nair'
);

     

SELECT *
FROM emp_rel
WHERE salary > ANY (
    SELECT salary
    FROM emp_rel
);

-- EXISTS Operator

SELECT *
FROM cust_logic c
WHERE EXISTS (
    SELECT 1
    FROM emp_rel e
    WHERE e.emp_id = c.customer_id
);

CREATE TABLE orders_trunc (
    order_id INT,
    order_date DATE
);
--      
-- Question

CREATE TABLE orderss (
    order_id INT PRIMARY KEY,
    order_date DATETIME,
    order_customer_id INT,
    order_status VARCHAR(30)
);


INSERT INTO orderss (order_id, order_date, order_customer_id, order_status)
VALUES
(1,  '2013-07-25 00:00:00', 11599, 'CLOSED'),
(2,  '2013-07-25 00:00:00', 256,   'PENDING_PAYMENT'),
(3,  '2013-07-25 00:00:00', 12111, 'COMPLETE'),
(4,  '2013-07-25 00:00:00', 8827,  'CLOSED'),
(5,  '2013-07-25 00:00:00', 11318, 'COMPLETE'),
(6,  '2013-07-25 00:00:00', 7130,  'COMPLETE'),
(7,  '2013-07-25 00:00:00', 4530,  'COMPLETE'),
(8,  '2013-07-25 00:00:00', 2911,  'PROCESSING'),
(9,  '2013-07-25 00:00:00', 5657,  'PENDING_PAYMENT'),
(10, '2013-07-25 00:00:00', 5648,  'PENDING_PAYMENT'),
(11, '2013-07-25 00:00:00', 918,   'PAYMENT_REVIEW'),
(12, '2013-07-25 00:00:00', 1837,  'CLOSED'),
(13, '2013-07-25 00:00:00', 9149,  'PENDING_PAYMENT'),
(14, '2013-07-25 00:00:00', 9842,  'PROCESSING'),
(15, '2013-07-25 00:00:00', 2568,  'COMPLETE'),
(16, '2013-07-25 00:00:00', 7276,  'PENDING_PAYMENT'),
(17, '2013-07-25 00:00:00', 2667,  'COMPLETE'),
(18, '2013-07-25 00:00:00', 1205,  'CLOSED'),
(19, '2013-07-25 00:00:00', 9488,  'PENDING_PAYMENT'),
(20, '2013-07-25 00:00:00', 9198,  'PROCESSING');

Describe orderss;
Select  * from orderss;

-- notebook 4

-- Sample EMP Table Setup
-- The following table is used for string function examples that operate on table data.


CREATE TABLE emp (
    empno INT PRIMARY KEY,
    ename VARCHAR(20),
    job VARCHAR(20)
);

INSERT INTO emp VALUES
(1, 'ALLEN', 'SALESMAN'),
(2, 'SMITH', 'CLERK'),
(3, 'BLAKE', 'MANAGER'),
(4, 'CLARK', 'MANAGER'),
(5, 'JONES', 'ANALYST');

--      
-- UPPER Function
-- The UPPER function converts all characters in a string to uppercase.



SELECT UPPER('today is a wonderful day') AS result;

     
-- LOWER Function
-- The LOWER function converts all characters in a string to lowercase.



SELECT LOWER('TODAY IS A WONDERFUL DAY') AS result;

     
-- This query capitalizes the first character and lowercases the remaining string.



SELECT CONCAT(
    UPPER(LEFT('today is a wonderful day', 1)),
    LOWER(SUBSTRING('today is a wonderful day', 2))
) AS result;

     
-- LENGTH Function
-- The LENGTH function returns the number of characters in a string.



SELECT LENGTH('AB CD') AS length_value;

     
-- Filtering Rows Using LENGTH
-- This query selects employees whose names contain exactly 5 characters.



SELECT ename
FROM emp
WHERE LENGTH(ename) = 5;

     
-- SUBSTRING Function
-- SUBSTRING extracts a portion of a string based on position and length.



SELECT SUBSTRING('ABCDEF', 2, 3) AS result;

     
-- SUBSTRING Without Length
-- Extracts the substring from the given position till the end.



SELECT SUBSTRING('ABCDEF', 2) AS result;

     
-- SUBSTRING with Negative Position
-- Negative position extracts characters starting from the end.



SELECT SUBSTRING('ABCDEF', -1) AS result;

     
-- SUBSTRING with Negative Position and Length


SELECT SUBSTRING('ABCDEF', -3, 2) AS result;

     
-- SUBSTRING Used in WHERE Clause


SELECT *
FROM emp
WHERE SUBSTRING(ename, 2, 2) = 'LA';

     
-- LOCATE Function (Equivalent to INSTR)
-- LOCATE returns the position of a substring within a string.



SELECT LOCATE('*', 'ABC*D') AS position;

     
-- LOCATE with Multi-Character Search


SELECT LOCATE('DC', 'ABDCDEF') AS position;

     
-- LPAD Function
-- LPAD pads a string on the left with a specified character.



SELECT LPAD('ABCD', 10, '*') AS padded_value;

     
-- RPAD Function
-- RPAD pads a string on the right with a specified character.



SELECT RPAD('ABCD', 10, '*') AS padded_value;

     
-- LENGTH with Leading and Trailing Spaces


SELECT LENGTH('             ABC                ') AS length_value;

     
-- LTRIM Function
-- LTRIM removes leading spaces or specified characters.



SELECT 
    LTRIM('             ABC                ') AS trimmed_value,
    LENGTH(LTRIM('             ABC                ')) AS length_after_ltrim;

     
-- LTRIM with Custom Character


SELECT LTRIM('******ABC********', '*') AS result;

     
-- RTRIM Function


SELECT 
    RTRIM('             ABC                ') AS trimmed_value,
    LENGTH(RTRIM('             ABC                ')) AS length_after_rtrim;

     
-- RTRIM with Custom Character


SELECT RTRIM('******ABC********', '*') AS result;

     
-- TRIM Function
-- TRIM removes both leading and trailing spaces or characters.



SELECT 
    TRIM('             ABC                ') AS trimmed_value,
    LENGTH(TRIM('             ABC                ')) AS length_after_trim;

     
-- TRIM with Custom Character


SELECT TRIM('*' FROM '******ABC********') AS result;

     
-- REPLACE Function
-- REPLACE substitutes occurrences of a substring within a string.



SELECT 'ENTRY' AS original,
       REPLACE('ENTRY', 'TRY', 'TER') AS modified;

     
-- REPLACE Used on Table Column


SELECT job,
       REPLACE(job, 'SALESMAN', 'MARKETING') AS updated_job
FROM emp;

-- notebook 5


-- EMP & DEPT Case Study

CREATE DATABASE demo1;
     

USE demo1;
     
-- Create DEPT Table


CREATE TABLE dept (
    deptno INT,
    dname  VARCHAR(14),
    loc    VARCHAR(13)
);

     
-- Create EMP Table


CREATE TABLE emp (
    empno    INT,
    ename    VARCHAR(10),
    job      VARCHAR(9),
    mgr      INT,
    hiredate DATE ,
    sal      DECIMAL(7,2) ,
    comm     DECIMAL(7,2),
    deptno   INT
);

     
-- Insert Records into DEPT
INSERT INTO dept VALUES
(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON');

     
-- Insert Records into EMP
INSERT INTO emp VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800.00,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
(7788,'SCOTT','ANALYST',7566,'1982-12-09',3000.00,NULL,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30),
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100.00,NULL,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950.00,NULL,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);

-- Solve the following queries
-- Retrieve employees whose annual salary exceeds 30,000
SELECT *
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.sal * 12 > 30000;


-- Retrieve employees who are analysts and salesmen
SELECT *
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE job in ('ANALYST','MANAGER');
-- Retrieve unique job roles
select distinct job from emp;
-- Retrieve the SALESMAN and change job title to MARKETING in the result set

-- Retrieve the highest salary paid to employee
select MAX(sal) from emp;
-- Retrieve the lowest salary paid to employee
SELECT MIN(sal) FROM emp;

-- Retrieve total number of employees
select count(*) from emp;
-- Retrieve unique departments
select distinct dname from dept;
-- Retrieve total salary paid to each department
SELECT dept.deptno, SUM(emp.sal) AS total_salary
FROM emp
JOIN dept ON emp.deptno = dept.deptno
GROUP BY dept.deptno
ORDER BY dept.deptno;


-- notebook 6


-- MySQL Date & Time Functions
-- Current Date
-- CURDATE() returns the current date without time.



SELECT CURDATE() AS today;

     
-- Tomorrow's Date
-- Dates can be incremented using INTERVAL.



SELECT CURDATE() + INTERVAL 1 DAY AS tomorrow;

     
-- Yesterday's Date


SELECT CURDATE() - INTERVAL 1 DAY AS yesterday;

     
-- Date Difference Using Same Date


SELECT DATEDIFF(CURDATE(), CURDATE()) AS date_difference;

     
-- Date Difference

SELECT DATEDIFF(CURDATE(), '2025-01-23') AS date_difference;
     
-- Formatting Date (DD/MM/YY)


SELECT DATE_FORMAT(CURDATE(), '%d/%m/%y') AS formatted_date;

     
-- Day Name in Uppercase


SELECT UPPER(DAYNAME(CURDATE())) AS day_name_upper;

     
-- Day Name in Lowercase


SELECT LOWER(DAYNAME(CURDATE())) AS day_name_lower;

     
-- Abbreviated Day Name


SELECT DATE_FORMAT(CURDATE(), '%a') AS day_abbreviation;

     
-- Current Timestamp


SELECT NOW() AS current_time;

     
-- Current Time

SELECT current_time();
     
-- Extract Time from Timestamp


SELECT DATE_FORMAT(CURRENT_TIMESTAMP(), '%H:%i:%s') AS current_time;

     
-- String to Date Conversion


SELECT STR_TO_DATE('24/09/25', '%d/%m/%y') AS converted_date;

     
-- Last Day of Current Month


SELECT LAST_DAY(CURDATE()) AS month_end;

-- notebook 7

-- NOT NULL
-- Ensures a column cannot store NULL values.
     

DROP TABLE IF EXISTS cust_notnull;

     

CREATE TABLE IF NOT EXISTS cust_notnull (
    customer_id INT NOT NULL,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100)
);

DESC cust_notnull;

     

INSERT INTO cust_notnull (customer_id, customer_name, email)
VALUES (1, 'Arjun Sharma', 'arjun@example.com');

INSERT INTO cust_notnull (customer_id, customer_name)
VALUES (2, 'Priya Nair');

     

SELECT * FROM cust_notnull;
     

INSERT INTO cust_notnull (customer_id, customer_name)
VALUES (NULL, 'Ramesh Iyer');
 -- Invalid
     

INSERT INTO cust_notnull (customer_id, customer_name)
VALUES (3, 'ramesh@example.com'); -- Invalid
     

SELECT * FROM CUST_NOTNULL;

-- UNIQUE
-- Prevents duplicate values in a column.


DROP TABLE cust_unique;

CREATE TABLE cust_unique (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);

     

DESCRIBE cust_unique;

     

INSERT INTO cust_unique (customer_id, customer_name, email)
VALUES (1, 'Kavita Pal', 'kavita@example.com');

INSERT INTO cust_unique (customer_id, customer_name, email)
VALUES (2, 'Neha Gupta', NULL);

     

SELECT * FROM cust_unique;

     

INSERT INTO cust_unique (customer_id, customer_name, email)
VALUES (3, 'Manoj Verma', 'kavita@example.com');

     

INSERT INTO cust_unique (customer_id, customer_name, email)
VALUES (4, 'Arjun Lal', 'kavita@example.com');

SELECT * FROM cust_unique;

-- CHECK
-- Restricts values to satisfy a condition.


DROP TABLE IF EXISTS od_check;

     

CREATE TABLE od_check (
    order_id INT,
    product_name VARCHAR(50),
    quantity INT CHECK (quantity BETWEEN 1 AND 100),
    price INT CHECK (price >= 1)
);

     

DESCRIBE od_check;

     

INSERT INTO od_check (order_id, product_name, quantity, price)
VALUES (101, 'Laptop', 1, 800);

INSERT INTO od_check (order_id, product_name, quantity, price)
VALUES (101, 'Mouse', 2, 200);

     

SELECT * FROM od_check;

     

INSERT INTO od_check VALUES (102, 'TV', 0, 1500);  -- Invalid

     

INSERT INTO od_check VALUES (103, 'Remote', 1, -10);  -- Invalid
     

SELECT * FROM od_check;

-- PRIMARY KEY
-- Combines NOT NULL + UNIQUE to identify each row.

DROP TABLE IF EXISTS prod_pk;

CREATE TABLE prod_pk (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

DESCRIBE prod_pk;

INSERT INTO prod_pk (product_id, product_name)
VALUES (1, 'Laptop');

INSERT INTO prod_pk (product_id, product_name)
VALUES (2, 'Mouse');

     

SELECT * FROM PROD_PK;
     

INSERT INTO prod_pk
VALUES (2, 'Another Mouse');
-- Invalid
     

INSERT INTO PROD_PK VALUES (NULL, 'TV'); -- Invalid
     

SELECT * FROM PROD_PK;

-- FOREIGN KEY
-- Links child to parent table.


DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS cust_fk;

CREATE TABLE cust_fk (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL
);

     

DESC cust_fk;
     

CREATE TABLE orders_fk (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES cust_fk(customer_id)
);

     

DESC ORDERS_FK;
     

SHOW CREATE TABLE orders_fk1;
     

CREATE TABLE orders_fk1 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES cust_fk(customer_id)
);

     

DESC orders_fk1;
     

SHOW CREATE TABLE orders_fk1;
     

INSERT INTO cust_fk
VALUES (1, 'Arjun Sharma');

INSERT INTO cust_fk
VALUES (2, 'Priya Nair');

     

INSERT INTO orders_fk
VALUES (101, 1, '2025-01-10');

     

INSERT INTO orders_fk
VALUES (102, 2, STR_TO_DATE('2025-01-11', '%Y-%m-%d'));

SELECT * FROM CUST_FK;
     

SELECT * FROM ORDERS_FK;

INSERT INTO orders_fk
VALUES (103, 999, STR_TO_DATE('2025-01-12', '%Y-%m-%d'));
 -- Invalid
     

SELECT * FROM CUST_FK;
     

SELECT * FROM ORDERS_FK;

-- notebook 8
USE emp;

SELECT sal FROM emp;

     
-- MAX Function
-- The MAX function returns the highest value in a column.


SELECT MAX(sal) FROM emp;

-- MIN Function
-- The MIN function returns the lowest value in a column.


SELECT MIN(sal) FROM emp;

     
-- SUM Function
-- The SUM function returns the total of all values in a column.

SELECT SUM(sal) FROM emp;

AVG Function
The AVG function returns the average of values in a column.


SELECT AVG(sal) FROM emp;

     
-- COUNT Function
-- The COUNT function counts rows or column values.

-- COUNT(*) counts all rows.
-- COUNT(column) counts non-NULL values.

SELECT COUNT(*) FROM emp;

     

SELECT COUNT(ename) FROM emp;

     

SELECT COUNT(SAL) FROM EMP;
     

SELECT COUNT(COMM) FROM EMP;

-- DISTINCT with COUNT
-- The DISTINCT keyword ensures only unique values are considered.

SELECT deptno FROM emp;

SELECT DISTINCT deptno FROM emp;

SELECT COUNT(DISTINCT deptno) FROM emp;

-- GROUP BY CLAUSE
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;

     

SELECT job, COUNT(*)
FROM emp
GROUP BY job;

     

SELECT deptno, MIN(sal), MAX(sal)
FROM emp
GROUP BY deptno;

     

SELECT deptno
FROM emp
GROUP BY deptno;

SELECT deptno, ename
FROM emp
GROUP BY deptno, ename;

SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY deptno, job;

SELECT SUM(sal)
FROM emp
GROUP BY deptno;

SELECT SUM(sal)
FROM emp
GROUP BY deptno;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno;

     
-- HAVING Clause
-- The HAVING clause filters groups after aggregation.

-- Rules for HAVING:

-- HAVING is applied after GROUP BY and aggregates are computed.
-- WHERE filters rows before grouping, HAVING filters groups after grouping.
-- You can use aggregate functions inside HAVING.

SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
HAVING COUNT(*) > 3;

     
-- ORDER BY Clause
-- The ORDER BY clause sorts the results.

-- Rules for ORDER BY:

-- ORDER BY is the last clause executed.
-- You can order by column names, aliases, or column positions.
-- Default order is ASC (ascending). Use DESC for descending.
-- ORDER BY works with grouped and aggregated results.

SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
HAVING COUNT(*) > 3
ORDER BY COUNT(*) ASC;

-- NOTEBOOK 9

-- EMP & DEPT Case Study
-- Create DEPT Table

CREATE DATABASE TEST;
USE TEST;

CREATE TABLE dept (
    deptno INT PRIMARY KEY,
    dname  VARCHAR(14) NOT NULL,
    loc    VARCHAR(13)
);

     
-- Create EMP Table


CREATE TABLE emp (
    empno    INT PRIMARY KEY,
    ename    VARCHAR(10) NOT NULL,
    job      VARCHAR(9)  NOT NULL,
    mgr      INT,
    hiredate DATE NOT NULL,
    sal      DECIMAL(7,2) CHECK (sal > 0),
    comm     DECIMAL(7,2),
    deptno   INT,
    CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES dept(deptno)
);

-- Insert Records into DEPT


INSERT INTO dept VALUES
(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON');

     
-- Insert Records into EMP


INSERT INTO emp VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800.00,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
(7788,'SCOTT','ANALYST',7566,'1982-12-09',3000.00,NULL,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30),
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100.00,NULL,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950.00,NULL,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);

-- Sample Queries


SELECT ename, sal, sal * 12 AS annual_salary
FROM emp
WHERE sal * 12 > 30000;

     


SELECT deptno, COUNT(*) AS emp_count
FROM emp
GROUP BY deptno
HAVING COUNT(*) > 3
ORDER BY emp_count ASC;

     
-- Assignment
-- Retrieve employees whose job role is either SALESMAN or ANALYST.
SELECT * FROM emp
WHERE JOB IN ('SALESMAN', 'ANALYST');

-- Retrieve employees whose names start with the letter 'M'.
SELECT * from emp
where ename like 'M%';
;

-- Retrieve employees hired in the year 1981.
select * from emp
where YEAR(hiredate)= 1981;

-- Retrieve minimum and maximum salary per department.
SELECT 
    MAX(dept_sal) AS max_dept_salary,
    MIN(dept_sal) AS min_dept_salary
FROM (
    SELECT SUM(sal) AS dept_sal
    FROM emp
    GROUP BY deptno
) sub;

-- Retrieve employees who were hired on a Thursday.
Select * from emp
where Date_format(hiredate, '%a') = 'Thu';
-- Retrieve departments having more than 3 employees.
select deptno from emp
group by deptno
having count(*) > 3;
-- Calculate the number of months each employee has worked.

