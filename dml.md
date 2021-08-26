# DML Statements
The BigQuery data manipulation language (DML) enables you to update, insert, and delete data from your BigQuery tables.

Conditions for executing DML
- Use standard SQL
- You cannot specify a destination table

## Limitations
- Rows that were written to a table recently by using streaming (the tabledata.insertall method or the Storage Write API) 
cannot be modified with UPDATE, DELETE, or MERGE statements. Recent writes are typically those that occur within the last 30 minutes. 
Note that all other rows in the table remain modifiable by using UPDATE, DELETE, or MERGE statements.

- Queries that contain DML statements cannot use a wildcard table as the target of the query. Wildcard tables enable you to query multiple tables using concise SQL statements. Wildcard tables are available only in standard SQL
``` 
FROM
`bigquery-public-data.noaa_gsod.gsod*
``` 
type of queries

### UPDATE, DELETE, MERGE DML concurrency
The UPDATE, DELETE, and MERGE DML statements are called mutating DML statements. If you submit one or more mutating DML statements on a table while other mutating DML jobs on it are still running (or pending), BigQuery runs up to 2 of them concurrently, after which up to 20 are queued as PENDING. When a previously running job finishes, the next pending job is dequeued and run. Currently, queued mutating DML statements share a per-table queue with maximum length 20. Additional statements past the maximum queue length for each table fail.
