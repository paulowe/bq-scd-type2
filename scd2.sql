MERGE
INTO `project.dataset.TABLE`
using (
# the base staging data.
SELECT `project.dataset.table_staging`.product_id AS join_key,
       `project.dataset.table_staging`.*
FROM   `project.dataset.table_staging`
UNION ALL
# generate an extra row FOR changed records.
# the NULL join_key forces down the INSERT path.
SELECT    NULL,
          `project.dataset.table_staging`.*
FROM      `project.dataset.table_staging`
JOIN      `project.dataset.table_staging`
