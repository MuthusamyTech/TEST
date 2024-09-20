SELECT TOP 100 PERCENT 
    issue.IssueID,
    issue.IssueCode,
    issue.IssueRaisedBy as raisedbyid,
    risedby.FirstName + ' ' + risedby.LastName as issuerisedby,
    issue.IssueDate,
    issue.IssueShotDesc,
    issue.IssueDesc, 
    issue.IssueRaiseFor as issuerisedforid,
    risedfor.FirstName + ' ' + risedfor.LastName as issuerisedfor,
    issue.IssueForGuest, 
    issue.GuestCompany,
    issue.PlantID,
    plant.Code as plantname,
    issue.AssetID,
    issue.CategoryID,
    cat.CategoryName,
    issue.CategoryTypID,
    cattyp.CategoryType, 
    issue.Priority as priorityid,
    prio.PriorityName,
    issue.Source,
    issue.Attachment,
    issue.Status, 
    issue.Type,
    issue.AssignedTo as AssignedToid, 
    ISNULL(assignto.First_Name, '') + ISNULL(assignto.Middle_Name, '') + ISNULL(assignto.Last_Name, '') as AssignedTo,
    issue.AssignedBy as assignedbyid, 
    ISNULL(assignby.First_Name, '') + ' ' + ISNULL(assignby.Middle_Name, '') + ' ' + ISNULL(assignby.Last_Name, '') as AssignedBy,
    issue.AssignedOn,
    issue.ProposedResolutionOn,
    issue.ResolutionDt,
    issue.ResolutionRemarks, 
    issue.Remarks,
    issue.CreatedBy,
    issue.CreatedDt,
    issue.ModifiedBy,
    issue.ModifiedDt,
    (SELECT 
        CASE 
            WHEN (DATEDIFF(WEEKDAY, issue.IssueDate, GETDATE()) > sla.WaitTime) THEN 'R' 
            WHEN (DATEDIFF(WEEKDAY, issue.IssueDate, GETDATE()) = sla.WaitTime) THEN 'Y' 
            WHEN (DATEDIFF(WEEKDAY, issue.IssueDate, GETDATE()) < sla.WaitTime) THEN 'G' 
        END 
     FROM IT.SLA sla 
     WHERE sla.PlantID = issue.PlantID 
     AND sla.CategoryID = issue.CategoryID 
     AND sla.CategoryTypID = issue.CategoryTypID) as slastatus,
    
    -- New columns for resolved values based on Status
    CASE 
        WHEN issue.Status = 'Resolved' THEN 
            ISNULL(assignby.First_Name, '') + ' ' + ISNULL(assignby.Last_Name, '')
        ELSE 
            NULL 
    END as ResolvedBy, -- Column for Resolved By

    CASE 
        WHEN issue.Status = 'Resolved' THEN 
            CONVERT(VARCHAR, issue.ResolutionDt, 106)
        ELSE 
            NULL 
    END as ResolvedOn, -- Column for Resolved On

    CASE 
        WHEN issue.Status = 'Resolved' THEN 
            ISNULL(issue.ResolutionRemarks, 'No Remarks')
        ELSE 
            NULL 
    END as ResolutionRemarks -- Column for Resolution Remarks
    
FROM 
    IT.IssueListHistory as issue
LEFT JOIN HR.Employee as risedby 
    ON risedby.EmployeeID = CAST(issue.IssueRaisedBy AS VARCHAR(20))
LEFT JOIN HR.Employee as risedfor 
    ON risedfor.EmployeeID = CAST(issue.IssueRaiseFor AS VARCHAR(20))
LEFT JOIN it.SupportTeam as assignby 
    ON assignby.SupportTeamID = issue.AssignedBy 
    OR assignby.EmpID = issue.AssignedBy
LEFT JOIN it.SupportTeam as assignto 
    ON assignto.EmpID = issue.AssignedTo
LEFT JOIN Plant_Master plant 
    ON plant.Id = issue.PlantID
LEFT JOIN it.Category cat 
    ON cat.ITCategoryID = issue.CategoryID
LEFT JOIN it.CategoryTyp cattyp 
    ON cattyp.CategoryTypeID = issue.CategoryTypID
LEFT JOIN it.Priority prio 
    ON prio.PriorityID = issue.Priority
ORDER BY 
    issue.ModifiedDt DESC;
