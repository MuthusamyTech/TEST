USE [MicroLabs_Dev]
GO
/****** Object:  Trigger [IT].[TR_SRSoftwareHistory]    Script Date: 2024-10-21 2:36:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [IT].[TR_SRSoftwareHistory]
ON  [IT].[SRSoftware]
   AFTER INSERT,DELETE,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 

	INSERT INTO [IT].[SRSoftwareHistory]
           ([SRID]
      ,[SupportID]
      ,[SoftwareType]
      ,[SoftwareName]
      ,[SoftwareVersionName]
      ,[VendorName]
      ,[InstType]
      ,[LicenceType]
      ,[Location]
      ,[Department]
      ,[NoOfUers]
      ,[NoOfLicence]
      ,[CostPerLicence]
      ,[TotalCost]
      ,[AMCAppilcable]
      ,[CostForAMC]
      ,[ScopeOfAMC]
      ,[IsInstReq]
      ,[InstCharge]
      ,[DtlsOfInst]
      ,[DtlsOfinstDt]
      ,[TypeOfDev]
      ,[DtlsOfDev]
      ,[IsInterfaceReq]
      ,[InterfaceReq]
      ,[InterfaceWith]
      ,[IsGxpApp]
      ,[NonFunReq]
      ,[DtlsOfReq]
      ,[WhereHosted]
      ,[TypeOfWeb]
      ,[UsageBY]
      ,[UserAccessFrom]
      ,[CurrVersion]
      ,[TareVersion]
      ,[Brds]
      ,[BusJustification]
      ,[Justification]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDt]
      ,[ModifiedBy]
      ,[ModifiedDt])
     Select
		SR.SRID
      ,SR.SupportID
      ,SR.SoftwareType
      ,SR.SoftwareName
      ,SR.SoftwareVersionName
      ,SR.VendorName
      ,SR.InstType
      ,SR.LicenceType
      ,SR.Location
      ,SR.Department
      ,SR.NoOfUers
      ,SR.NoOfLicence
      ,SR.CostPerLicence
      ,SR.TotalCost
      ,SR.AMCAppilcable
      ,SR.CostForAMC
      ,SR.ScopeOfAMC
      ,SR.IsInstReq
      ,SR.InstCharge
      ,SR.DtlsOfInst
      ,SR.DtlsOfinstDt
      ,SR.TypeOfDev
      ,SR.DtlsOfDev
      ,SR.IsInterfaceReq
      ,SR.InterfaceReq
      ,SR.InterfaceWith
      ,SR.IsGxpApp
      ,SR.NonFunReq
      ,SR.DtlsOfReq
      ,SR.WhereHosted
      ,SR.TypeOfWeb
      ,SR.UsageBY
      ,SR.UserAccessFrom
      ,SR.CurrVersion
      ,SR.TareVersion
      ,SR.Brds
      ,SR.BusJustification
      ,SR.Justification
      ,SR.IsActive
      ,SR.CreatedBy
      ,SR.CreatedDt
      ,SR.ModifiedBy
      ,SR.ModifiedDt 
	  from [IT].[SRSoftware] SR where SR.ModifiedDt=(select max(sr1.ModifiedDt) from [IT].[SRSoftware] sr1)
	  print('Save Succesfully')
END
--CR where CR.ModifiedDt=(select MAX(cr1.ModifiedDt) from [IT].[ChangeRequest] cr1)
