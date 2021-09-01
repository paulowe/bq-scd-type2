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
**The UPDATE, DELETE, and MERGE DML statements are called mutating DML statements.** If you submit one or more mutating DML statements on a table while other mutating DML jobs on it are still running (or pending), BigQuery runs up to 2 of them concurrently, after which up to 20 are queued as PENDING. When a previously running job finishes, the next pending job is dequeued and run. Currently, queued mutating DML statements share a per-table queue with maximum length 20. Additional statements past the maximum queue length for each table fail.

## DML statement conflicts
Mutating DML statements that run concurrently on a table cause DML statement conflicts when the statements try to mutate the same partition. The statements succeed as long as they don’t modify the same partition. BigQuery tries to rerun failed statements up to three times.

An INSERT DML statement that inserts rows to a table doesn't conflict with any other concurrently running DML statement.

A MERGE DML statement does not conflict with other concurrently running DML statements as long as the statement only inserts rows and does not delete or update any existing rows. This can include MERGE statements with UPDATE or DELETE clauses, as long as those clauses aren't invoked when the query runs.

## Best practices and patterns for improved performance
- Avoid submitting large numbers of individual row updates or insertions. Instead, group DML operations together
- If updates or deletions generally happen on older data, or within a particular range of dates, consider partitioning your tables
- If you often update rows where one or more columns fall within a narrow range of values, consider using clustered tables. Clustering ensures that changes are limited to specific sets of blocks, reducing the amount of data that needs to be read and written.

