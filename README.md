  CASE 
        WHEN issue.Status = 'Resolved' THEN 'ResolvedValue' 
        ELSE NULL 
    END as resolved_value
