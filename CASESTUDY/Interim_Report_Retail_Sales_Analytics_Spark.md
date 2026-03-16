## 1. Introduction

Retail organizations often receive data from multiple operational systems (e.g., Customer Relationship Management (CRM) and Enterprise Resource Planning (ERP) systems). This data is frequently inconsistent in schema, data types, codes, and quality. Without a standardized analytics-ready dataset, business reporting becomes slow, error-prone, and difficult to scale.

This project builds an end-to-end analytics pipeline using the **Apache Spark DataFrame API** to ingest raw retail datasets and transform them into a curated dimensional model. The pipeline follows a **Medallion architecture**:
- **Bronze**: raw data ingestion with schema applied and storage as Parquet (as-is).
- **Silver**: cleaned, standardized, deduplicated datasets with consistent codes and types.
- **Gold**: business-ready dimensional tables (**`dim_customers`**, **`dim_products`**, **`fact_sales`**) and analytics outputs.

### Aim
To design and implement a Spark-based data engineering pipeline that converts multi-source retail data into **trusted Gold tables** and produces **business insights using only the Spark DataFrame API**.

### Scope
- Ingest CSV data from Customer Relationship Management (CRM) and Enterprise Resource Planning (ERP) sources into a Bronze layer (Parquet).
- Perform data quality improvements in Silver (type casting, standardization, invalid handling, deduplication).
- Build Gold dimensional model (dimensions + fact table).
- Generate analytics requested in the problem statement (timeline coverage, customer age, sales metrics, breakdowns, revenue, top/bottom analysis).

### Work done so far (summary)
The Bronze/Silver/Gold pipeline and the required analytics queries have been implemented as an end-to-end Spark DataFrame solution.

---

## 2. Requirements Analysis (Software Development–Based Project)

### 2.1 Stakeholder Requirements
Stakeholders for this project include:
- **Business analysts / management**: need consistent metrics (sales, revenue, top customers/products, breakdowns) for decision-making.
- **Data engineering team**: need a reproducible, scalable pipeline (Bronze/Silver/Gold) that can be re-run and extended.
- **Data consumers (BI / reporting)**: need dimensional tables with stable keys and consistent definitions.

High-level stakeholder requirements:
- Data from **Customer Relationship Management (CRM)** systems (customers, products, sales) and **Enterprise Resource Planning (ERP)** systems (customer demographics, locations, product categories) must be combined.
- Data must be cleaned and standardized to avoid incorrect analytics.
- Outputs must be reproducible and generated using **Spark DataFrame API**.
- Gold tables must support business questions and future reporting needs.

### 2.2 Functional and Non-functional Requirements

#### Functional Requirements
- **FR1 (Bronze ingest)**: Read all raw CSV datasets with headers and inferred schema; persist each as **Parquet** in the Bronze layer.
- **FR2 (Silver cleansing)**:  
  - Correct data types (e.g., cast date fields, numeric types).  
  - Normalize codes (gender, marital status, country codes).  
  - Handle invalid values (e.g., future birthdates, null/negative sales/price).  
  - Deduplicate customer records using latest `cst_create_date`.
- **FR3 (Gold modeling)**: Create dimensional model:
  - `dim_customers` by combining Customer Relationship Management (CRM) and Enterprise Resource Planning (ERP) customer and location data
  - `dim_products` by combining CRM products with ERP category data
  - `fact_sales` by joining sales to `dim_customers` and `dim_products`
- **FR4 (Analytics deliverables)**: Using Gold tables, compute:
  - Order timeline coverage (first/last order dates; coverage months)
  - Customer age analysis (youngest & oldest customers; approximate)
  - Sales summary metrics (total sales, total quantity, average price)
  - Customer breakdowns (by country and gender)
  - Product breakdowns (products by category; average cost by category)
  - Revenue insights (by category; by customer)
  - Top/Bottom analysis:
    - Top 5 products by revenue (simple + using window rank)
    - Bottom 5 products by revenue
    - Top 10 customers by revenue
    - 3 customers with fewest orders (only customers with at least 1 order)

#### Non-functional Requirements
- **NFR1 (Scalability)**: Must handle larger-than-memory datasets via Spark distributed processing.
- **NFR2 (Reproducibility)**: Pipeline should be re-runnable end-to-end with deterministic outputs (given fixed input data).
- **NFR3 (Data quality)**: Must document and apply consistent rules for invalid/missing values.
- **NFR4 (Maintainability)**: Transformations should be modular by layer (Bronze/Silver/Gold) and readable.
- **NFR5 (Performance)**: Use Parquet for storage; avoid repeated expensive reads by persisting intermediate results when appropriate.

---

## 3. Methodology

### 3.1 Overall Approach
This project follows a layered data engineering approach:
- **Bronze layer** stores raw ingested data as Parquet for durability and faster reads.
- **Silver layer** standardizes schema and cleans data to a consistent format suitable for modeling.
- **Gold layer** constructs a dimensional model (dimensions + fact) for analytics and reporting.

#### 3.1.1 Data Sources
- **Customer Relationship Management (CRM) system**:
  - Customer details table (names, marital status, gender)
  - Product catalog table (product names, costs, product lines)
  - Sales transactions table (orders, quantities, prices, order-related dates)
- **Enterprise Resource Planning (ERP) system**:
  - Customer demographics table (birthdates, gender)
  - Customer locations table (countries)
  - Product categories table (categories, subcategories, maintenance indicators)

### 3.2 Tools and Techniques
- **Apache Spark (PySpark DataFrame API)**: primary processing framework.
- **Parquet**: columnar storage to improve performance and reduce storage size.
- **Window functions** (e.g., `row_number`, `lead`, `rank`) for:
  - customer deduplication by latest record
  - product effective-dating logic
  - ranking top products by revenue
- **Data quality rules** implemented with DataFrame transformations (`when`, `coalesce`, `trim`, `upper`, casting).

### 3.3 Data Cleaning and Standardization Rules (Silver)
Key applied rules include:
- **Customer data**:
  - Remove null `cst_id`
  - Deduplicate by latest `cst_create_date` per `cst_id`
  - Standardize `cst_marital_status` to `Single`, `Married`, or `n/a`
  - Standardize `cst_gndr` to `Male`, `Female`, or `n/a`
- **Product data**:
  - Derive category id from product key and normalize to match Enterprise Resource Planning (ERP) id format
  - Standardize product line codes to meaningful labels
  - Fill null product cost with 0
  - Convert start/end dates; compute end date using `lead(start_date) - 1`
- **Sales data**:
  - Convert numeric date keys into Spark `date` type; invalid 0 / malformed → null
  - Fix sales amount using rule: if missing/invalid then `quantity * abs(price)`
  - Fix price using rule: if missing/invalid then `sales / quantity`
- **Enterprise Resource Planning (ERP) data**:
  - Normalize customer ids (remove `NAS` prefix where present)
  - Remove future birthdates
  - Standardize gender values to `Male`, `Female`, or `n/a`
  - Normalize country codes (e.g., `DE` → Germany, `US/USA` → United States)

### 3.4 Gold Dimensional Modeling
Gold tables are created using **surrogate keys**:
- `dim_customers`: assigns `customer_key` via `row_number` over ordered customer ids.
- `dim_products`: assigns `product_key` via `row_number` ordered by start date and product number.
- `fact_sales`: joins sales to dimensions and selects measures and dates.

---

## 4. Progress Update (last ~30 days)

### 4.1 Pipeline Milestones Achieved
- Bronze ingestion to Parquet completed for all source datasets.
- Silver layer cleansing/standardization implemented and persisted.
- Gold dimensional model created (`dim_customers`, `dim_products`, `fact_sales`).
- Analytics queries implemented using DataFrame API (including window functions for ranking).

### 4.2 Challenges Encountered and How They Were Addressed
- **Multi-source ingestion consistency** (Customer Relationship Management (CRM) and Enterprise Resource Planning (ERP)):
  - Addressed by applying headers/schema on read and persisting standardized column types for downstream layers.
- **Duplicate/late-arriving customer records**:
  - Addressed using window-based deduplication to retain the latest customer record per business key.
- **Inconsistent codes and identifiers across sources** (gender/marital codes, country abbreviations, customer id formatting):
  - Addressed via normalization rules (trim/case standardization, code mapping, and id cleaning).
- **Invalid or incomplete transactional fields** (date keys, sales amount, and price anomalies):
  - Addressed through defensive parsing of dates and rule-based corrections for inconsistent measures.
- **Dimension join alignment (products/customers)**:
  - Addressed by standardizing join keys (case/whitespace normalization) to improve matching when building the sales fact table.

### 4.3 Evidence of Progress
Evidence is available through execution outputs and saved tables, including:
- sample previews from Bronze ingestion
- persisted Parquet outputs for Bronze and Silver layers
- analytics query outputs (tables/prints generated during execution)

---

## 5. Results and Discussions

This section summarizes what the pipeline produces and what questions it answers. **Specific data values are intentionally not included** (overview only).

### 5.1 Gold Tables Created
- **`dim_customers`**: consolidated customer profile combining Customer Relationship Management (CRM) identity with Enterprise Resource Planning (ERP) demographics and location attributes.
- **`dim_products`**: curated product catalog enriched with ERP category/subcategory and product-line standardization.
- **`fact_sales`**: sales transactions linked to customer and product dimensions with standardized date fields and measures.

### 5.2 Analytics Outcomes (computed using Spark DataFrame API)

#### 5.2.1 Order Timeline Coverage
**Overview**: Computes the first and last order dates and derives overall timeline coverage, enabling trend and seasonality analysis.

#### 5.2.2 Customer Age Analysis (approx.)
**Overview**: Estimates age from birthdate to identify youngest/oldest customers and highlights potential outliers that need validation rules.

#### 5.2.3 Sales Summary Metrics
**Overview**: Produces high-level KPIs (sales, quantity, price) as baseline business performance indicators.

#### 5.2.4 Customer Breakdowns
**Overview**: Breaks down customer base by country and gender to support market segmentation and data completeness checks.

#### 5.2.5 Product Breakdowns
**Overview**: Summarizes product distribution by category and computes category-level cost averages to understand catalog mix and cost structure.

#### 5.2.6 Revenue Insights
**Overview**: Aggregates revenue by category and by customer, enabling identification of top-performing categories and high-value customers.

#### 5.2.7 Top/Bottom Analysis (Products and Customers)
**Overview**:
- Identifies top and bottom products by revenue (including a window-based ranking approach).
- Identifies top customers by revenue and customers with the fewest orders (with at least one order).

**Discussion**: These outputs support inventory prioritization, targeted marketing, and rationalization of low-performing products.

---

## 6. Future Work (next 30 days)

The core pipeline and required analytics are complete. Future enhancements can focus on productionization and advanced analytics:
- Deploy orchestration using **Databricks Workflows** or **Apache Airflow**.
- Implement **Change Data Capture (CDC)** for incremental ingestion.
- Integrate monitoring alerts for **data quality failures**.
- Extend analytics with **machine learning** models for **churn prediction**.

---

## 7. Conclusion

This project successfully implements a Spark DataFrame pipeline following the Bronze → Silver → Gold architecture to produce an analytics-ready dataset for a retail business. The Silver layer improves data quality through standardization and corrections, and the Gold layer provides dimensional tables suitable for reporting. The requested analytics—timeline coverage, customer demographics, sales KPIs, breakdowns, revenue insights, and top/bottom analyses—have been computed using the Spark DataFrame API, demonstrating the viability of the approach for scalable retail analytics.

---

## 8. References (APA 7th)

Apache Spark. (2025). *Spark SQL, DataFrames and Datasets Guide*. Apache Software Foundation.  
`https://spark.apache.org/docs/latest/sql-programming-guide.html`

Kimball, R., & Ross, M. (2013). *The Data Warehouse Toolkit: The Definitive Guide to Dimensional Modeling* (3rd ed.). Wiley.

Lakehouse / Medallion architecture concept (general). (n.d.). *Medallion architecture (Bronze, Silver, Gold) overview*. Databricks documentation.  
`https://docs.databricks.com/`

The Apache Software Foundation. (2025). *Apache Parquet Documentation*.  
`https://parquet.apache.org/`

