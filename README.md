SELECT *
FROM table_name
WHERE column_name IN (
    SELECT column_name
    FROM table_name
    GROUP BY column_name
    HAVING COUNT(*) > 1
);
