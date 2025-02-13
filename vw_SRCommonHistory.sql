USE [MicroLabs_Dev]
GO

/****** Object:  View [IT].[vw_SRCommonHistory]    Script Date: 2025-02-13 10:16:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER   VIEW [IT].[vw_SRCommonHistory] AS
		SELECT
	ssh.SRID,
	ssh.SRCode,
	sup.[SupportName],
	ssh.[Remarks],
    sr.[Justification],
	ssh.[Status],
    sr.[IsActive],
	isNull( emp.FirstName,'')+' '+' '+ isNULL(emp.MiddleName,'')+ ' ' + isNull(emp.LastName,'') AS CreatedByName,
    ssh.[CreatedDt],
	isNull( modifyemp.FirstName,'')+' '+' '+ isNULL(modifyemp.MiddleName,'')+ ' ' + isNull(modifyemp.LastName,'') AS ModifiedByName,
	ssh.[ModifiedDt],
	srRes.ResolRemarks,
	srRes.UserRemarks,
	srAppr.Remarks as apprRemarks
FROM 
    [IT].[ServiceRequestHistory] AS ssh 
LEFT JOIN 
    [HR].[Employee] AS emp ON emp.EmployeeNo  =cast( ssh.CreatedBy as nvarchar(200))
LEFT JOIN 
    [HR].[Employee] AS modifyemp ON modifyemp.EmployeeNo  =cast( ssh.ModifiedBy as nvarchar(200))
LEFT JOIN 
    [IT].Support AS sup ON sup.SupportID  = ssh.SupportID
 LEFT JOIN  [IT].SRSoftware AS sr ON sr.SRID  =ssh.SRID
 
 LEFT JOIN  [IT].SRResolutionHistory AS srRes ON srRes.SRID=ssh.SRID And srRes.status=ssh.Status
 LEFT JOIN  [IT].SRApprover AS srAppr ON srAppr.SRID=ssh.SRID And srAppr.status=ssh.Status 
GO


