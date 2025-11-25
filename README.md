# Lab- 2: Building an end to end Data Analytics using Snowflake, Airflow, dbt, and BI tool

This project implements an end-to-end ELT data analytics workflow using Apache Airflow, Snowflake, dbt, and preset.
The goal is to demonstrate a data engineering pipeline covering:

* ETL: Load raw data into Snowflake using Airflow
* ELT: Transform data with dbt (scheduled through Airflow)
* Visualization: Build dashboards using transformed tables

### How to Run
#### Prerequisites
* Python 3.x
* Apache Airflow
* Snowflake account
* dbt-snowflake installed
* BI tool access (Preset)

### Steps
#### 1. Configure Airflow Connections
  * Before running the pipeline, configure the required Airflow connections in the Airflow UI:
  * 1.1. Create Snowflake Connection
  * In Airflow UI → Admin → Connections → + Add
  * Use these fields:
  * * Conn ID: snowflake_conn
    * Conn Type: Snowflake
    * Account: <your_account>
    * User: <your_username>
    * Password: <your_password>
    * Warehouse: <your_warehouse>
    * Database: <your_database>
    * Schema: <your_schema>
    * Role: <your_role>

#### 2. Start Airflow Services
* http://localhost:8081

#### 3. Daily ETL DAG Automatically Runs
* our ETL DAG contains a schedule

#### 4. dbt DAG Executes Automatically After ETL
   * tasks are :
   * * dbt run
     * dbt test
     * dbt snapshot
#### 5. Validate Transformed Tables in Snowflake
  * select * from USER_DB_KOALA.ANALYTICS.STOCK_PRICE_TECHNICAL_INDICATORS
  * select * from USER_DB_KOALA.SNAPSHOT.STOCK_PRICE_SNAPSHOT
   
#### 6. Link the BI tool to Snowflake and build visualizations using preset

### Full Automated Daily Pipeline
* Once everything is enabled:
* * ETL loads new raw data daily
  * dbt runs right after ETL
  * BI dashboards refresh when queries run
  * Pipeline is fully automated
