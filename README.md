# Implementation of Slowly Changing Dimension type 2 load strategy in BigQuery
Quick start:
- [Data Manipulation Language (DML) in BigQuery](https://github.com/paulowe/bq-scd-type2/blob/main/dml.md)


SCD2 Maintains dimension history by creating newer ‘versions’ of a dimension record whenever its source changes. SCD2 does not delete or modify existing data. Basically when the source data changes you expire the existing record in the dimension table via an indicator (boolean or date or any standard technique of marking a record as expired by setting a flag).

Considering we have a staging table which holds the records from the source and these records need to be pushed to the target dimension table in the data warehouse (Bigquery), then this [SQL query](https://github.com/paulowe/bq-scd-type2/blob/main/scd2.sql) will expire the old data and insert the new record and performs a normal insert for the additional new records , acheived using the merge command.
