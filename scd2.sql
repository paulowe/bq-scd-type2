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
JOIN      `project.dataset.TABLE`
ON        `project.dataset.table_staging`.product_id = `project.dataset.TABLE`.product_id
WHERE     (
              `project.dataset.table_staging`.quantity <> `project.dataset.TABLE`.quantity
          AND  `project.dataset.TABLE`.end_date IS NULL)) sub
ON sub.join_key = `project.dataset.TABLE`.product_id
WHEN matched
AND sub.quantity <> `project.dataset.TABLE`.quantity THEN UPDATE
set end_date = CURRENT_DATE()
WHEN NOT matched THEN INSERT
       (
              product_id,
              product_name,
              quantity,
              start_date,
              end_date
       )
        VALUES
        (
               sub.product_id,
               sub.product_name,
               sub.quantity,
               CURRENT_DATE(),
               NULL
         );
