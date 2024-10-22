SELECT 
    t.name AS TableName,
    c.name AS ConstraintName,
    c.type_desc AS ConstraintType
FROM 
    sys.tables t
    INNER JOIN sys.objects c ON t.object_id = c.parent_object_id
WHERE 
    t.name = 'YourTableName';
