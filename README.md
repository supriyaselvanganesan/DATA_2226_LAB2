# Lab- 2: Building an end to end Data Analytics using Snowflake, Airflow, dbt, and a BI tool

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
* Configure Airflow connections (Snowflake, API)
* Run Airflow and enable the ETL DAG
* dbt DAG executes after ETL
* Validate transformed tables in Snowflake
* Link the BI tool to Snowflake and build visualizations
