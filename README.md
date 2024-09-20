SELECT TOP 100 PERCENT 
issue.IssueID,issue.IssueCode,issue.IssueRaisedBy as raisedbyid,risedby.FirstName +' '+ risedby.LastName as issuerisedby,issue.IssueDate,issue.IssueShotDesc,issue.IssueDesc,
issue.IssueRaiseFor as issuerisedforid,risedfor.FirstName +' '+ risedfor.LastName as issuerisedfor,issue.IssueForGuest,
issue.GuestCompany,issue.PlantID,plant.Code as plantname,issue.AssetID,issue.CategoryID,cat.CategoryName,issue.CategoryTypID,cattyp.CategoryType,
issue.Priority as priorityid,prio.PriorityName,issue.Source,issue.Attachment,issue.Status,
issue.Type,issue.AssignedTo as AssignedToid,
isnull(assignto.First_Name,null) + isnull(assignto.Middle_Name,null) + isnull(assignto.Last_Name,null) as AssignedTo,issue.AssignedBy as assignedbyid,
 isnull(assignby.First_Name,null) +' '+ isnull(assignby.Middle_Name,null) +' '+ isnull(assignby.Last_Name,null) as AssignedBy,issue.AssignedOn,issue.ProposedResolutionOn,issue.ResolutionDt,issue.ResolutionRemarks,
issue.Remarks,issue.CreatedBy,issue.CreatedDt,issue.ModifiedBy,issue.ModifiedDt,
(select (case 
			when ((datediff(WEEKDAY,issue.IssueDate,getdate()))>sla.WaitTime) then 'R'
			when ((datediff(WEEKDAY,issue.IssueDate,getdate()))=sla.WaitTime) then 'Y'
			when ((datediff(WEEKDAY,issue.IssueDate,getdate()))<sla.WaitTime) then 'G'
			End) from IT.SLA sla where sla.PlantID=issue.PlantID and sla.CategoryID=issue.CategoryID and sla.CategoryTypID=issue.CategoryTypID ) as slastatus

			from 
			IT.IssueListHistory as issue
			left join HR.Employee as risedby on risedby.EmployeeID = cast(issue.IssueRaisedBy as varchar(20))
			left join HR.Employee as risedfor on risedfor.EmployeeID = cast(issue.IssueRaiseFor as varchar(20))
			left join it.SupportTeam as assignby on assignby.SupportTeamID = issue.AssignedBy or assignby.EmpID = issue.AssignedBy
			left join it.SupportTeam as assignto on assignto.EmpID = issue.AssignedTo
			left join Plant_Master plant on plant.Id=issue.PlantID
			left join it.Category cat on cat.ITCategoryID=issue.CategoryID
			left join it.CategoryTyp cattyp on cattyp.CategoryTypeID=issue.CategoryTypID
			left join it.Priority prio on prio.PriorityID=issue.Priority
		order by issue.ModifiedDt desc
