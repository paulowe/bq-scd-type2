# DML Statements
The BigQuery data manipulation language (DML) enables you to update, insert, and delete data from your BigQuery tables.

Conditions for executing DML
- Use standard SQL
- You cannot specify a destination table

## Limitations
Rows that were written to a table recently by using streaming (the tabledata.insertall method or the Storage Write API) 
cannot be modified with UPDATE, DELETE, or MERGE statements. Recent writes are typically those that occur within the last 30 minutes. 
Note that all other rows in the table remain modifiable by using UPDATE, DELETE, or MERGE statements.
