SELECT 
    t.TABLE_NAME, 
    t.TABLE_SCHEMA, 
    t.TABLE_TYPE, 
    c.CONSTRAINT_TYPE
FROM 
    INFORMATION_SCHEMA.TABLES t
LEFT JOIN 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS c 
ON 
    t.TABLE_NAME = c.TABLE_NAME 
    AND t.TABLE_SCHEMA = c.TABLE_SCHEMA
WHERE 
    t.TABLE_TYPE = 'BASE TABLE' 
    AND t.TABLE_SCHEMA = 'IT';
