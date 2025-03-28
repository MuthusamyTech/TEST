USE [MicroLabs_Dev]
GO
/****** Object:  Schema [IT]    Script Date: 2024-11-29 10:06:32 PM ******/
CREATE SCHEMA [IT]
GO
/****** Object:  Table [IT].[ITAssetDetails]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ITAssetDetails](
	[ITAssetID] [int] IDENTITY(1,1) NOT NULL,
	[SupportID] [int] NULL,
	[AssetCode] [nvarchar](100) NULL,
	[Requesttype] [nvarchar](200) NULL,
	[RequestedBY] [int] NULL,
	[RequestedFor] [int] NULL,
	[SelectedFor] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Guest_Id] [int] NULL,
	[Guest_Name] [nvarchar](500) NULL,
	[Guest_Email] [nvarchar](500) NULL,
	[Guest_RManagerId] [int] NULL,
	[Guest_ContactNo] [int] NULL,
	[Assettype] [nvarchar](500) NULL,
	[Emp_Id] [int] NULL,
	[GxpReq] [nvarchar](200) NULL,
	[ExistingAsset] [nvarchar](200) NULL,
	[AssetModel] [nvarchar](500) NULL,
	[AssetSerialNo] [nvarchar](300) NULL,
	[AssetsWarranty_EndDt] [datetime] NULL,
	[SuggModel] [nvarchar](200) NULL,
	[Specs_Requirements] [nvarchar](200) NULL,
	[ApproximateINR] [int] NULL,
	[Justification] [nvarchar](200) NULL,
	[HOD_Approval] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[Status] [nvarchar](50) NULL,
	[AssignedTo] [int] NULL,
	[AssignedBy] [int] NULL,
	[ApproverLevel] [int] NULL,
	[Stage] [nvarchar](150) NULL,
	[HOD_ApproverID] [int] NULL,
	[HOD_ApprovedDt] [datetime] NULL,
	[HOD_ApproverRemarks] [nvarchar](max) NULL,
	[RPM_ApproverID] [int] NULL,
	[RPM_ApprovedDt] [datetime] NULL,
	[RPM_ApproverRemarks] [nvarchar](max) NULL,
	[ResolRemarks] [nvarchar](max) NULL,
	[UserRemarks] [nvarchar](200) NULL,
	[ProposedResolDt] [datetime] NULL,
	[ResolDt] [datetime] NULL,
	[Description] [nvarchar](200) NULL,
	[OnHoldReason] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_ReqAssets] PRIMARY KEY CLUSTERED 
(
	[ITAssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[Support]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[Support](
	[SupportID] [int] IDENTITY(1,1) NOT NULL,
	[SupportName] [varchar](500) NOT NULL,
	[ParentID] [int] NULL,
	[IsActive] [bit] NULL,
	[IsVisible] [bit] NULL,
	[IsRPMReq] [bit] NULL,
	[IsHODReq] [bit] NULL,
	[Image] [varchar](max) NULL,
	[URL] [varchar](200) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Support] PRIMARY KEY CLUSTERED 
(
	[SupportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[IssueOnholdCat]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[IssueOnholdCat](
	[IssueOnholdCatID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CategoryID] [int] NULL,
	[CategoryTypeID] [int] NULL,
	[OnholdReason] [nvarchar](1500) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[supportId] [int] NULL,
 CONSTRAINT [PK_IT.[IssueOnholdCat] PRIMARY KEY CLUSTERED 
(
	[IssueOnholdCatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_ITAssetsDetails]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [IT].[vw_ITAssetsDetails] AS
	SELECT 
	   asset.AssetCode
	  ,asset.ITAssetID
      ,asset.Requesttype
      ,asset.RequestedBY
	  ,isNull(requestby.FirstName, '')+ ' ' + isNull(requestby.MiddleName, '') + ' ' + isNull(requestby.LastName, '') AS RequestedByName
      ,asset.RequestedFor
	  ,isNull(requestfor.FirstName, '')+ ' ' + isNull(requestfor.MiddleName, '') + ' ' + isNull(requestfor.LastName, '') AS  RequestedForName
      ,asset.SelectedFor
      ,asset.EmpType
      ,asset.Guest_Id
      ,asset.Guest_Name
      ,asset.Guest_Email
      ,asset.Guest_RManagerId
	  ,isNull(grpmId.FirstName, '')+ ' ' + isNull(grpmId.MiddleName, '') + ' ' + isNull(grpmId.LastName, '') AS  Guest_RManagerName
      ,asset.Guest_ContactNo
      ,asset.Assettype
      ,asset.Emp_Id
      ,asset.GxpReq
      ,asset.ExistingAsset
      ,asset.AssetModel
      ,asset.AssetSerialNo
      ,asset.AssetsWarranty_EndDt
      ,asset.SuggModel
      ,asset.Specs_Requirements
      ,asset.ApproximateINR
      ,asset.Justification
      ,asset.HOD_Approval
	  ,asset.Status
	  ,asset.AssignedTo
	  ,isNull(assinTo.FirstName, '') + ' ' + isNull(assinTo.MiddleName, '')+ ' ' + isNull(assinTo.LastName, '') AS AssignedToName
	  ,asset.AssignedBy
	  ,isNull(assigBy.FirstName, '') + ' ' + isNull(assigBy.MiddleName, '')+ ' ' + isNull(assigBy.LastName, '') AS AssignedByName
      ,asset.IsActive
	  ,asset.HOD_ApproverID
	  ,asset.HOD_ApproverRemarks
	  ,asset.HOD_ApprovedDt
	  ,asset.RPM_ApproverID
	  ,asset.RPM_ApprovedDt
	  ,asset.RPM_ApproverRemarks
	  ,asset.ResolRemarks
	  ,asset.UserRemarks
	  ,asset.ProposedResolDt
	  ,asset.ResolDt
	  ,asset.Description
	,isNull(CreatedBy.FirstName, '') + ' ' + isNull(CreatedBy.MiddleName, '')+ ' ' + isNull(CreatedBy.LastName, '') AS CreatedBy,
	asset.CreatedDt,
	isNull(modifyby.FirstName, '') + ' ' + isNull(modifyby.MiddleName, '')+ ' ' + isNull(modifyby.LastName, '') AS ModifiedBy,
	asset.ModifiedDt,
	supportData.SupportName,
	supportData.IsHODReq,
	supportData.IsRPMReq,
	asset.SupportID,
	hodEmp.EmployeeNo,
    rpm.Employee_ID as rpmEmpNO,
	hod.Employee_ID as hodEmpNo,
	--OnHoldReason
	onhold.OnholdReason,

	isNull(hodEmp.FirstName, '') + ' ' + isNull(hodEmp.LastName, '') + ' ' + '(' + cast(hodEmp.EmployeeNo as nvarchar) + ')' AS hodToName,
	hodEmp.OfficialEmailId As hodEmail,
	isNull(rpmEmp.FirstName, '') + ' ' + isNull(rpmEmp.LastName, '') + ' ' + '(' + cast(rpmEmp.EmployeeNo as nvarchar) + ')' AS rpmToName,
    rpmEmp.OfficialEmailId As rpmEmail
	from IT.ITAssetDetails AS asset
	LEFT JOIN HR.Employee CreatedBy ON CreatedBy.EmployeeNo = cast(asset.CreatedBy as nvarchar(100))
	LEFT JOIN HR.Employee modifyby ON modifyby.EmployeeNo = cast(asset.ModifiedBy as nvarchar(100))
	LEFT JOIN HR.Employee requestby ON requestby.EmployeeNo = cast(asset.RequestedBY as nvarchar(100))
	LEFT JOIN HR.Employee requestfor ON requestfor.EmployeeNo = cast(asset.RequestedFor as nvarchar(100))
	left join Employee_Master rpm on rpm.ID = requestfor.ReportingManagerId
	left join Employee_Master hod on hod.ID = requestfor.ApprovingManagerId
	LEFT JOIN HR.Employee assinTo ON assinTo.EmployeeNo = cast(asset.AssignedTo as nvarchar(100))
	LEFT JOIN HR.Employee assigBy ON assigBy.EmployeeNo = cast(asset.AssignedBy as nvarchar(100))
	LEFT JOIN it.Support supportData ON supportData.SupportID = asset.SupportID
	left join hr.Employee hodEmp on hodEmp.EmployeeNo = cast(hod.Employee_ID as nvarchar(100))
	left join hr.Employee rpmEmp on rpmEmp.EmployeeNo = cast(rpm.Employee_ID as nvarchar(100))
	--OnHoldReason
	LEFT JOIN [IT].[IssueOnholdCat] AS onhold ON onhold.IssueOnholdCatID = asset.OnHoldReason
	--
	LEFT JOIN HR.Employee grpmId ON grpmId.EmployeeNo = cast(asset.Guest_RManagerId as nvarchar(100))

GO
/****** Object:  Table [IT].[SysLandscape]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SysLandscape](
	[SysLandscapeID] [int] IDENTITY(1,1) NOT NULL,
	[SupportID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ClassificationID] [int] NOT NULL,
	[SysLandscape] [nvarchar](50) NULL,
	[PriorityNum] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.SysLandscape] PRIMARY KEY CLUSTERED 
(
	[SysLandscapeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[CRExecutionPlan]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[CRExecutionPlan](
	[ITCRExecID] [int] IDENTITY(1,1) NOT NULL,
	[ITCRID] [int] NOT NULL,
	[SysLandscape] [int] NOT NULL,
	[ExecutionStepName] [nvarchar](500) NULL,
	[ExecutionStepDesc] [nvarchar](2000) NULL,
	[AssignedTo] [int] NULL,
	[StartDt] [datetime] NULL,
	[EndDT] [datetime] NULL,
	[Attachments] [nvarchar](500) NULL,
	[Status] [nvarchar](50) NULL,
	[ForwardStatus] [nvarchar](50) NULL,
	[ForwardedTo] [int] NULL,
	[ForwardedDt] [datetime] NULL,
	[ReasonForwarded] [nvarchar](500) NULL,
	[Remarks] [nvarchar](2000) NULL,
	[PickedStatus] [nvarchar](50) NULL,
	[PickedDt] [datetime] NULL,
	[ActualStartDt] [datetime] NULL,
	[ActualEndDt] [datetime] NULL,
	[DependSysLandscape] [int] NULL,
	[DependTaskID] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.CRExecutionPlan] PRIMARY KEY CLUSTERED 
(
	[ITCRExecID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[CRTemplateDtls]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[CRTemplateDtls](
	[CRTemplateDtlsID] [int] IDENTITY(1,1) NOT NULL,
	[CRTemplateID] [int] NOT NULL,
	[SysLandscapeID] [int] NULL,
	[CategoryID] [int] NULL,
	[CategoryTypID] [int] NULL,
	[TaskName] [nvarchar](500) NULL,
	[TaskDesc] [nvarchar](2000) NULL,
	[Priority] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.CRTemplateDtls] PRIMARY KEY CLUSTERED 
(
	[CRTemplateDtlsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[ChangeRequest]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ChangeRequest](
	[ITCRID] [int] IDENTITY(1,1) NOT NULL,
	[CRCode] [varchar](50) NOT NULL,
	[SupportID] [int] NOT NULL,
	[ClassifcationID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[CROwner] [int] NOT NULL,
	[CRDate] [datetime] NOT NULL,
	[CRRequestedBy] [int] NULL,
	[CRRequestedDt] [datetime] NULL,
	[CRREmailNotification] [bit] NULL,
	[CRInitiatedFor] [int] NULL,
	[Stage] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[ReferenceID] [int] NULL,
	[ReferenceTyp] [int] NULL,
	[CategoryTypeID] [int] NULL,
	[NatureOfChange] [int] NULL,
	[PriorityType] [int] NULL,
	[PlantID] [int] NULL,
	[SysLandscapeID] [nvarchar](500) NULL,
	[GXPClassification] [bit] NULL,
	[GXPPlantID] [int] NULL,
	[ChangeControlNo] [nvarchar](50) NULL,
	[ChangeControlDt] [date] NULL,
	[ChangeControlAttach] [bit] NULL,
	[ChangeDesc] [varchar](2000) NULL,
	[ReasonForChange] [varchar](2000) NULL,
	[AlternateConsidetation] [varchar](2000) NULL,
	[ImpactNotDoing] [varchar](2000) NULL,
	[BusinessImpact] [varchar](2000) NULL,
	[TriggeredBy] [varchar](2000) NULL,
	[Benefits] [varchar](2000) NULL,
	[EstimatedCost] [numeric](18, 0) NULL,
	[EstimatedCostCurr] [char](3) NULL,
	[EstimatedEffort] [int] NULL,
	[EstimatedEffortUnit] [nvarchar](50) NULL,
	[EstimatedDateCompletion] [date] NULL,
	[RollbackPlan] [varchar](2000) NULL,
	[BackoutPlan] [varchar](2000) NULL,
	[DownTimeRequired] [bit] NULL,
	[DownTimeFromDate] [datetime] NULL,
	[DownTimeToDate] [datetime] NULL,
	[ImpactedLocation] [nvarchar](50) NULL,
	[ImpactedDept] [nvarchar](50) NULL,
	[ImactedFunc] [nvarchar](50) NULL,
	[ApprovedBy] [int] NULL,
	[ApprovedDt] [datetime] NULL,
	[isSubmitted] [bit] NULL,
	[isApproved] [bit] NULL,
	[isImplemented] [bit] NULL,
	[isReleased] [bit] NULL,
	[ClosedStatus] [nvarchar](150) NULL,
	[ClosureRemarks] [nvarchar](max) NULL,
	[ClosedBy] [int] NULL,
	[ClosedDt] [datetime] NULL,
	[Feedback] [nvarchar](max) NULL,
	[Remarks] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
	[Attachment] [nvarchar](200) NULL,
 CONSTRAINT [PK_ChangeRequest] PRIMARY KEY CLUSTERED 
(
	[ITCRID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[CRTemplate]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[CRTemplate](
	[CRTemplateID] [int] IDENTITY(1,1) NOT NULL,
	[SupportID] [int] NULL,
	[CategoryID] [int] NULL,
	[CategoryTypID] [int] NULL,
	[TemplateName] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.CRTemplate] PRIMARY KEY CLUSTERED 
(
	[CRTemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_CRTemplate]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE View [IT].[vw_CRTemplate] as
Select distinct tskdtl.*,tmp.TemplateName from IT.CRTemplateDtls tskdtl
inner join IT.CRTemplate tmp on tmp.CRTemplateID=tskdtl.CRTemplateID
inner join IT.ChangeRequest cr on cr.CategoryID=tmp.CategoryID --and cr.CategoryTypeID=tmp.CategoryTypID
inner join IT.CRExecutionPlan exc on exc.ITCRID=cr.ITCRID 
inner join IT.SysLandscape sl on sl.SysLandscapeID=exc.SysLandscape and sl.CategoryID=cr.CategoryID and sl.ClassificationID=cr.ClassifcationID

GO
/****** Object:  Table [IT].[ITAssetHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ITAssetHistory](
	[ITAHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[ITAssetID] [int] NULL,
	[SupportID] [int] NULL,
	[AssetCode] [nvarchar](100) NULL,
	[Requesttype] [nvarchar](200) NULL,
	[RequestedBY] [int] NULL,
	[RequestedFor] [int] NULL,
	[SelectedFor] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Guest_Id] [int] NULL,
	[Guest_Name] [nvarchar](500) NULL,
	[Guest_Email] [nvarchar](500) NULL,
	[Guest_RManagerId] [int] NULL,
	[Guest_ContactNo] [int] NULL,
	[Assettype] [nvarchar](500) NULL,
	[Emp_Id] [int] NULL,
	[GxpReq] [nvarchar](200) NULL,
	[ExistingAsset] [nvarchar](200) NULL,
	[AssetModel] [nvarchar](500) NULL,
	[AssetSerialNo] [nvarchar](300) NULL,
	[AssetsWarranty_EndDt] [datetime] NULL,
	[SuggModel] [nvarchar](200) NULL,
	[Specs_Requirements] [nvarchar](200) NULL,
	[ApproximateINR] [int] NULL,
	[Justification] [nvarchar](200) NULL,
	[HOD_Approval] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[Status] [nvarchar](50) NULL,
	[AssignedTo] [int] NULL,
	[AssignedBy] [int] NULL,
	[ApproverLevel] [int] NULL,
	[Stage] [nvarchar](150) NULL,
	[HOD_ApproverID] [int] NULL,
	[HOD_ApprovedDt] [datetime] NULL,
	[HOD_ApproverRemarks] [nvarchar](max) NULL,
	[RPM_ApproverID] [int] NULL,
	[RPM_ApprovedDt] [datetime] NULL,
	[RPM_ApproverRemarks] [nvarchar](max) NULL,
	[ResolRemarks] [nvarchar](max) NULL,
	[UserRemarks] [nvarchar](200) NULL,
	[ProposedResolDt] [datetime] NULL,
	[ResolDt] [datetime] NULL,
	[Description] [nvarchar](200) NULL,
	[OnHoldReason] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_ITAssetsHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













CREATE   VIEW [IT].[vw_ITAssetsHistory] AS
	SELECT 
	   asset.AssetCode
	  ,asset.ITAssetID
	  ,asset.SupportID
      ,asset.Requesttype
      ,asset.RequestedBY
	  ,isNull(requestby.FirstName, '')+ ' ' + isNull(requestby.MiddleName, '') + ' ' + isNull(requestby.LastName, '') AS RequestedByName
      ,asset.RequestedFor
	  ,isNull(requestfor.FirstName, '')+ ' ' + isNull(requestfor.MiddleName, '') + ' ' + isNull(requestfor.LastName, '') AS  RequestedForName
      ,asset.SelectedFor
      ,asset.EmpType
      ,asset.Guest_Id
      ,asset.Guest_Name
      ,asset.Guest_Email
      ,asset.Guest_RManagerId
	  ,isNull(grpmId.FirstName, '')+ ' ' + isNull(grpmId.MiddleName, '') + ' ' + isNull(grpmId.LastName, '') AS  Guest_RManagerName
      ,asset.Guest_ContactNo
      ,asset.Assettype
      ,asset.Emp_Id
      ,asset.GxpReq
      ,asset.ExistingAsset
      ,asset.AssetModel
      ,asset.AssetSerialNo
      ,asset.AssetsWarranty_EndDt
      ,asset.SuggModel
      ,asset.Specs_Requirements
      ,asset.ApproximateINR
      ,asset.Justification
      ,asset.HOD_Approval
	  ,asset.Status
	  ,asset.AssignedTo
	  ,isNull(assinTo.FirstName, '') + ' ' + isNull(assinTo.MiddleName, '')+ ' ' + isNull(assinTo.LastName, '') AS AssignedToName
	  ,asset.AssignedBy
	  ,isNull(assigBy.FirstName, '') + ' ' + isNull(assigBy.MiddleName, '')+ ' ' + isNull(assigBy.LastName, '') AS AssignedByName
      ,asset.IsActive
	  ,asset.HOD_ApproverID
	  ,asset.HOD_ApproverRemarks
	  ,asset.HOD_ApprovedDt
	  ,asset.RPM_ApproverID
	  ,asset.RPM_ApprovedDt
	  ,asset.RPM_ApproverRemarks
	  ,asset.ResolRemarks
	  ,asset.UserRemarks
	  ,asset.ProposedResolDt
	  ,asset.ResolDt
	  ,asset.Description
	  ,asset.OnHoldReason
	,isNull(CreatedBy.FirstName, '') + ' ' + isNull(CreatedBy.MiddleName, '')+ ' ' + isNull(CreatedBy.LastName, '') AS CreatedBy,
	asset.CreatedDt,
	isNull(modifyby.FirstName, '') + ' ' + isNull(modifyby.MiddleName, '')+ ' ' + isNull(modifyby.LastName, '') AS ModifiedBy,
	asset.ModifiedDt
	from IT.ITAssetHistory AS asset
	LEFT JOIN HR.Employee CreatedBy ON CreatedBy.EmployeeNo = cast(asset.CreatedBy as nvarchar(100))
	LEFT JOIN HR.Employee modifyby ON modifyby.EmployeeNo = cast(asset.ModifiedBy as nvarchar(100))
	LEFT JOIN HR.Employee requestby ON requestby.EmployeeNo = cast(asset.RequestedBY as nvarchar(100))
	LEFT JOIN HR.Employee requestfor ON requestfor.EmployeeNo = cast(asset.RequestedFor as nvarchar(100))
	LEFT JOIN HR.Employee assinTo ON assinTo.EmployeeNo = cast(asset.AssignedTo as nvarchar(100))
	LEFT JOIN HR.Employee assigBy ON assigBy.EmployeeNo = cast(asset.AssignedBy as nvarchar(100))
	--GuestRManager
	LEFT JOIN HR.Employee grpmId ON grpmId.EmployeeNo = cast(asset.Guest_RManagerId as nvarchar(100))
GO
/****** Object:  Table [IT].[SupportTeam]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SupportTeam](
	[SupportTeamID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[First_Name] [nvarchar](1000) NULL,
	[Middle_Name] [nvarchar](100) NULL,
	[Last_Name] [nvarchar](100) NULL,
	[Img_Url] [nvarchar](200) NULL,
	[Designation] [nvarchar](100) NULL,
	[Role] [nvarchar](100) NULL,
	[EmpID] [int] NULL,
	[IsActive] [bit] NULL,
	[DOL] [datetime] NULL,
	[DOB] [date] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_SupportTeam] PRIMARY KEY CLUSTERED 
(
	[SupportTeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_ExecPlan]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE View [IT].[vw_ExecPlan] as
select ExecutePlan.ITCRExecID,ExecutePlan.ITCRID,ExecutePlan.SysLandscape as SysLandscapeid,syslan.SysLandscape as sylandscape,ExecutePlan.ExecutionStepName,ExecutePlan.ExecutionStepDesc,
ExecutePlan.AssignedTo as assignedtoid,ExecutePlan.ForwardedTo as forwardedtoid,
isNull(assgnto.First_Name,'') +' '+isNull(assgnto.Middle_Name,'') +'  '+ isNull(assgnto.Last_Name,'') as AssignedTo,
isNull(fwdto.First_Name,'') +' '+isNull(fwdto.Middle_Name,'')+' '+ isNull(fwdto.Last_Name,'') as ForwardedTo,
ExecutePlan.StartDt,ExecutePlan.EndDT,ExecutePlan.Attachments,ExecutePlan.Status,ExecutePlan.ForwardedDt,ExecutePlan.ReasonForwarded,ExecutePlan.Remarks,
ExecutePlan.PickedStatus,ExecutePlan.PickedDt,ExecutePlan.ActualStartDt,ExecutePlan.ActualEndDt,deptland.SysLandscape as DependSyelanscape,ExecutePlan.DependSysLandscape as DependSysLandscapeid,ExecutePlan.DependTaskID, 
deptask.ExecutionStepName as depndtask,ExecutePlan.CreatedBy,ExecutePlan.CreatedDt,ExecutePlan.ModifiedBy,ExecutePlan.ModifiedDt
			from IT.CRExecutionPlan as ExecutePlan
			left join IT.SupportTeam assgnto on assgnto.EmpID=ExecutePlan.AssignedTo
			left join IT.SupportTeam fwdto on fwdto.EmpID=ExecutePlan.ForwardedTo
			left join it.SysLandscape syslan on syslan.SysLandscapeID = ExecutePlan.SysLandscape
			left join it.SysLandscape deptland on deptland.SysLandscapeID = ExecutePlan.DependSysLandscape
			left outer join it.CRExecutionPlan deptask on deptask.ITCRExecID = ExecutePlan.DependTaskID

GO
/****** Object:  Table [IT].[CategoryTyp]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[CategoryTyp](
	[CategoryTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CategoryID] [int] NULL,
	[CategoryType] [nvarchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_IT.CategoryTyp] PRIMARY KEY CLUSTERED 
(
	[CategoryTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[Category]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[Category](
	[ITCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[SupportID] [int] NULL,
	[CategoryName] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.Category] PRIMARY KEY CLUSTERED 
(
	[ITCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[Classification]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[Classification](
	[ITClassificationID] [int] IDENTITY(1,1) NOT NULL,
	[ClassificationName] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_ITClassification] PRIMARY KEY CLUSTERED 
(
	[ITClassificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[Approver]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[Approver](
	[ITApproverID] [int] IDENTITY(1,1) NOT NULL,
	[PlantID] [int] NOT NULL,
	[SupportID] [int] NOT NULL,
	[CategoryID] [int] NULL,
	[ClassificationID] [int] NULL,
	[CategoryTypID] [int] NULL,
	[Approverstage] [nvarchar](50) NULL,
	[Approver1] [int] NULL,
	[Approver2] [int] NULL,
	[Approver3] [int] NULL,
	[Level] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.Approver] PRIMARY KEY CLUSTERED 
(
	[ITApproverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[CRApprover]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[CRApprover](
	[ITCRApproverID] [int] IDENTITY(1,1) NOT NULL,
	[PlantID] [int] NOT NULL,
	[SupportID] [int] NOT NULL,
	[CRID] [int] NOT NULL,
	[ApproverLevel] [int] NULL,
	[Stage] [varchar](150) NULL,
	[ApproverID] [int] NULL,
	[ApprovedDt] [datetime] NOT NULL,
	[Remarks] [varchar](2000) NULL,
	[Comments] [varchar](2000) NULL,
	[Status] [varchar](150) NOT NULL,
	[Attachment] [varchar](2000) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_ITCRApproverID] PRIMARY KEY CLUSTERED 
(
	[ITCRApproverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_CREmail]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE View [IT].[vw_CREmail] as

select distinct CR.ITCRID, CR.CRCode,CR.SupportID, 
isNull(suppt.First_Name,'')+' '+isNull(suppt.Middle_Name,'')+' '+isNull(suppt.Last_Name,'') CROwner, suppt.Email CROEmail, suppt.Designation CRODesignation,suppt.Role CRORole,suppt.EmpID CROEmpid
,isNull(supptI.First_Name,'')+' '+isNull(supptI.Middle_Name,'')+' '+isNull(supptI.Last_Name,'') CRInitiator, supptI.Email CRIEmail, supptI.Designation CRIDesignation,supptI.Role CRIRole, supptI.EmpID CRIEmpid
,isNull(supptR.First_Name,'')+' '+isNull(supptR.Middle_Name,'')+' '+isNull(supptR.Last_Name,'') CRRequestedBy, supptR.Email CRREmail, supptR.Designation CRRDesignation,supptR.Role CRRRole, supptR.EmpID CRREmpid
--Approver Level 1
,isNull(supptA11N.First_Name,'')+' '+isNull(supptA11N.Middle_Name,'')+' '+isNull(supptA11N.Last_Name,'') CRApprover11N, supptA11N.Email CRApprover11NEmail , supptA11N.Designation CRApprover11NDesg,supptA11N.Role CRApprover11NRole,supptA11N.EmpID CRApprover11NEmpID
,isNull(supptA11R.First_Name,'')+' '+isNull(supptA11R.Middle_Name,'')+' '+isNull(supptA11R.Last_Name,'') CRApprover11R, supptA11R.Email CRApprover11REmail , supptA11R.Designation CRApprover11RDesg,supptA11R.Role CRApprover11RRole,supptA11R.EmpID CRApprover11REmpID
,isNull(supptA11C.First_Name,'')+' '+isNull(supptA11C.Middle_Name,'')+' '+isNull(supptA11C.Last_Name,'') CRApprover11C, supptA11C.Email CRApprover11CEmail , supptA11C.Designation CRApprover11CDesg,supptA11C.Role CRApprover11CRole,supptA11C.EmpID CRApprover11CEmpID
,isNull(supptA12N.First_Name,'')+' '+isNull(supptA12N.Middle_Name,'')+' '+isNull(supptA12N.Last_Name,'') CRApprover12N, supptA12N.Email CRApprover12NEmail , supptA12N.Designation CRApprover12NDesg,supptA12N.Role CRApprover12NRole,supptA12N.EmpID CRApprover12NEmpID
,isNull(supptA12R.First_Name,'')+' '+isNull(supptA12R.Middle_Name,'')+' '+isNull(supptA12R.Last_Name,'') CRApprover12R, supptA12R.Email CRApprover12REmail , supptA12R.Designation CRApprover12RDesg,supptA12R.Role CRApprover12RRole,supptA12R.EmpID CRApprover12REmpID
,isNull(supptA12C.First_Name,'')+' '+isNull(supptA12C.Middle_Name,'')+' '+isNull(supptA12C.Last_Name,'') CRApprover12C, supptA12C.Email CRApprover12CEmail , supptA12C.Designation CRApprover12CDesg,supptA12C.Role CRApprover12CRole,supptA12C.EmpID CRApprover12CEmpID
,isNull(supptA13N.First_Name,'')+' '+isNull(supptA13N.Middle_Name,'')+' '+isNull(supptA13N.Last_Name,'') CRApprover13N, supptA13N.Email CRApprover13NEmail , supptA13N.Designation CRApprover13NDesg,supptA13N.Role CRApprover13NRole,supptA13N.EmpID CRApprover13NEmpID
,isNull(supptA13R.First_Name,'')+' '+isNull(supptA13R.Middle_Name,'')+' '+isNull(supptA13R.Last_Name,'') CRApprover13R, supptA13R.Email CRApprover13REmail , supptA13R.Designation CRApprover13RDesg,supptA13R.Role CRApprover13RRole,supptA13R.EmpID CRApprover13REmpID
,isNull(supptA13C.First_Name,'')+' '+isNull(supptA13C.Middle_Name,'')+' '+isNull(supptA13C.Last_Name,'') CRApprover13C, supptA13C.Email CRApprover13CEmail , supptA13C.Designation CRApprover13CDesg,supptA13C.Role CRApprover13CRole,supptA13C.EmpID CRApprover13CEmpID
--Approver Level 2
,isNull(supptA22N.First_Name,'')+' '+isNull(supptA22N.Middle_Name,'')+' '+isNull(supptA21N.Last_Name,'') CRApprover21N, supptA21N.Email CRApprover21NEmail , supptA21N.Designation CRApprover21NDesg,supptA21N.Role CRApprover21NRole,supptA21N.EmpID CRApprover21NEmpID
,isNull(supptA21R.First_Name,'')+' '+isNull(supptA21R.Middle_Name,'')+' '+isNull(supptA21R.Last_Name,'') CRApprover21R, supptA21R.Email CRApprover21REmail , supptA21R.Designation CRApprover21RDesg,supptA21R.Role CRApprover21RRole,supptA21R.EmpID CRApprover21REmpID
,isNull(supptA21C.First_Name,'')+' '+isNull(supptA21C.Middle_Name,'')+' '+isNull(supptA21C.Last_Name,'') CRApprover21C, supptA21C.Email CRApprover21CEmail , supptA21C.Designation CRApprover21CDesg,supptA21C.Role CRApprover21CRole,supptA21C.EmpID CRApprover21CEmpID
,isNull(supptA22N.First_Name,'')+' '+isNull(supptA22N.Middle_Name,'')+' '+isNull(supptA22N.Last_Name,'') CRApprover22N, supptA22N.Email CRApprover22NEmail , supptA22N.Designation CRApprover22NDesg,supptA22N.Role CRApprover22NRole,supptA22N.EmpID CRApprover22NEmpID
,isNull(supptA22R.First_Name,'')+' '+isNull(supptA22R.Middle_Name,'')+' '+isNull(supptA22R.Last_Name,'') CRApprover22R, supptA22R.Email CRApprover22REmail , supptA22R.Designation CRApprover22RDesg,supptA22R.Role CRApprover22RRole,supptA22R.EmpID CRApprover22REmpID
,isNull(supptA22C.First_Name,'')+' '+isNull(supptA22C.Middle_Name,'')+' '+isNull(supptA22C.Last_Name,'') CRApprover22C, supptA22C.Email CRApprover22CEmail , supptA22C.Designation CRApprover22CDesg,supptA22C.Role CRApprover22CRole,supptA22C.EmpID CRApprover22CEmpID
,isNull(supptA23N.First_Name,'')+' '+isNull(supptA23N.Middle_Name,'')+' '+isNull(supptA23N.Last_Name,'') CRApprover23N, supptA23N.Email CRApprover23NEmail , supptA23N.Designation CRApprover23NDesg,supptA23N.Role CRApprover23NRole,supptA23N.EmpID CRApprover23NEmpID
,isNull(supptA23R.First_Name,'')+' '+isNull(supptA23R.Middle_Name,'')+' '+isNull(supptA23R.Last_Name,'') CRApprover23R, supptA23R.Email CRApprover23REmail , supptA23R.Designation CRApprover23RDesg,supptA23R.Role CRApprover23RRole,supptA23R.EmpID CRApprover23REmpID
,isNull(supptA23C.First_Name,'')+' '+isNull(supptA23C.Middle_Name,'')+' '+isNull(supptA23C.Last_Name,'') CRApprover23C, supptA23C.Email CRApprover23CEmail , supptA23C.Designation CRApprover23CDesg,supptA23C.Role CRApprover23CRole,supptA23C.EmpID CRApprover23CEmpID
--Approver Level 3
,isNull(supptA31N.First_Name,'')+' '+isNull(supptA31N.Middle_Name,'')+' '+isNull(supptA31N.Last_Name,'') CRApprover31N, supptA31N.Email CRApprover31NEmail , supptA31N.Designation CRApprover31NDesg,supptA31N.Role CRApprover31NRole,supptA31N.EmpID CRApprover31NEmpID
,isNull(supptA31R.First_Name,'')+' '+isNull(supptA31R.Middle_Name,'')+' '+isNull(supptA31R.Last_Name,'') CRApprover31R, supptA31R.Email CRApprover31REmail , supptA31R.Designation CRApprover31RDesg,supptA31R.Role CRApprover31RRole,supptA31R.EmpID CRApprover31REmpID
,isNull(supptA31C.First_Name,'')+' '+isNull(supptA31C.Middle_Name,'')+' '+isNull(supptA31C.Last_Name,'') CRApprover31C, supptA31C.Email CRApprover31CEmail , supptA31C.Designation CRApprover31CDesg,supptA31C.Role CRApprover31CRole,supptA31C.EmpID CRApprover31CEmpID
,isNull(supptA32N.First_Name,'')+' '+isNull(supptA32N.Middle_Name,'')+' '+isNull(supptA32N.Last_Name,'') CRApprover32N, supptA32N.Email CRApprover32NEmail , supptA32N.Designation CRApprover32NDesg,supptA32N.Role CRApprover32NRole,supptA32N.EmpID CRApprover32NEmpID
,isNull(supptA32R.First_Name,'')+' '+isNull(supptA32R.Middle_Name,'')+' '+isNull(supptA32R.Last_Name,'') CRApprover32R, supptA32R.Email CRApprover32REmail , supptA32R.Designation CRApprover32RDesg,supptA32R.Role CRApprover32RRole,supptA32R.EmpID CRApprover32REmpID
,isNull(supptA32C.First_Name,'')+' '+isNull(supptA32C.Middle_Name,'')+' '+isNull(supptA32C.Last_Name,'') CRApprover32C, supptA32C.Email CRApprover32CEmail , supptA32C.Designation CRApprover32CDesg,supptA32C.Role CRApprover32CRole,supptA32C.EmpID CRApprover32CEmpID
,isNull(supptA33N.First_Name,'')+' '+isNull(supptA33N.Middle_Name,'')+' '+isNull(supptA33N.Last_Name,'') CRApprover33N, supptA33N.Email CRApprover33NEmail , supptA33N.Designation CRApprover33NDesg,supptA33N.Role CRApprover33NRole,supptA33N.EmpID CRApprover33NEmpID
,isNull(supptA33R.First_Name,'')+' '+isNull(supptA33R.Middle_Name,'')+' '+isNull(supptA33R.Last_Name,'') CRApprover33R, supptA33R.Email CRApprover33REmail , supptA33R.Designation CRApprover33RDesg,supptA33R.Role CRApprover33RRole,supptA33R.EmpID CRApprover33REmpID
,isNull(supptA33C.First_Name,'')+' '+isNull(supptA33C.Middle_Name,'')+' '+isNull(supptA33C.Last_Name,'') CRApprover33C, supptA33C.Email CRApprover33CEmail , supptA33C.Designation CRApprover33CDesg,supptA33C.Role CRApprover33CRole,supptA33C.EmpID CRApprover33CEmpID
,isNull(sappt.First_Name,'')+' '+isNull(sappt.Middle_Name,'')+' '+isNull(sappt.Last_Name,'') CRApproverBy, sappt.Email CRApproverByEmail,sappt.EmpID CRApproverByEmpID
,CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID, CR.PlantID as plantcode,
	Class.ClassificationName,CR.CRDate,CR.ModifiedDt,cr.isImplemented,cr.isSubmitted ,CR.isApproved, CR.isReleased,CR.Stage, CR.[Status] CRStatus , app.Remarks ApprovedByRemarks, app.ApprovedDt, app.Stage ApprovedByStage, app.status ApprovedByStatus
	
	/*CR.EstimatedCost, CR.EstimatedCostCurr, CR.EstimatedDateCompletion, CR.ApprovedBy
	,CR.PriorityType,cr.CROwner as ChangeRequestor,plant.Code PlantID,apprn.approver1,apprn.approver2,apprn.approver3, apprn.level,
	(select count(explan.ITCRExecID) from IT.CRExecutionPlan explan where explan.ITCRID=CR.ITCRID) taskcount*/
		from IT.ChangeRequest as CR
		inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
		inner join IT.Classification Class on Class.ITClassificationID=CR.ClassifcationID
		inner join IT.CategoryTyp catTyp on catTyp.CategoryID=CR.CategoryTypeID
		inner join Plant_Master plant on plant.Id = CR.PlantID
		LEFT Outer join [IT].[CRApprover] app on app.CRID=CR.ITCRID 
		LEFT Outer join [IT].SupportTeam sappt on sappt.EmpID=app.ApproverID 
		inner join IT.SupportTeam supptI on supptI.EmpID=CR.CRInitiatedFor
		inner join IT.SupportTeam supptR on supptR.EmpID=CR.CRRequestedBy
		-- Approver Level 1
		LEFT join IT.SupportTeam supptA11N on supptA11N.SupportTeamID=
		(select approver1 from  IT.Approver where level=1 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA11R on supptA11R.SupportTeamID=
		(select approver1 from  IT.Approver where level=1 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA11C on supptA11C.SupportTeamID=
		(select approver1 from  IT.Approver where level=1 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA12N on supptA12N.SupportTeamID=
		(select Approver2 from  IT.Approver where level=1 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA12R on supptA12R.SupportTeamID=
		(select Approver2 from  IT.Approver where level=1 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA12C on supptA12C.SupportTeamID=
		(select approver2 from  IT.Approver where level=1 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA13N on supptA13N.SupportTeamID=
		(select Approver3 from  IT.Approver where level=1 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA13R on supptA13R.SupportTeamID=
		(select Approver3 from  IT.Approver where level=1 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA13C on supptA13C.SupportTeamID=
		(select Approver3 from  IT.Approver where level=1 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		-- Approver Level 2
		LEFT join IT.SupportTeam supptA21N on supptA21N.SupportTeamID=
		(select approver1 from  IT.Approver where level=2 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA21R on supptA21R.SupportTeamID=
		(select approver1 from  IT.Approver where level=2 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA21C on supptA21C.SupportTeamID=
		(select approver1 from  IT.Approver where level=2 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA22N on supptA22N.SupportTeamID=
		(select Approver2 from  IT.Approver where level=2 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA22R on supptA22R.SupportTeamID=
		(select Approver2 from  IT.Approver where level=2 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA22C on supptA22C.SupportTeamID=
		(select approver2 from  IT.Approver where level=2 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA23N on supptA23N.SupportTeamID=
		(select Approver3 from  IT.Approver where level=2 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA23R on supptA13R.SupportTeamID=
		(select Approver3 from  IT.Approver where level=2 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA23C on supptA13C.SupportTeamID=
		(select Approver3 from  IT.Approver where level=2 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		
		-- Approver Level 3
		LEFT join IT.SupportTeam supptA31N on supptA31N.SupportTeamID=
		(select approver1 from  IT.Approver where level=3 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA31R on supptA31R.SupportTeamID=
		(select approver1 from  IT.Approver where level=3 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA31C on supptA31C.SupportTeamID=
		(select approver1 from  IT.Approver where level=3 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA32N on supptA32N.SupportTeamID=
		(select Approver2 from  IT.Approver where level=3 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA32R on supptA32R.SupportTeamID=
		(select Approver2 from  IT.Approver where level=3 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA32C on supptA32C.SupportTeamID=
		(select approver2 from  IT.Approver where level=3 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA33N on supptA33N.SupportTeamID=
		(select Approver3 from  IT.Approver where level=3 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA33R on supptA33R.SupportTeamID=
		(select Approver3 from  IT.Approver where level=3 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA33C on supptA33C.SupportTeamID=
		(select Approver3 from  IT.Approver where level=1 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		inner join IT.SupportTeam suppt on suppt.EmpID=CR.CROwner
		/*inner join IT.SupportTeamAssgn suppta on suppta.isapprover=1  
		and suppta.SupportID=CR.SupportID and suppta.SupportTeamID=suppt.SupportTeamID
		and suppta.ClassificationID=Class.ITClassificationID and suppta.ClassificationID=CR.ClassifcationID 
		and suppta.CategoryID=Cat.ITCategoryID and suppta.CategoryID=CR.CategoryID
		--and suppta.PlantID=CR.PlantID --and  suppta.PlantID=plant.Id
		inner join IT.SupportTeam supp on supp.SupportTeamID=suppta.SupportTeamID
		Left join IT.Approver appr1 on appr1.Approver1=supp.SupportTeamID and appr1.ClassificationID=CR.ClassifcationID and appr1.CategoryID=CR.CategoryID
		Left join IT.Approver appr2 on appr2.Approver2=supp.SupportTeamID and appr2.ClassificationID=CR.ClassifcationID and appr2.CategoryID=CR.CategoryID
		Left join IT.Approver appr3 on appr2.Approver3=supp.SupportTeamID and appr3.ClassificationID=CR.ClassifcationID and appr3.CategoryID=CR.CategoryID
		--left join IT.approver apprn on apprn.ClassificationID=CR.ClassifcationID and apprn.CategoryID=CR.CategoryID and apprn.PlantID=cr.PlantID
		left join IT.approver apprn on apprn.approverstage =(select (case 
		when (CR.Stage='Initated' and CR.[Status]='Pending Approval') Then 'N'
		when (CR.Stage='Approval' and CR.[Status]='Approved Level1') Then 'N'
		when (CR.Stage='Approval' and CR.[Status]='Approved Level2') Then 'N'
		when (CR.Stage='Approval' and CR.[Status]='Approved') Then 'N'
		when (CR.Stage='Release' and CR.[Status]='Approved Level1') Then 'R'
		when (CR.Stage='Release' and CR.[Status]='Approved Level2') Then 'R'
		when (CR.Stage='Release' and CR.[Status]='Approved') Then 'R'
		when (CR.Stage='Closure' and CR.[Status]='Approved Level1') Then 'C'
		when (CR.Stage='Closure' and CR.[Status]='Approved Level2') Then 'C'
		when (CR.Stage='Closure' and CR.[Status]='Approved') Then 'C'
		End)) and apprn.ClassificationID=CR.ClassifcationID and apprn.CategoryID=CR.CategoryID and apprn.level=CR.ApprovedBy
		
		--where CR.[Status] !='Draft'*/
GO
/****** Object:  Table [IT].[ITSpare]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ITSpare](
	[ITSpareID] [int] IDENTITY(1,1) NOT NULL,
	[ITSpareCode] [nvarchar](200) NULL,
	[SupportID] [int] NULL,
	[Requesttype] [nvarchar](500) NULL,
	[RequestedBY] [int] NULL,
	[RequestedFor] [int] NULL,
	[SelectedFor] [nvarchar](500) NULL,
	[Guest_Id] [int] NULL,
	[Guest_Name] [nvarchar](500) NULL,
	[Guest_Email] [nvarchar](500) NULL,
	[Guest_RManagerId] [int] NULL,
	[Guest_ContactNo] [int] NULL,
	[EmpType] [nvarchar](200) NULL,
	[Emp_Id] [int] NULL,
	[GxpReq] [nvarchar](200) NULL,
	[Asset_Type] [nvarchar](300) NULL,
	[Spare_Type] [nvarchar](500) NULL,
	[Spare_Model] [nvarchar](500) NULL,
	[Spare_SerialNo] [nvarchar](500) NULL,
	[Specs_Requirements] [nvarchar](500) NULL,
	[Specification] [nvarchar](max) NULL,
	[Justification] [nvarchar](200) NULL,
	[HOD_Approval] [nvarchar](500) NULL,
	[IsActive] [bit] NULL,
	[HOD_ApproverID] [int] NULL,
	[HOD_ApprovedDt] [datetime] NULL,
	[HOD_ApproverRemarks] [nvarchar](max) NULL,
	[RPM_ApproverID] [int] NULL,
	[RPM_ApprovedDt] [datetime] NULL,
	[RPM_ApproverRemarks] [nvarchar](max) NULL,
	[ResolRemarks] [nvarchar](max) NULL,
	[UserRemarks] [nvarchar](200) NULL,
	[ProposedResolDt] [datetime] NULL,
	[ResolDt] [datetime] NULL,
	[Description] [nvarchar](200) NULL,
	[OnHoldReason] [int] NULL,
	[Status] [nvarchar](200) NULL,
	[AssignedBy] [int] NULL,
	[AssignedTo] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_ITSpare] PRIMARY KEY CLUSTERED 
(
	[ITSpareID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_ITSpareHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [IT].[vw_ITSpareHistory] AS
SELECT 
	   spare.ITSpareCode
	  ,spare.ITSpareID
      ,spare.Requesttype
      ,spare.RequestedBY
	  ,isNull(requestby.FirstName, '')+ ' ' + isNull(requestby.MiddleName, '') + ' ' + isNull(requestby.LastName, '') AS RequestedByName
      ,spare.RequestedFor
	  ,isNull(requestfor.FirstName, '')+ ' ' + isNull(requestfor.MiddleName, '') + ' ' + isNull(requestfor.LastName, '') AS  RequestedForName
      ,spare.SelectedFor
      ,spare.Guest_Id
      ,spare.Guest_Name
      ,spare.Guest_Email
      ,spare.Guest_RManagerId
	  ,isNull(grpmId.FirstName, '')+ ' ' + isNull(grpmId.MiddleName, '') + ' ' + isNull(grpmId.LastName, '') AS  Guest_RManagerName
      ,spare.Guest_ContactNo
	   ,spare.EmpType
      ,spare.Emp_Id
      ,spare.GxpReq
      ,spare.Asset_Type
      ,spare.Spare_Type
      ,spare.Spare_Model
      ,spare.Spare_SerialNo
      ,spare.Specs_Requirements
	  ,spare.Specification
      ,spare.Justification
      ,spare.HOD_Approval
	  ,spare.Status
	  ,spare.AssignedTo
	  ,isNull(assinTo.FirstName, '') + ' ' + isNull(assinTo.MiddleName, '')+ ' ' + isNull(assinTo.LastName, '') AS AssignedToName
	  ,spare.AssignedBy
	  ,isNull(assigBy.FirstName, '') + ' ' + isNull(assigBy.MiddleName, '')+ ' ' + isNull(assigBy.LastName, '') AS AssignedByName
	  ,spare.HOD_ApproverID
	  ,spare.HOD_ApprovedDt
	  ,spare.HOD_ApproverRemarks
	  ,spare.RPM_ApproverID
	  ,spare.RPM_ApprovedDt
	  ,spare.RPM_ApproverRemarks
	  ,spare.ResolRemarks
	  ,spare.UserRemarks
	  ,spare.ProposedResolDt
	  ,spare.ResolDt
	  ,spare.Description
	  ,spare.OnHoldReason
	  ,supportData.SupportName
	  ,supportData.IsHODReq
	  ,supportData.IsRPMReq
	  ,spare.SupportID
	  ,hodEmp.EmployeeNo
	  ,rpm.Employee_ID as rpmEmpNO
	  ,hod.Employee_ID as hodEmpNo
	  ,isNull(hodEmp.FirstName, '') + ' ' + isNull(hodEmp.LastName, '') + ' ' + '(' + cast(hodEmp.EmployeeNo as nvarchar) + ')' AS hodToName
	  ,hodEmp.OfficialEmailId As hodEmail
	  ,isNull(rpmEmp.FirstName, '') + ' ' + isNull(rpmEmp.LastName, '') + ' ' + '(' + cast(rpmEmp.EmployeeNo as nvarchar) + ')' AS rpmToName
	  ,rpmEmp.OfficialEmailId As rpmEmail
      ,spare.IsActive
	  ,isNull(CreatedBy.FirstName, '') + ' ' + isNull(CreatedBy.MiddleName, '')+ ' ' + isNull(CreatedBy.LastName, '') AS CreatedBy
	  ,spare.CreatedDt
	  ,isNull(modifyby.FirstName, '') + ' ' + isNull(modifyby.MiddleName, '')+ ' ' + isNull(modifyby.LastName, '') AS ModifiedBy
	  ,spare.ModifiedDt
	from IT.ITSpare AS spare
	LEFT JOIN HR.Employee CreatedBy ON CreatedBy.EmployeeNo = cast(spare.CreatedBy as nvarchar(100))
	LEFT JOIN HR.Employee modifyby ON modifyby.EmployeeNo = cast(spare.ModifiedBy as nvarchar(100))
	LEFT JOIN HR.Employee requestby ON requestby.EmployeeNo = cast(spare.RequestedBY as nvarchar(100))
	LEFT JOIN HR.Employee requestfor ON requestfor.EmployeeNo = cast(spare.RequestedFor as nvarchar(100))
	LEFT JOIN HR.Employee assinTo ON assinTo.EmployeeNo = cast(spare.AssignedTo as nvarchar(100))
	LEFT JOIN HR.Employee assigBy ON assigBy.EmployeeNo = cast(spare.AssignedBy as nvarchar(100))
	left join Employee_Master rpm on rpm.ID = requestfor.ReportingManagerId
	left join Employee_Master hod on hod.ID = requestfor.ApprovingManagerId
	LEFT JOIN it.Support supportData ON supportData.SupportID = spare.SupportID
	left join hr.Employee hodEmp on hodEmp.EmployeeNo = cast(hod.Employee_ID as nvarchar(100))
	left join hr.Employee rpmEmp on rpmEmp.EmployeeNo = cast(rpm.Employee_ID as nvarchar(100))
	--GuestRManager
	LEFT JOIN HR.Employee grpmId ON grpmId.EmployeeNo = cast(spare.Guest_RManagerId as nvarchar(100))
GO
/****** Object:  View [IT].[vw_CRTaskEmail]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE View [IT].[vw_CRTaskEmail] as

select CR.ITCRID, CR.CRCode,CR.SupportID
,isNull(suppt.First_Name,'')+' '+isNull(suppt.Middle_Name,'')+' '+isNull(suppt.Last_Name,'') CROwner, suppt.Email CROEmail, suppt.Designation CRODesignation,suppt.Role CRORole,suppt.EmpID CROEmpid
,isNull(supptI.First_Name,'')+' '+isNull(supptI.Middle_Name,'')+' '+isNull(supptI.Last_Name,'') CRInitiator, supptI.Email CRIEmail, supptI.Designation CRIDesignation,supptI.Role CRIRole, supptI.EmpID CRIEmpid
,isNull(supptR.First_Name,'')+' '+isNull(supptR.Middle_Name,'')+' '+isNull(supptR.Last_Name,'') CRRequestor, supptR.Email CRREmail, supptR.Designation CRRDesignation,supptR.Role CRRRole, supptR.EmpID CRREmpid
,CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID, CR.PlantID as plantcode
,Class.ClassificationName,format(CR.CRDate,'dd-MMM-yyyy') CRDate,CR.Stage, CR.[Status], CR.ApprovedBy
,execp.ITCRExecID TaskID,execp.ExecutionStepDesc TaskDesc
,execp.AssignedTo AssignedTo, isNull(supptAssgn.First_Name,'')+' '+isNull(supptAssgn.Middle_Name,'')+' '+isNull(supptAssgn.Last_Name,'') AssignedToName, supptAssgn.Email AssgnEmail, supptAssgn.Designation AssgnDesignation,supptAssgn.Role AssgnRole,supptAssgn.EmpID AssgnEmpid
,execp.ForwardedTo, isNull(supptFwd.First_Name,'')+' '+isNull(supptFwd.Middle_Name,'')+' '+isNull(supptFwd.Last_Name,'') ForwardToName, supptFwd.Email ForwardToEmail, supptFwd.Designation ForwardToDesignation,supptFwd.Role ForwardToRole,supptFwd.EmpID ForwardToEmpid
,execp.Status EStatus, format(execp.PickedDt,'dd-MMM-yyyy') PickedDt,execp.PickedStatus,  format(execp.ModifiedDt,'dd-MMM-yyyy') AssignedDt

		from IT.ChangeRequest as CR
		inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
		inner join IT.Classification Class on Class.ITClassificationID=CR.ClassifcationID
		inner join IT.CategoryTyp catTyp on catTyp.CategoryID=CR.CategoryTypeID
		inner join Plant_Master plant on plant.Id = CR.PlantID
		inner join IT.CRExecutionPlan execp on execp.ITCRID=CR.ITCRID
		inner join IT.SupportTeam suppt on suppt.EmpID=CR.CROwner
		inner join IT.SupportTeam supptI on supptI.EmpID=CR.CRInitiatedFor
		inner join IT.SupportTeam supptR on supptR.EmpID=CR.CRRequestedBy
		Left join IT.SupportTeam supptAssgn on supptAssgn.EmpID=execp.AssignedTo
		Left join IT.SupportTeam supptFwd on supptFwd.EmpID=execp.ForwardedTo
		
		
		--where CR.[Status] NOT IN ['Cancelled']
GO
/****** Object:  View [IT].[vw_RPTApproverView ]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   View [IT].[vw_RPTApproverView ] AS
SELECT 
	distinct CR.CRCode,CR.ITCRID,
    CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID, CR.PlantID as plantcode,
	Class.ClassificationName,CR.CRDate,CR.ModifiedDt,cr.isImplemented,cr.isSubmitted ,CR.isApproved, CR.isReleased,CR.Stage, CR.[Status], CR.EstimatedCost, CR.EstimatedCostCurr, CR.EstimatedDateCompletion, CR.ApprovedBy
	,CR.PriorityType,plant.Code PlantID,CR.CRRequestedBy as ChangeRequestor
	,isNull(suppt.First_Name,'')+' '+isNull(suppt.Middle_Name,'')+' '+isNull(suppt.Last_Name,'') as CROwner
	,isNull(suprequestor.FirstName,'')+' '+isNull(suprequestor.MiddleName,'')+' '+isNull(suprequestor.LastName,'') as CRRequestorName
	,(select count(explan.ITCRExecID) from IT.CRExecutionPlan explan where explan.ITCRID=CR.ITCRID) taskcount
	--,(select appr.ModifiedBy from IT.CRApprover appr where appr.crid=cr.ITCRID and appr.Status=cr.Status and appr.Stage=cr.Stage) as ApproverID
	,appr.ApproverID
	from IT.ChangeRequest CR
	--Join IT.CRApprover CRA on CRA.CRID=CR.ITCRID
	inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
	inner join IT.Classification Class on Class.ITClassificationID=CR.ClassifcationID
	inner join IT.CategoryTyp catTyp on catTyp.CategoryTypeID=CR.CategoryTypeID
	inner join Plant_Master plant on plant.Id = CR.PlantID
	inner join IT.SupportTeam suppt on suppt.EmpID=CR.CROwner 
	inner join IT.CRApprover appr on appr.CRID=CR.ITCRID
	inner join HR.Employee suprequestor on suprequestor.EmployeeNo = cast(CR.CRRequestedBy as varchar(20))
	
	--where CR.Status in ('Pending Approval','Approved level1', 'Approved level2', 'Approved', 'Implemented','Released')
	
GO
/****** Object:  View [IT].[vw_CRClosure]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [IT].[vw_CRClosure] as
SELECT 
       [ITCRID]
      ,[ClosedStatus]
      ,[ClosureRemarks]
      ,[ClosedBy]
      ,[ClosedDt]
      ,[Feedback]
      ,[ModifiedBy]
      ,[ModifiedDt]
  FROM [IT].[ChangeRequest]
GO
/****** Object:  Table [IT].[NatureofChange]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[NatureofChange](
	[NatureofChangeID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[NatureofChange] [nvarchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_IT.NatureofChangeType] PRIMARY KEY CLUSTERED 
(
	[NatureofChangeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[ReferenceTyp]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ReferenceTyp](
	[ReferenceTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ReferenceType] [nvarchar](50) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_IT.ReferenceTyp] PRIMARY KEY CLUSTERED 
(
	[ReferenceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[Reference]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[Reference](
	[ReferenceID] [int] IDENTITY(1,1) NOT NULL,
	[ReferenceName] [nvarchar](50) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_IT.Reference] PRIMARY KEY CLUSTERED 
(
	[ReferenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_ChangeRequestSummary]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE View [IT].[vw_ChangeRequestSummary] as

	select distinct CR.ITCRID, CR.CRCode,CR.SupportID, suppt.First_Name+' '+isNull(suppt.Middle_Name,'')+' '+suppt.Last_Name CROwner, CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID,
	Class.ClassificationName,CR.CRDate,CR.ModifiedDt, CR.isApproved, CR.isReleased, CR.Stage,CR.[Status], CR.EstimatedCost, CR.EstimatedCostCurr, CR.EstimatedDateCompletion, CR.ApprovedBy
	,CR.PriorityType,cr.CROwner as ChangeRequestor,plant.Code PlantID,cr.PlantID as plantcode,supteam.First_Name+' '+isNull(suppt.Middle_Name,'')+' '+suppt.Last_Name as InitiatedFor,Nature.NatureofChange,
	Cattyp.CategoryType,cr.ReasonForChange,cr.AlternateConsidetation,cr.BackoutPlan,cr.BusinessImpact,crbyname.First_Name+' '+isNull(crbyname.Middle_Name,'')+' '+crbyname.Last_Name as changerequestedby,
	refid.ReferenceName,reftyp.ReferenceType,cr.ChangeControlNo,cr.ChangeControlDt,GxPPlant.Code as gxpplant,cr.DownTimeFromDate,cr.DownTimeToDate,cr.ImactedFunc,cr.ImpactedLocation,cr.ImpactedDept,
	cr.ImpactNotDoing,cr.TriggeredBy,cr.CRRequestedDt,cr.Benefits,cr.RollbackPlan,cr.EstimatedEffort,cr.EstimatedEffortUnit
		from IT.ChangeRequest as CR
		inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
		inner join IT.Classification Class on Class.ITClassificationID=cr.ClassifcationID
		inner join IT.SupportTeam suppt on suppt.EmpID=CR.CROwner
		inner join Plant_Master plant on plant.Id = CR.PlantID
		inner join IT.SupportTeam supteam ON supteam.EmpID = CR.CRInitiatedFor OR supteam.SupportTeamID = CR.CRInitiatedFor
		left join IT.NatureofChange Nature on Nature.NatureofChangeID = CR.NatureOfChange
		left join IT.CategoryTyp Cattyp on Cattyp.CategoryTypeID = CR.CategoryTypeID
		left join Plant_Master GxPPlant on GxPPlant.Id = cr.GXPPlantID
		inner join IT.SupportTeam crbyname on crbyname.EmpID = cr.CRRequestedBy or crbyname.SupportTeamID = cr.CRRequestedBy
		inner join it.Reference refid on refid.ReferenceID = cr.ReferenceID
		inner join it.ReferenceTyp reftyp on reftyp.ReferenceTypeID = cr.ReferenceTyp
GO
/****** Object:  Table [IT].[SRApprover]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRApprover](
	[SRApproverID] [int] IDENTITY(1,1) NOT NULL,
	[PlantID] [int] NOT NULL,
	[SRID] [int] NOT NULL,
	[SupportID] [nchar](10) NULL,
	[ApproverLevel] [int] NOT NULL,
	[Stage] [varchar](150) NULL,
	[ApproverID] [int] NULL,
	[ApprovedDt] [datetime] NOT NULL,
	[Remarks] [varchar](max) NULL,
	[Status] [varchar](150) NOT NULL,
	[Attachment] [varchar](2000) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_SRApproverID] PRIMARY KEY CLUSTERED 
(
	[SRApproverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_SRApprovedDat]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





 CREATE View [IT].[vw_SRApprovedDat] as
SELECT TOP (1000) 
    sa.[SRApproverID],
    sa.[PlantID],
    sa.[SRID],
    sa.[SupportID],
    sa.[ApproverLevel],
    sa.[Stage],
    sa.[ApproverID],
    sa.[ApprovedDt],
    sa.[Remarks],
    sa.[Status],
    sa.[Attachment],
    sa.[CreatedBy],
    sa.[CreatedDt],
    sa.[ModifiedBy],
    sa.[ModifiedDt],
    em.FirstName+' '+em.LastName AS CreatedByName,
    em.[OfficialEmailId] AS CreatedByEmail
FROM [MicroLabs_Dev].[IT].[SRApprover] sa
LEFT JOIN hr.Employee em 
    ON CAST(sa.CreatedBy AS VARCHAR(255)) = em.EmployeeNo

GO
/****** Object:  Table [IT].[CRMilestone]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[CRMilestone](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ITCRID] [int] NULL,
	[CRCode] [varchar](50) NULL,
	[CurrStatus] [varchar](100) NULL,
	[RFCCreatedDt] [datetime] NULL,
	[RFCSubmittedDt] [datetime] NULL,
	[RFCApproverLevel1] [int] NULL,
	[RFCApproverLevel1Dt] [datetime] NULL,
	[RFCApproverLevel2] [int] NULL,
	[RFCApproverLevel2Dt] [datetime] NULL,
	[RFCApproved] [int] NULL,
	[RFCApprovedDt] [datetime] NULL,
	[ImplementedDt] [datetime] NULL,
	[RelApproverLevel1] [int] NULL,
	[RelApproverLevel1Dt] [datetime] NULL,
	[RelApproverLevel2] [int] NULL,
	[RelApproverLevel2Dt] [datetime] NULL,
	[RelApproved] [int] NULL,
	[RelApprovedDt] [datetime] NULL,
	[ReleasedBy] [int] NULL,
	[ReleasedDt] [datetime] NULL,
	[ColApproverLevel1] [int] NULL,
	[ColApproverLevel1Dt] [datetime] NULL,
	[ColApproverLevel2] [int] NULL,
	[ColApproverLevel2Dt] [datetime] NULL,
	[ColApproved] [int] NULL,
	[ColApprovedDt] [datetime] NULL,
	[ClosedBy] [int] NULL,
	[ClosedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
 CONSTRAINT [PK_CRMilestone] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[Priority]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[Priority](
	[PriorityID] [int] IDENTITY(1,1) NOT NULL,
	[PriorityName] [varchar](500) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Priority] PRIMARY KEY CLUSTERED 
(
	[PriorityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_RPTCRMilestone]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   View [IT].[vw_RPTCRMilestone] as

select distinct CR.ITCRID, CR.CRCode,CR.SupportID
	,CRM.RFCCreatedDt as DraftDt,CRM.RFCSubmittedDt as SubmittedDt
	,(isNull(rfcapp1.First_Name,'')+' '+isNull(rfcapp1.Middle_Name,'')+' '+isNull(rfcapp1.Last_Name,''))as rfcapp1name,isNull(CRM.RFCApproverLevel1,'') as rfcapp1, CRM.RFCApproverLevel1Dt
	,(isNull(rfcapp2.First_Name,'')+' '+isNull(rfcapp2.Middle_Name,'')+' '+isNull(rfcapp2.Last_Name,'')) as rfcapp2name,isNull(CRM.RFCApproverLevel2,'') as rfcapp2, CRM.RFCApproverLevel2Dt
	,(isNull(rfcapp.First_Name,'')+' '+isNull(rfcapp.Middle_Name,'')+' '+isNull(rfcapp.Last_Name,''))as rfcappname,isNull(CRM.RFCApproved,'') as rfcappved, CRM.RFCApprovedDt
	,CRM.ImplementedDt
	,(isNull(relapp1.First_Name,'')+' '+isNull(relapp1.Middle_Name,'')+' '+isNull(relapp1.Last_Name,'')) as relapp1name,isNull(CRM.RelApproverLevel1,'') as relapp1, CRM.RelApproverLevel1Dt
	,(isNull(relapp2.First_Name,'')+' '+isNull(relapp2.Middle_Name,'')+' '+isNull(relapp2.Last_Name,'')) as relapp2name,isNull(CRM.RelApproverLevel2,'') as relapp2, CRM.RelApproverLevel2Dt
	,(isNull(relapp.First_Name,'')+' '+isNull(relapp.Middle_Name,'')+' '+isNull(relapp.Last_Name,''))as relappname,isNull(CRM.RelApproved,'') as relappved, CRM.RelApprovedDt
	,ReleasedBy,ReleasedDt
	,(isNull(colapp1.First_Name,'')+' '+isNull(colapp1.Middle_Name,'')+' '+isNull(colapp1.Last_Name,'')) as colapp1name,isNull(CRM.ColApproverLevel1,'') as colapp1, CRM.ColApproverLevel1Dt
	,(isNull(colapp2.First_Name,'')+' '+isNull(colapp2.Middle_Name,'')+' '+isNull(colapp2.Last_Name,'')) as colapp2name,isNull(CRM.ColApproverLevel2,'') as colapp2, CRM.ColApproverLevel2Dt
	,(isNull(colapp.First_Name,'')+' '+isNull(colapp.Middle_Name,'')+' '+isNull(colapp.Last_Name,''))as colappname,isNull(CRM.ColApproved,'') as colappved, CRM.ColApprovedDt
	,CR.ClosedBy,CR.ClosedDt,CR.CreatedBy,CR.CreatedDt
	,(isNull(suppt.First_Name,'')+' '+isNull(suppt.Middle_Name,'')+' '+isNull(suppt.Last_Name,'')) as CROwner,CR.CROwner as CROwnerid, CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID,
	Class.ClassificationName,CR.CRDate, CR.[Status], CR.EstimatedCost, CR.EstimatedCostCurr, CR.EstimatedDateCompletion, CR.ApprovedBy
	,CR.PriorityType,Pro.PriorityName,cr.CROwner as ChangeRequestor,plant.Code PlantID,cr.PlantID as plantcode
	,CatTyp.CategoryType,cr.CategoryTypeID, CR.CRInitiatedFor
	,isNull(supteam.First_Name,'')+' '+isNull(suppt.Middle_Name,'')+' '+isNull(suppt.Last_Name,'') as InitiatedFor
	,CR.isImplemented,cr.CRRequestedBy
	,isNull(crr.FirstName,'')+' '+isNull(crr.MiddleName,'')+' '+isNull(crr.LastName,'') as CRRequestorName
	from IT.ChangeRequest as CR
		inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
		inner join IT.Classification Class on Class.ITClassificationID=cr.ClassifcationID
		inner join IT.CategoryTyp CatTyp on CatTyp.CategoryTypeID = CR.CategoryTypeID
		inner join IT.SupportTeam suppt on suppt.EmpID=CR.CROwner
		inner Join IT.Priority Pro on Pro.PriorityID = CR.PriorityType
		inner join Plant_Master plant on plant.Id = CR.PlantID
		INNER JOIN IT.SupportTeam supteam ON supteam.EmpID = CR.CROwner --OR supteam.SupportTeamID = CR.CROwner
		inner Join HR.Employee crr on crr.EmployeeNo = cast(CR.CRRequestedBy as varchar(20))
		inner join IT.CRMilestone CRM on CRM.ITCRID=CR.ITCRID
		left join IT.Supportteam rfcapp1 on  rfcapp1.EmpID=CRM.RFCApproverLevel1
		left join IT.Supportteam rfcapp2 on  rfcapp2.EmpID=CRM.RFCApproverLevel2
		left join IT.Supportteam rfcapp on  rfcapp.EmpID=CRM.RFCApproved
		left join IT.Supportteam relapp1 on  relapp1.EmpID=CRM.RelApproverLevel1
		left join IT.Supportteam relapp2 on  relapp2.EmpID=CRM.RelApproverLevel2
		left join IT.Supportteam relapp on  relapp.EmpID=CRM.RelApproved
		left join IT.Supportteam colapp1 on  colapp1.EmpID=CRM.ColApproverLevel1
		left join IT.Supportteam colapp2 on  colapp2.EmpID=CRM.ColApproverLevel2
		left join IT.Supportteam colapp on  colapp.EmpID=CRM.ColApproved
		
		
GO
/****** Object:  View [IT].[vw_Systemlandscape]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE View [IT].[vw_Systemlandscape] as
select sysland.SysLandscapeID,sysland.SupportID,sysland.CategoryID,sysland.ClassificationID,catid.CategoryName,calid.ClassificationName,
sysland.SysLandscape,sysland.PriorityNum,prioriti.PriorityName,sysland.IsActive,sysland.CreatedBy,CreatedDate

			from IT.SysLandscape as sysland
			left join IT.Category catid on catid.ITCategoryID=sysland.CategoryID
			left join IT.Classification calid on calid.ITClassificationID=sysland.ClassificationID
			left join it.Priority prioriti on prioriti.PriorityID = sysland.PriorityNum
GO
/****** Object:  View [IT].[vw_Categorytype]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE View [IT].[vw_Categorytype] as
select cattyp.CategoryTypeID,cattyp.CategoryID,catid.CategoryName,cattyp.CategoryType,cattyp.IsActive,cattyp.CreatedBy,cattyp.CreatedDate,catid.ModifiedBy,cattyp.ModifiedDate
			from IT.CategoryTyp as cattyp
			left join IT.Category catid on catid.ITCategoryID=cattyp.CategoryID
GO
/****** Object:  View [IT].[vw_NatureofChange]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE View [IT].[vw_NatureofChange] as
select noch.NatureofChangeID,noch.CategoryID,catid.CategoryName,noch.NatureofChange,noch.IsActive,noch.CreatedBy,noch.ModifiedBy,noch.ModifiedDate
			from IT.NatureofChange as noch
			left join IT.Category catid on catid.ITCategoryID=noch.CategoryID

GO
/****** Object:  Table [IT].[ServiceRequest]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ServiceRequest](
	[SRID] [int] IDENTITY(1,1) NOT NULL,
	[SRCode] [nvarchar](50) NULL,
	[SupportID] [int] NULL,
	[SRSelectedfor] [nvarchar](50) NULL,
	[SRRaisedBy] [int] NULL,
	[SRDate] [datetime] NULL,
	[SRShotDesc] [nvarchar](200) NULL,
	[SRDesc] [nvarchar](2000) NULL,
	[SRRaiseFor] [int] NULL,
	[GuestEmployeeId] [int] NULL,
	[GuestName] [nvarchar](50) NULL,
	[GuestEmail] [nvarchar](50) NULL,
	[GuestContactNo] [varchar](20) NULL,
	[GuestReportingManagerEmployeeId] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[GuestCompany] [nvarchar](500) NULL,
	[PlantID] [int] NULL,
	[AssetID] [int] NULL,
	[CategoryID] [int] NULL,
	[CategoryTypID] [int] NULL,
	[Priority] [int] NULL,
	[SRForGuest] [nchar](10) NULL,
	[Source] [nvarchar](100) NULL,
	[Attachment] [nvarchar](100) NULL,
	[Status] [varchar](100) NULL,
	[AssignedTo] [int] NULL,
	[AssignedBy] [int] NULL,
	[AssignedOn] [datetime] NULL,
	[ProposedResolutionOn] [datetime] NULL,
	[Remarks] [nvarchar](max) NULL,
	[Stage] [nvarchar](200) NULL,
	[isApproved] [bit] NULL,
	[Approverstage] [nvarchar](200) NULL,
	[ApprovedBy] [nvarchar](200) NULL,
	[ApprovedDt] [datetime] NULL,
	[OnHoldReason] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_ServiceRequest] PRIMARY KEY CLUSTERED 
(
	[SRID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_ServiceRequest]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [IT].[vw_ServiceRequest] AS

SELECT 
    srValue.SRID,
    srValue.SRCode,
    srValue.SupportID,
	--srValue.SRRaisedBy AS SRRaiseBy,
    isNull(raisedby.FirstName, '') + ' ' + isNull(raisedby.MiddleName, '') + ' ' + isNull(raisedby.LastName, '') + ' ' + '(' + cast(srValue.SRRaisedBy as varchar) + ')' AS SRRaiseBy,
	srValue.SRRaisedBy as SRRaisedById,
	raisedby.OfficialEmailId as SRRaisedByEmail,
	srValue.SRRaiseFor as SRRaiseForId,
    srValue.SRDate,
    srValue.SRShotDesc,
    srValue.SRDesc,
	srValue.SRSelectedfor,
	--srValue.SRRaiseFor,
    isNull(raisefor.FirstName, '') + ' ' + isNull(raisefor.MiddleName, '') + ' ' + isNull(raisefor.LastName, '') + ' ' + '(' + cast(srValue.SRRaiseFor as varchar) + ')' AS SRRaiseFor,
	raisefor.OfficialEmailId as SRRaisedForEmail,
	srValue.GuestEmployeeId,
    srValue.GuestName,
    srValue.GuestEmail,
    srValue.GuestContactNo,
    srValue.GuestReportingManagerEmployeeId,
    srValue.Type,
    srValue.GuestCompany,
    srValue.PlantID,
    srValue.AssetID,
    srValue.CategoryID,
    srValue.CategoryTypID,
    srValue.Priority,
    srValue.SRForGuest,
    srValue.Source,
    srValue.Attachment,
    srValue.Status,
    srValue.SRRaiseFor AS raiseforId,
    srValue.AssignedTo,
    srValue.AssignedBy,
    srValue.AssignedOn,
    srValue.ProposedResolutionOn,
    srValue.Remarks,
    srValue.Stage,
    srValue.isApproved,
    srValue.Approverstage,
    srValue.ApprovedBy,
    srValue.ApprovedDt,
    isNull(CreatedBy.FirstName, '') + ' ' + isNull(CreatedBy.LastName, '') + ' ' + '(' + cast(srValue.CreatedBy as nvarchar) + ')' AS CreatedBy,
    srValue.CreatedDt,
    isNull(modifyby.FirstName, '') + ' ' + isNull(modifyby.LastName, '') + ' ' + '(' + cast(srValue.ModifiedBy as nvarchar) + ')' AS ModifiedBy,
    srValue.ModifiedDt,
    rpm.Employee_ID as rpmEmpNO,
	hod.Employee_ID as hodEmpNo,
    ---Support Data
    support.SupportName,
    support.ParentID,
    support.IsActive AS SupportIsActive,
    support.IsVisible,
    support.Image,
    parentSupport.URL,
    support.IsHODReq,
    support.IsRPMReq,
    support.CreatedBy AS SupportCreatedBy,
    support.CreatedDate AS SupportCreatedDate,
    support.UpdatedBy AS SupportUpdatedBy,
    support.UpdatedDate AS SupportUpdatedDate,
	isNull(grm.FirstName, '') + ' ' + isNull(grm.LastName, '') + ' '  AS GuestReportingManagerName,
    

	isNull(assignTo.FirstName, '') + ' ' + isNull(assignTo.LastName, '') + ' ' + '(' + cast(srValue.AssignedTo as nvarchar) + ')' AS AssignToName,
    isNull(hodEmp.FirstName, '') + ' ' + isNull(hodEmp.LastName, '') + ' ' + '(' + cast(hodEmp.EmployeeNo as nvarchar) + ')' AS hodToName,
	hodEmp.OfficialEmailId As hodEmail,
	isNull(rpmEmp.FirstName, '') + ' ' + isNull(rpmEmp.LastName, '') + ' ' + '(' + cast(rpmEmp.EmployeeNo as nvarchar) + ')' AS rpmToName,
    rpmEmp.OfficialEmailId As rpmEmail,
    
    -- Parent Support Data
    parentSupport.SupportName AS ParentSupportName,
	parentSupport.SupportID AS serviceId,
	--OnHoldReason
	onhold.OnholdReason
FROM [IT].[ServiceRequest] AS srValue
LEFT JOIN HR.Employee emp ON emp.EmployeeNo = cast(srValue.SRRaisedBy as nvarchar(100)) 
LEFT JOIN HR.Employee CreatedBy ON CreatedBy.EmployeeNo = cast(srValue.CreatedBy as nvarchar(100))
LEFT JOIN HR.Employee raisedby ON raisedby.EmployeeNo = cast(srValue.SRRaisedBy as nvarchar(100))
LEFT JOIN HR.Employee raisefor ON raisefor.EmployeeNo = cast(srValue.SRRaiseFor as nvarchar(100))
LEFT JOIN HR.Employee modifyby ON modifyby.EmployeeNo = cast(srValue.SRRaiseFor as nvarchar(100))
LEFT JOIN HR.Employee assignTo ON assignTo.EmployeeNo = cast(srValue.AssignedTo as nvarchar(100))
LEFT JOIN HR.Employee grm ON grm.EmployeeNo = cast(srValue.GuestReportingManagerEmployeeId as nvarchar(100))
LEFT JOIN [IT].[Support] AS support ON support.SupportID = srValue.SupportID

--Resolution
LEFT JOIN [IT].[IssueOnholdCat] AS onhold ON onhold.IssueOnholdCatID = srValue.OnHoldReason



LEFT JOIN [IT].[Support] AS parentSupport ON support.ParentID = parentSupport.SupportID
left join Employee_Master rpm on rpm.ID = raisefor.ReportingManagerId
left join Employee_Master hod on hod.ID = raisefor.ApprovingManagerId
left join hr.Employee hodEmp on hodEmp.EmployeeNo = cast(hod.Employee_ID as nvarchar(100))
left join hr.Employee rpmEmp on rpmEmp.EmployeeNo = cast(rpm.Employee_ID as nvarchar(100));


GO
/****** Object:  Table [IT].[SRSoftware]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRSoftware](
	[SWID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SoftwareType] [nvarchar](20) NULL,
	[SoftwareName] [nvarchar](200) NULL,
	[SoftwareVersionName] [nvarchar](200) NULL,
	[VendorName] [nvarchar](200) NULL,
	[InstType] [nvarchar](200) NULL,
	[LicenceType] [nvarchar](200) NULL,
	[Location] [nvarchar](200) NULL,
	[Department] [nvarchar](200) NULL,
	[NoOfUers] [nvarchar](200) NULL,
	[NoOfLicence] [nvarchar](200) NULL,
	[CostPerLicence] [nvarchar](200) NULL,
	[TotalCost] [int] NULL,
	[AMCAppilcable] [bit] NULL,
	[CostForAMC] [nvarchar](200) NULL,
	[ScopeOfAMC] [nvarchar](200) NULL,
	[IsInstReq] [bit] NULL,
	[InstCharge] [numeric](18, 0) NULL,
	[DtlsOfInst] [nvarchar](max) NULL,
	[DtlsOfinstDt] [datetime] NULL,
	[TypeOfDev] [nvarchar](200) NULL,
	[DtlsOfDev] [nvarchar](200) NULL,
	[IsInterfaceReq] [bit] NULL,
	[InterfaceReq] [nvarchar](max) NULL,
	[InterfaceWith] [nvarchar](max) NULL,
	[IsGxpApp] [bit] NULL,
	[NonFunReq] [nvarchar](max) NULL,
	[DtlsOfReq] [nvarchar](max) NULL,
	[WhereHosted] [nvarchar](max) NULL,
	[TypeOfWeb] [nvarchar](200) NULL,
	[UsageBY] [nvarchar](max) NULL,
	[UserAccessFrom] [nvarchar](200) NULL,
	[CurrVersion] [nvarchar](200) NULL,
	[TareVersion] [nvarchar](200) NULL,
	[Brds] [nvarchar](max) NULL,
	[BusJustification] [nvarchar](max) NULL,
	[Justification] [nvarchar](200) NULL,
	[NoofUseruse] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_SRSosftware]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE   VIEW [IT].[vw_SRSosftware] AS
SELECT 
    sw.[SWID],
    sw.[SRID],
    sw.[SoftwareType],
    sw.[SoftwareName],
    sw.[SoftwareVersionName],
    sw.[VendorName],
    sw.[InstType],
    sw.[LicenceType],
    sw.[Location],
    sw.[Department],
    sw.[NoOfUers],
    sw.[NoOfLicence],
    sw.[CostPerLicence],
    sw.[TotalCost],
    sw.[AMCAppilcable],
    sw.[CostForAMC],
    sw.[ScopeOfAMC],
    sw.[IsInstReq],
    sw.[InstCharge],
    sw.[DtlsOfInst],
    sw.[DtlsOfinstDt],
    sw.[TypeOfDev],
    sw.[DtlsOfDev],
    sw.[IsInterfaceReq],
    sw.[InterfaceReq],
    sw.[InterfaceWith],
    sw.[IsGxpApp],
    sw.[NonFunReq],
    sw.[DtlsOfReq],
    sw.[WhereHosted],
    sw.[TypeOfWeb],
    sw.[UsageBY],
    sw.[UserAccessFrom],
    sw.[CurrVersion],
    sw.[TareVersion],
    sw.[Brds],
    sw.[BusJustification],
    sw.[IsActive],
    sw.[CreatedBy],
    sw.[CreatedDt],
    sw.[ModifiedBy],
    sw.[ModifiedDt],
	sw.[Justification],
	sw.[NoofUseruse],
    
    -- Service Request Data
    sr.SRCode,
    sr.SupportID,
    sr.SRRaiseBy,
    sr.SRDate,
    sr.SRShotDesc,
    sr.SRDesc,
    sr.SRRaiseFor,
	sr.SRSelectedfor,
    sr.GuestEmployeeId,
    sr.GuestName,
    sr.GuestEmail,
    sr.GuestContactNo,
    sr.GuestReportingManagerEmployeeId,
    sr.Type,
    sr.GuestCompany,
    sr.PlantID,
    sr.AssetID,
    sr.CategoryID,
    sr.CategoryTypID,
    sr.Priority,
    sr.SRForGuest,
    sr.Source,
    sr.Attachment,
    sr.Status,
    sr.AssignedTo,
    sr.AssignedBy,
    sr.AssignedOn,
    sr.ProposedResolutionOn,
    sr.Remarks,
    sr.Stage,
    sr.isApproved,
    sr.Approverstage,
    sr.ApprovedBy,
    sr.ApprovedDt,
	sr.rpmEmail,
	sr.hodEmail,
	sr.hodToName,
	sr.rpmToName,
	sr.raiseforId,
	sr.SRRaisedById,
	sr.SRRaisedByEmail,
	sr.SRRaisedForEmail,
	sr.GuestReportingManagerName,


    -- Support Data
    s.SupportName,
    s.ParentID,
    s.IsActive AS SupportIsActive,
    s.IsVisible,
    s.Image,
    s.URL,
    s.IsHODReq,
    s.IsRPMReq,
    s.CreatedBy AS SupportCreatedBy,
    s.CreatedDate AS SupportCreatedDate,
    s.UpdatedBy AS SupportUpdatedBy,
    s.UpdatedDate AS SupportUpdatedDate,
    -- Parent Support Data
    p.SupportName AS ParentSupportName


FROM [IT].[SRSoftware] AS sw
JOIN [IT].[vw_ServiceRequest] AS sr ON sw.SRID = sr.SRID
LEFT JOIN [IT].[Support] AS s ON sr.SupportID = s.SupportID
LEFT JOIN [IT].[Support] AS p ON s.ParentID = p.SupportID; -- Join for Parent Support
GO
/****** Object:  Table [IT].[SRResolution]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRResolution](
	[SRResolID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NOT NULL,
	[ResolRemarks] [nvarchar](max) NULL,
	[UserRemarks] [nvarchar](200) NULL,
	[ProposedResolDt] [datetime] NULL,
	[ResolDt] [datetime] NULL,
	[Description] [nvarchar](200) NULL,
	[OnHoldReason] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRResolution] PRIMARY KEY CLUSTERED 
(
	[SRResolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_SRResolution]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [IT].[vw_SRResolution] AS
SELECT 
    SRR.[SRResolID],
    SRR.[SRID],
    SRR.[ResolRemarks],
    SRR.[UserRemarks],
    SRR.[ProposedResolDt],
    SRR.[ResolDt],
    SRR.[Description],
    SRR.[OnHoldReason],
    SRR.[CreatedBy],
    SRR.[CreatedDt],
    SRR.[ModifiedBy],
    SRR.[ModifiedDt],
    emp.[FirstName] AS CreatedByName
FROM 
    [IT].[SRResolution] SRR
JOIN 
    hr.Employee emp ON CAST(SRR.CreatedBy AS VARCHAR(50)) = emp.EmployeeNo
GO
/****** Object:  Table [IT].[SLA]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SLA](
	[ITSLAID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ClassificationID] [int] NOT NULL,
	[CategoryTypID] [int] NULL,
	[SupportID] [int] NOT NULL,
	[WaitTime] [int] NULL,
	[WaitTimeUnit] [varchar](50) NULL,
	[AssignedTo] [int] NULL,
	[PlantID] [int] NULL,
	[Escalation1] [int] NULL,
	[WaitTimeEscal1] [int] NULL,
	[WaitTimeUnitEscal1] [varchar](50) NULL,
	[Escalation2] [int] NULL,
	[WaitTimeEscal2] [int] NULL,
	[WaitTimeUnitEscal2] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [date] NULL,
 CONSTRAINT [PK_SLA] PRIMARY KEY CLUSTERED 
(
	[ITSLAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[IssueListHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[IssueListHistory](
	[IssueHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[IssueHistoryDt] [datetime] NOT NULL,
	[IssueID] [int] NOT NULL,
	[IssueCode] [nvarchar](50) NULL,
	[IssueRaisedBy] [int] NOT NULL,
	[IssueDate] [datetime] NOT NULL,
	[IssueShotDesc] [nvarchar](200) NOT NULL,
	[IssueDesc] [nvarchar](max) NOT NULL,
	[IssueRaiseFor] [int] NULL,
	[GuestCompany] [nvarchar](500) NULL,
	[PlantID] [int] NULL,
	[AssetID] [int] NULL,
	[CategoryID] [int] NULL,
	[CategoryTypID] [int] NULL,
	[Priority] [int] NULL,
	[Source] [nvarchar](100) NULL,
	[Type] [nvarchar](50) NULL,
	[Attachment] [nvarchar](100) NULL,
	[Status] [nvarchar](max) NULL,
	[AssignedTo] [int] NULL,
	[AssignedBy] [int] NULL,
	[AssignedOn] [datetime] NULL,
	[ProposedResolutionOn] [datetime] NULL,
	[ResolutionDt] [datetime] NULL,
	[ResolutionRemarks] [nvarchar](3000) NULL,
	[ReasonID] [int] NULL,
	[IssueForGuest] [nchar](10) NULL,
	[Remarks] [nchar](10) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_IssueListHistory] PRIMARY KEY CLUSTERED 
(
	[IssueHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_IssueListHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [IT].[vw_IssueListHistory] as
SELECT TOP 100 PERCENT 
issue.IssueID,issue.IssueCode,issue.IssueRaisedBy as Raisedbyid,
(Select isNull(raisedby.FirstName,'')+' '+isNull(raisedby.MiddleName,'') +' '+ isNull(raisedby.LastName,'') from Hr.Employee raisedby where raisedby.EmployeeNo = cast(issue.IssueRaisedBy as varchar(20))) IssueRaiseBy,
issue.IssueDate,issue.IssueShotDesc,issue.IssueDesc,
(Select isNull(raisedfor.FirstName,'')+' '+ isNull(raisedfor.MiddleName,'')+' '+ isNull(raisedfor.LastName,'') from Hr.Employee raisedfor where raisedfor.EmployeeNo = cast(issue.IssueRaiseFor as varchar(20))) IssueRaisedFor,
issue.IssueRaiseFor as issuerisedforid
,issue.IssueForGuest,
issue.GuestCompany,issue.PlantID,issue.AssetID,issue.CategoryID,issue.Priority as priorityid,issue.Source,issue.Attachment,LTRIM(RTRIM(issue.Status)) as Status,
issue.Type,issue.AssignedTo as AssignedToid
,(isnull(assignto.FirstName,'')+ ' ' + isnull(assignto.MiddleName,'')+ ' ' + isnull(assignto.LastName,'')) AssignedTo 
,issue.AssignedBy as Assignedbyid
,(isnull(assignby.FirstName,'')+ ' '+ isnull(assignby.MiddleName,'')+' ' + isnull(assignby.LastName,'')) AssignedBy 
,issue.ResolutionRemarks as Remarks,issue.CreatedBy,issue.CreatedDt,issue.ModifiedBy,
issue.ModifiedDt,
cat.CategoryName,issue.CategoryTypID,cattyp.CategoryType,plant.Code as Plantname,prio.PriorityName
,(select (case 
			when ((datediff(WEEKDAY,issue.IssueDate,getdate()))>sla.WaitTime) then 'R'
			when ((datediff(WEEKDAY,issue.IssueDate,getdate()))=sla.WaitTime) then 'Y'
			when ((datediff(WEEKDAY,issue.IssueDate,getdate()))<sla.WaitTime) then 'G'
			End) from IT.SLA sla where sla.PlantID=issue.PlantID and sla.CategoryID=issue.CategoryID and sla.CategoryTypID=issue.CategoryTypID ) as slastatus,
			 CASE 
				WHEN issue.Status = 'Open' THEN
					ISNULL(issue.ModifiedDt,'NULL')
				ELSE
					NULL
			END as AssignedOn,
			 CASE 
				WHEN issue.Status = 'Resolved' THEN 
					((Select isNull(resl.FirstName,'')+' '+ isNull(resl.MiddleName,'')+' '+ isNull(resl.LastName,'') +'('+resl.EmployeeNo+')' from Hr.Employee resl where resl.EmployeeNo = cast(issue.ModifiedBy as varchar(20))))
				ELSE 
					NULL 
			END as ResolvedBy, 



			CASE 
				WHEN issue.Status = 'Resolved' THEN 
					ISNULL(issue.ModifiedDt,'NULL')
				ELSE 
					NULL 
			END as ResolvedOn,

			CASE 
				WHEN issue.Status = 'Resolved' THEN 
					ISNULL(issue.ResolutionRemarks, 'NULL')
				ELSE 
					NULL 
			END as ResolveRemarks,
    
			CASE 
				WHEN issue.Status = 'Closed' THEN
					((Select isNull(clos.FirstName,'')+' '+ isNull(clos.MiddleName,'')+' '+ isNull(clos.LastName,'') +'('+clos.EmployeeNo+')' from Hr.Employee clos where clos.EmployeeNo = cast(issue.ModifiedBy as varchar(20))))
				ELSE
					NULL
			END as ClosedBy,
			CASE 
				WHEN issue.Status = 'Closed' THEN
					ISNULL(issue.ResolutionRemarks,'NULL')
				ELSE
					NULL
			END as ClosedRemark,
			CASE 
				WHEN issue.Status = 'Closed' THEN
					ISNULL(issue.ModifiedDt,'NUll')
				ELSE
					NULL
			END as ClosedDate

			from 
			IT.IssueListHistory as issue
			left join HR.Employee as assignby on assignby.EmployeeNo = cast(issue.AssignedBy as varchar(20))
			left join HR.Employee as assignto on assignto.EmployeeNo = cast(issue.AssignedTo as varchar(20))
			left join Plant_Master plant on plant.Id=issue.PlantID
			left join it.Category cat on cat.ITCategoryID=issue.CategoryID
			left join it.CategoryTyp cattyp on cattyp.CategoryTypeID=issue.CategoryTypID
			left join it.Priority prio on prio.PriorityID=issue.Priority
			order by issue.ModifiedDt desc
GO
/****** Object:  Table [IT].[SRAttachment]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRAttachment](
	[AttachID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[FileName] [nvarchar](500) NULL,
	[Stage] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_SRAttachment] PRIMARY KEY CLUSTERED 
(
	[AttachID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_SRAttachment]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [IT].[vw_SRAttachment] As Select * from IT.SRAttachment
GO
/****** Object:  Table [IT].[ISAttachment]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ISAttachment](
	[AttachID] [int] IDENTITY(1,1) NOT NULL,
	[ISID] [int] NULL,
	[FileName] [nvarchar](500) NULL,
	[Stage] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_ISAttachment] PRIMARY KEY CLUSTERED 
(
	[AttachID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_ISAttachment]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [IT].[vw_ISAttachment] As Select * from IT.ISAttachment
GO
/****** Object:  Table [IT].[IssueList]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[IssueList](
	[IssueID] [int] IDENTITY(1,1) NOT NULL,
	[IssueCode] [nvarchar](50) NULL,
	[IssueSelectedfor] [nvarchar](50) NULL,
	[IssueRaisedBy] [int] NOT NULL,
	[IssueDate] [datetime] NOT NULL,
	[IssueShotDesc] [nvarchar](200) NOT NULL,
	[IssueDesc] [nvarchar](max) NOT NULL,
	[IssueRaiseFor] [int] NULL,
	[GuestEmployeeId] [int] NULL,
	[GuestName] [nvarchar](50) NULL,
	[GuestEmail] [nvarchar](50) NULL,
	[GuestContactNo] [varchar](20) NULL,
	[GuestReportingManagerEmployeeId] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[GuestCompany] [nvarchar](500) NULL,
	[PlantID] [int] NULL,
	[AssetID] [int] NULL,
	[CategoryID] [int] NULL,
	[CategoryTypID] [int] NULL,
	[Priority] [int] NULL,
	[IssueForGuest] [nchar](10) NULL,
	[Source] [nvarchar](100) NULL,
	[Attachment] [nvarchar](100) NULL,
	[Status] [nvarchar](max) NULL,
	[AssignedTo] [int] NULL,
	[AssignedBy] [int] NULL,
	[AssignedOn] [datetime] NULL,
	[ProposedResolutionOn] [datetime] NULL,
	[Remarks] [nchar](10) NULL,
	[ResolutionDt] [datetime] NULL,
	[ResolutionRemarks] [nvarchar](3000) NULL,
	[ReasonID] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_IssueList] PRIMARY KEY CLUSTERED 
(
	[IssueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_IssueList]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [IT].[vw_IssueList] as

select issue.IssueID,issue.IssueCode,issue.IssueRaisedBy as raisedbyid,isnull(risedby.FirstName,'') +' '+ isnull(risedby.LastName,'') as issuerisedby,issue.IssueDate,issue.IssueShotDesc,issue.IssueDesc,issue.IssueRaiseFor as issuerisedforid,isnull(risedfor.FirstName,'') +' '+ isnull(risedfor.LastName,'') as issuerisedfor,issue.IssueForGuest,
issue.IssueSelectedfor,issue.GuestCompany,issue.GuestEmployeeId,issue.GuestName,
issue.GuestContactNo,issue.Type,issue.GuestReportingManagerEmployeeId,issue.GuestEmail,issue.PlantID
,plant.Code as plantname,issue.AssetID
,issue.CategoryID,cat.CategoryName,issue.CategoryTypID,cattyp.CategoryType
,issue.Priority as priorityid,prio.PriorityName,issue.Source,issue.Attachment,issue.Status,issue.AssignedTo as AssignedToid
,(select distinct concat(assignto.First_Name,' ',assignto.Middle_Name,' ',assignto.Last_Name) from IT.SupportTeam assignto where assignto.EmpID=issue.AssignedTo) as AssignedTo
,issue.AssignedBy as assignedbyid
,isnull(assignby.FirstName,'') +' '+ isnull(assignby.MiddleName,'') +' '+ isnull(assignby.LastName,'') as AssignedBy,issue.AssignedOn,issue.ProposedResolutionOn,issue.ResolutionDt,issue.ResolutionRemarks,
issue.Remarks,
issue.ReasonID, (select reason.OnholdReason from IT.IssueOnholdCat reason Where reason.IssueOnholdCatID = issue.ReasonID) as OnHoldReason,
issue.CreatedBy,issue.CreatedDt,issue.ModifiedBy,issue.ModifiedDt,
(select (case 
			when ((datediff(WEEKDAY,issue.IssueDate,getdate()))>sla.WaitTime) then 'R'
			when ((datediff(WEEKDAY,issue.IssueDate,getdate()))=sla.WaitTime) then 'Y'
			when ((datediff(WEEKDAY,issue.IssueDate,getdate()))<sla.WaitTime) then 'G'
			End) from IT.SLA sla where sla.PlantID=issue.PlantID and sla.CategoryID=issue.CategoryID and sla.CategoryTypID=issue.CategoryTypID ) as slastatus,
			CASE 
				WHEN issue.Status = 'Open' THEN
					ISNULL(issue.ModifiedDt,'NULL')
				ELSE
					NULL
			END as AssignedDt,
			 CASE 
				WHEN issue.Status = 'Resolved' THEN 
					((Select isNull(resl.FirstName,'')+' '+ isNull(resl.MiddleName,'')+' '+ isNull(resl.LastName,'') +'('+resl.EmployeeNo+')' from Hr.Employee resl where resl.EmployeeNo = cast(issue.ModifiedBy as varchar(20))))
				ELSE 
					NULL 
			END as ResolvedBy, 



			CASE 
				WHEN issue.Status = 'Resolved' THEN 
					ISNULL(issue.ModifiedDt,'NULL')
				ELSE 
					NULL 
			END as ResolvedOn,

			CASE 
				WHEN issue.Status = 'Resolved' THEN 
					ISNULL(issue.ResolutionRemarks, 'NULL')
				ELSE 
					NULL 
			END as ResolveRemarks,
    
			CASE 
				WHEN issue.Status = 'Closed' THEN
					((Select isNull(clos.FirstName,'')+' '+ isNull(clos.MiddleName,'')+' '+ isNull(clos.LastName,'') +'('+clos.EmployeeNo+')' from Hr.Employee clos where clos.EmployeeNo = cast(issue.ModifiedBy as varchar(20))))
				ELSE
					NULL
			END as ClosedBy,
			CASE 
				WHEN issue.Status = 'Closed' THEN
					ISNULL(issue.ResolutionRemarks,'NULL')
				ELSE
					NULL
			END as ClosedRemark,
			CASE 
				WHEN issue.Status = 'Closed' THEN
					ISNULL(issue.ModifiedDt,'NUll')
				ELSE
					NULL
			END as ClosedDate,
(select sla.WaitTime from IT.SLA sla where sla.PlantID=issue.PlantID and sla.CategoryID=issue.CategoryID and sla.CategoryTypID=issue.CategoryTypID ) as slaTime,
(select sla.WaitTimeUnit from IT.SLA sla where sla.PlantID=issue.PlantID and sla.CategoryID=issue.CategoryID and sla.CategoryTypID=issue.CategoryTypID ) as slaunit
			from IT.IssueList as issue
			left join HR.Employee as risedby on risedby.EmployeeNo = cast(issue.IssueRaisedBy as varchar(20))
			left join HR.Employee as risedfor on risedfor.EmployeeNo = cast(issue.IssueRaiseFor as varchar(20))
			left join HR.Employee as assignby on assignby.EmployeeNo = cast(issue.AssignedBy as varchar(20))
			--left join it.SupportTeam as assignto on assignto.EmpID = issue.AssignedTo 
			left join Plant_Master plant on plant.Id=issue.PlantID
			left join it.Category cat on cat.ITCategoryID=issue.CategoryID
			left join it.CategoryTyp cattyp on cattyp.CategoryTypeID=issue.CategoryTypID
			left join it.Priority prio on prio.PriorityID=issue.Priority

GO
/****** Object:  Table [IT].[SRSoftwareHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRSoftwareHistory](
	[SWHID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SoftwareType] [nvarchar](20) NULL,
	[SoftwareName] [nvarchar](200) NULL,
	[SoftwareVersionName] [nvarchar](200) NULL,
	[VendorName] [nvarchar](200) NULL,
	[InstType] [nvarchar](200) NULL,
	[LicenceType] [nvarchar](200) NULL,
	[Location] [nvarchar](200) NULL,
	[Department] [nvarchar](200) NULL,
	[NoOfUers] [nvarchar](200) NULL,
	[NoOfLicence] [nvarchar](200) NULL,
	[CostPerLicence] [nvarchar](200) NULL,
	[TotalCost] [int] NULL,
	[AMCAppilcable] [bit] NULL,
	[CostForAMC] [nvarchar](200) NULL,
	[ScopeOfAMC] [nvarchar](200) NULL,
	[IsInstReq] [bit] NULL,
	[InstCharge] [numeric](18, 0) NULL,
	[DtlsOfInst] [nvarchar](max) NULL,
	[DtlsOfinstDt] [datetime] NULL,
	[TypeOfDev] [nvarchar](200) NULL,
	[DtlsOfDev] [nvarchar](200) NULL,
	[IsInterfaceReq] [bit] NULL,
	[InterfaceReq] [nvarchar](max) NULL,
	[InterfaceWith] [nvarchar](max) NULL,
	[IsGxpApp] [bit] NULL,
	[NonFunReq] [nvarchar](max) NULL,
	[DtlsOfReq] [nvarchar](max) NULL,
	[WhereHosted] [nvarchar](max) NULL,
	[TypeOfWeb] [nvarchar](200) NULL,
	[UsageBY] [nvarchar](max) NULL,
	[UserAccessFrom] [nvarchar](200) NULL,
	[CurrVersion] [nvarchar](200) NULL,
	[TareVersion] [nvarchar](200) NULL,
	[Brds] [nvarchar](max) NULL,
	[BusJustification] [nvarchar](max) NULL,
	[Justification] [nvarchar](200) NULL,
	[NoofUseruse] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_SRSoftwareHistory] PRIMARY KEY CLUSTERED 
(
	[SWHID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_SRHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




Create   VIEW [IT].[vw_SRHistory] AS
	SELECT
	ssh.[SWHID],
    ssh.[SRID],
    ssh.[SupportID],
    ssh.[SoftwareType],
    ssh.[SoftwareName],
    ssh.[SoftwareVersionName],
    ssh.[VendorName],
    ssh.[InstType],
    ssh.[LicenceType],
    ssh.[Location],
    ssh.[Department],
    ssh.[NoOfUers],
    ssh.[NoOfLicence],
    ssh.[CostPerLicence],
    ssh.[TotalCost],
    ssh.[AMCAppilcable],
    ssh.[CostForAMC],
    ssh.[ScopeOfAMC],
    ssh.[IsInstReq],
    ssh.[InstCharge],
    ssh.[DtlsOfInst],
    ssh.[DtlsOfinstDt],
    ssh.[TypeOfDev],
    ssh.[DtlsOfDev],
    ssh.[IsInterfaceReq],
    ssh.[InterfaceReq],
    ssh.[InterfaceWith],
    ssh.[IsGxpApp],
    ssh.[NonFunReq],
    ssh.[DtlsOfReq],
    ssh.[WhereHosted],
    ssh.[TypeOfWeb],
    ssh.[UsageBY],
    ssh.[UserAccessFrom],
    ssh.[CurrVersion],
    ssh.[TareVersion],
    ssh.[Brds],
    ssh.[BusJustification],
    ssh.[Justification],
    ssh.[IsActive],
	isNull( emp.FirstName,'')+' '+' '+ isNULL(emp.MiddleName,'')+ ' ' + isNull(emp.LastName,'') AS CreatedByName,
    ssh.[CreatedDt],
	isNull( modEmp.FirstName,'')+' '+' '+ isNULL(modEmp.MiddleName,'')+ ' ' + isNull(modEmp.LastName,'') AS ModifiedByName,
    
    ssh.[ModifiedDt],
    sup.[SupportName],
	sr.SRCode,
	sr.Status
FROM 
    [IT].[SRSoftwareHistory] AS ssh
LEFT JOIN 
    [HR].[Employee] AS emp ON emp.EmployeeNo  =cast( ssh.CreatedBy as nvarchar(200))
LEFT JOIN 
    [IT].Support AS sup ON sup.SupportID  = ssh.SupportID
LEFT JOIN 
    [HR].Employee AS modEmp ON modEmp.EmployeeNo  =cast(  ssh.ModifiedBy as nvarchar(200))
 LEFT JOIN  [IT].ServiceRequest AS sr ON sr.SRID  =ssh.SRID

GO
/****** Object:  Table [IT].[SupportTeamAssgn]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SupportTeamAssgn](
	[SupportTeamAssgnID] [int] IDENTITY(1,1) NOT NULL,
	[SupportTeamID] [int] NOT NULL,
	[SupportID] [int] NOT NULL,
	[CategoryID] [int] NULL,
	[ClassificationID] [int] NULL,
	[CategoryTypID] [int] NULL,
	[PlantID] [int] NULL,
	[isApprover] [bit] NULL,
	[isChangeAnalyst] [bit] NULL,
	[isSupportEngineer] [bit] NULL,
	[isAdmin] [bit] NULL,
	[isSuperAdmin] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_SupportTeamAssgn] PRIMARY KEY CLUSTERED 
(
	[SupportTeamAssgnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_SupportTeamAll ]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE   View [IT].[vw_SupportTeamAll ] as

select 
suppt.SupportTeamID,suppta.SupportTeamAssgnID,suppt.email, suppt.First_Name, suppt.Middle_Name, suppt.Last_Name, suppt.DOL, suppt.DOB, suppt.EmpID
,suppta.isApprover,suppta.ischangeanalyst, suppta.isadmin, suppta.issupportengineer,suppta.isSuperAdmin,cat.ITCategoryID CategoryID
,cat.CategoryName,
suppta.CategoryTypID, cattype.CategoryType,
suppta.ClassificationID,cal.ClassificationName,suppta.SupportID,sup.SupportName,suppta.PlantID,plant.Code,suppt.Designation,
suppt.Img_Url,suppt.IsActive,appr.Level, appr.Approverstage
from IT.SupportTeam suppt 
inner join IT.SupportTeamAssgn suppta on suppta.supportteamid=suppt.supportteamid
left join it.Category cat on cat.ITCategoryID = suppta.CategoryID
left join it.Classification cal on cal.ITClassificationID = suppta.ClassificationID
left join IT.CategoryTyp cattype on cattype.CategoryTypeID = suppta.CategoryTypID
left join it.Support sup on sup.SupportID = suppta.SupportID
left join Plant_Master plant on plant.Id = suppta.PlantID
left outer join IT.Approver appr on (appr.approver1=suppt.supportteamid or appr.Approver2=suppt.supportteamid or appr.Approver3=suppt.supportteamid)
and appr.PlantID=suppta.PlantID and appr.CategoryID=suppta.CategoryID and appr.ClassificationID=suppta.ClassificationID
		
GO
/****** Object:  Table [IT].[Checklist]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[Checklist](
	[ITChecklistID] [int] IDENTITY(1,1) NOT NULL,
	[PlantID] [int] NULL,
	[SupportID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ClassificationID] [int] NOT NULL,
	[ChecklistTitle] [nvarchar](150) NOT NULL,
	[ChecklistDesc] [nvarchar](1500) NOT NULL,
	[MandatoryFlag] [bit] NULL,
	[ApproverID] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_ITChecklist] PRIMARY KEY CLUSTERED 
(
	[ITChecklistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_Checklist]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [IT].[vw_Checklist] as

select Checklist.ITChecklistID,Checklist.PlantID,plant.Code as plantname,Checklist.SupportID,Checklist.CategoryID,cat.CategoryName,
Checklist.ClassificationID,cal.ClassificationName,Checklist.ChecklistTitle,Checklist.ChecklistDesc,Checklist.MandatoryFlag,
Checklist.ApproverID,supt.First_Name +' '+ supt.Last_Name as Approvername,Checklist.CreatedBy,Checklist.CreatedDt,Checklist.ModifiedBy,Checklist.ModifiedDt

			from IT.Checklist as Checklist
			left join Plant_Master plant on plant.Id=Checklist.PlantID
			left join IT.Category cat on cat.ITCategoryID=Checklist.CategoryID
			left join it.Classification cal on cal.ITClassificationID = Checklist.ClassificationID
			left join it.SupportTeam supt on supt.SupportTeamID = Checklist.ApproverID

GO
/****** Object:  Table [IT].[ServiceRequestHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ServiceRequestHistory](
	[SRHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SRCode] [nvarchar](50) NULL,
	[SupportID] [int] NULL,
	[SRSelectedfor] [nvarchar](50) NULL,
	[SRRaisedBy] [int] NULL,
	[SRDate] [datetime] NULL,
	[SRShotDesc] [nvarchar](200) NULL,
	[SRDesc] [nvarchar](2000) NULL,
	[SRRaiseFor] [int] NULL,
	[GuestEmployeeId] [int] NULL,
	[GuestName] [nvarchar](50) NULL,
	[GuestEmail] [nvarchar](50) NULL,
	[GuestContactNo] [varchar](20) NULL,
	[GuestReportingManagerEmployeeId] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[GuestCompany] [nvarchar](500) NULL,
	[PlantID] [int] NULL,
	[AssetID] [int] NULL,
	[CategoryID] [int] NULL,
	[CategoryTypID] [int] NULL,
	[Priority] [int] NULL,
	[SRForGuest] [nchar](10) NULL,
	[Source] [nvarchar](100) NULL,
	[Attachment] [nvarchar](100) NULL,
	[Status] [varchar](100) NULL,
	[AssignedTo] [int] NULL,
	[AssignedBy] [int] NULL,
	[AssignedOn] [datetime] NULL,
	[ProposedResolutionOn] [datetime] NULL,
	[Remarks] [nvarchar](max) NULL,
	[Stage] [nvarchar](200) NULL,
	[isApproved] [bit] NULL,
	[Approverstage] [nvarchar](200) NULL,
	[ApprovedBy] [nvarchar](200) NULL,
	[ApprovedDt] [datetime] NULL,
	[OnHoldReason] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_ServiceRequestHistory] PRIMARY KEY CLUSTERED 
(
	[SRHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_SRCommonHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE   VIEW [IT].[vw_SRCommonHistory] AS
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
	ssh.[ModifiedDt]
FROM 
    [IT].[ServiceRequestHistory] AS ssh 
LEFT JOIN 
    [HR].[Employee] AS emp ON emp.EmployeeNo  =cast( ssh.CreatedBy as nvarchar(200))
LEFT JOIN 
    [HR].[Employee] AS modifyemp ON modifyemp.EmployeeNo  =cast( ssh.ModifiedBy as nvarchar(200))
LEFT JOIN 
    [IT].Support AS sup ON sup.SupportID  = ssh.SupportID
 LEFT JOIN  [IT].SRSoftware AS sr ON sr.SRID  =ssh.SRID
GO
/****** Object:  View [IT].[GetSLAList]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [IT].[GetSLAList]
AS
	Select SLAlist.ITSLAID,SLAlist.Escalation1,SLAlist.Escalation2,SLAlist.PlantID,SLAlist.SupportID,SLAlist.WaitTime
	,SLAlist.WaitTimeEscal1,SLAlist.WaitTimeUnit,SLAlist.WaitTimeUnitEscal1,SLAlist.WaitTimeUnitEscal2,SLAlist.AssignedTo,
	SLAlist.CategoryID,SLAlist.CategoryTypID,SLAlist.ClassificationID,SLAlist.CreatedBy,SLAlist.CreatedDt,
	category.CategoryName CategoryName,class.ClassificationName ClassificationName,catType.CategoryType CategoryType,
	catType.CategoryType CategoryTypeName
	--,categorytype.CategoryType CategoryType--classification.ClassificationName
	from It.SLA as SLAlist
	left join It.Category category on category.ITCategoryID = SLAlist.CategoryID
	left join it.CategoryTyp categorytype on categorytype.CategoryTypeID = SLAlist.CategoryTypID
	left join it.Classification classification on classification.ITClassificationID = SLAlist.ClassificationID
	left join it.Support supp on supp.SupportID = SLAlist.SupportID
	left join it.Classification class on class.ITClassificationID = SLAlist.ClassificationID
	left join it.CategoryTyp catType on catType.CategoryTypeID = SLAlist.CategoryTypID
GO
/****** Object:  View [IT].[vw_ApproverView ]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE View [IT].[vw_ApproverView ] AS
SELECT 
	CR.CRCode,CR.ITCRID,
    CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID, CR.PlantID as plantcode,
	Class.ClassificationName,CR.CRDate,CR.ModifiedDt,cr.isImplemented,cr.isSubmitted ,CR.isApproved, CR.isReleased,CR.Stage, CR.[Status], CR.EstimatedCost, CR.EstimatedCostCurr, CR.EstimatedDateCompletion, CR.ApprovedBy
	,CR.PriorityType,plant.Code PlantID,CR.CRRequestedBy as ChangeRequestor
	,isNull(suprequestor.FirstName,'')+' '+isNull(suprequestor.MiddleName,'')+' '+isNull(suprequestor.LastName,'') as CRRequestorName
	,(select count(explan.ITCRExecID) from IT.CRExecutionPlan explan where explan.ITCRID=CR.ITCRID) taskcount
	,(SELECT CRA.ApproverID 
     FROM IT.CRApprover CRA 
     WHERE CRA.CRID = CR.ITCRID 
       AND CRA.ModifiedDt = (SELECT MAX(ModifiedDt) 
                             FROM IT.CRApprover 
                             WHERE CRID = CR.ITCRID)) AS LastApprovedID,
    (SELECT CONCAT(sta1.First_Name, ' ', sta1.Middle_Name, ' ', sta1.Last_Name)
        FROM  IT.CRApprover CRA 
        LEFT JOIN  IT.SupportTeam sta1 ON sta1.EmpID = CRA.ApproverID
        WHERE 
            CRA.CRID = CR.ITCRID 
            AND CRA.ModifiedDt = (
                SELECT 
                    MAX(ModifiedDt) 
                FROM 
                    IT.CRApprover 
                WHERE 
                    CRID = CR.ITCRID
            )
    ) AS LastApproverName,
    (SELECT CRA.ApprovedDt 
     FROM IT.CRApprover CRA 
     WHERE CRA.CRID = CR.ITCRID 
       AND CRA.ModifiedDt = (SELECT MAX(ModifiedDt) 
                             FROM IT.CRApprover 
                             WHERE CRID = CR.ITCRID)) AS LastApprovedDate
,(
		SELECT CASE 
			WHEN (CR.Stage = 'Initiated' AND CR.[Status] = 'Pending Approval') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=1 and appr.Approverstage='N' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=2 and appr.Approverstage='N' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=3 and appr.Approverstage='N' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Implementation' AND CR.[Status] = 'Implemented') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=1 and appr.Approverstage='R' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=2 and appr.Approverstage='R' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=3 and appr.Approverstage='R' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Released') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=2 and appr.Approverstage='C' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level2')
				THEN (select appr.Approver1 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			
		END
	) as Approver1
	, (
		SELECT CASE 
			WHEN (CR.Stage = 'Initiated' AND CR.[Status] = 'Pending Approval') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=1 and appr.Approverstage='N' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=2 and appr.Approverstage='N' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=3 and appr.Approverstage='N' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Implementation' AND CR.[Status] = 'Implemented') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=1 and appr.Approverstage='R' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=2 and appr.Approverstage='R' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=3 and appr.Approverstage='R' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Released') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=2 and appr.Approverstage='C' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level2')
				THEN (select appr.Approver2 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			
		END
	) as Approver2
	,(
		SELECT CASE 
			WHEN (CR.Stage = 'Initiated' AND CR.[Status] = 'Pending Approval') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=1 and appr.Approverstage='N' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=2 and appr.Approverstage='N' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=3 and appr.Approverstage='N' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Implementation' AND CR.[Status] = 'Implemented') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=1 and appr.Approverstage='R' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=2 and appr.Approverstage='R' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=3 and appr.Approverstage='R' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Released') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=2 and appr.Approverstage='C' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level2')
				THEN (select appr.Approver3 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			
		END
	) as Approver3

	from IT.ChangeRequest CR
	--Join IT.CRApprover CRA on CRA.CRID=CR.ITCRID
	inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
	inner join IT.Classification Class on Class.ITClassificationID=CR.ClassifcationID
	inner join IT.CategoryTyp catTyp on catTyp.CategoryTypeID=CR.CategoryTypeID
	inner join Plant_Master plant on plant.Id = CR.PlantID
	inner join IT.SupportTeam suppt on suppt.EmpID=CR.CROwner 
	inner join HR.Employee suprequestor on suprequestor.EmployeeNo = cast(CR.CRRequestedBy as varchar(20))
	where CR.Status in ('Pending Approval','Approved level1', 'Approved level2', 'Implemented','Released')
	
GO
/****** Object:  View [IT].[vw_SupportEngineer ]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [IT].[vw_SupportEngineer ] as

select distinct CR.ITCRID, CR.CRCode,CR.SupportID, 
isNull(suppt.First_Name,'')+' '+isNull(suppt.Middle_Name,'')+' '+isNull(suppt.Last_Name,'') CROwner, 
CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID,cr.PlantID as plantcode,
	Class.ClassificationName,CR.CRDate,CR.ModifiedDt,cr.isImplemented,cr.isSubmitted,CR.isApproved,CR.isReleased, CR.Stage, CR.[Status], CR.EstimatedCost, CR.EstimatedCostCurr, CR.EstimatedDateCompletion, CR.ApprovedBy
	,CR.PriorityType,cr.CROwner as ChangeRequestor,plant.Code PlantID,cr.CRRequestedBy
	,suprequestor.FirstName+' '+isNull(suprequestor.MiddleName,'')+' '+suprequestor.LastName as CRRequestorName
	,(select count(explan.ITCRExecID) from IT.CRExecutionPlan explan where explan.ITCRID=CR.ITCRID) taskcount
	--,(select distinct e.AssignedTo from IT.CRExecutionPlan e where e.ITCRID=CR.ITCRID) assgigntome
	,execplan.AssignedTo as assgigntome, execplan.ITCRExecID,execplan.Status Taskstatus
		from IT.ChangeRequest as CR
		inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
		inner join IT.Classification Class on Class.ITClassificationID=cr.ClassifcationID
		inner join Plant_Master plant on plant.Id = CR.PlantID
		inner join IT.SupportTeam suppt on suppt.EmpID=CR.CROwner
		inner join IT.CRExecutionPlan execplan on execplan.ITCRID=CR.ITCRID
		inner join HR.Employee suprequestor on suprequestor.EmployeeNo = cast(CR.CRRequestedBy as varchar(20))
		--inner join IT.SupportTeamAssgn suppta on suppta.ClassificationID=CR.ClassifcationID and suppta.CategoryID=CR.CategoryID and suppta.PlantID=plant.id and suppta.SupportID=CR.SupportID
		--inner join IT.SupportTeam supp on supp.SupportTeamID=suppta.SupportTeamID
		where CR.[Status] not in('Draft' ,'Cancelled')
		
GO
/****** Object:  View [IT].[vw_ApproverCR ]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE   View [IT].[vw_ApproverCR ] as

select distinct CR.ITCRID, CR.CRCode,CR.SupportID, 
suppt.First_Name+' '+isNull(suppt.Middle_Name,'')+' '+suppt.Last_Name CROwner, 
CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID, CR.PlantID as plantcode,
	Class.ClassificationName,CR.CRDate,CR.ModifiedDt,cr.isImplemented,cr.isSubmitted ,CR.isApproved, CR.isReleased,CR.Stage, CR.[Status], CR.EstimatedCost, CR.EstimatedCostCurr, CR.EstimatedDateCompletion, CR.ApprovedBy
	,CR.PriorityType,plant.Code PlantID,CR.CRRequestedBy as ChangeRequestor
	,isNull(suprequestor.FirstName,'')+' '+isNull(suprequestor.MiddleName,'')+' '+isNull(suprequestor.LastName,'') as CRRequestorName
	,(select count(explan.ITCRExecID) from IT.CRExecutionPlan explan where explan.ITCRID=CR.ITCRID) taskcount
		from IT.ChangeRequest as CR
		inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
		inner join IT.Classification Class on Class.ITClassificationID=CR.ClassifcationID
		inner join IT.CategoryTyp catTyp on catTyp.CategoryTypeID=CR.CategoryTypeID
		inner join Plant_Master plant on plant.Id = CR.PlantID
		inner join IT.SupportTeam suppt on suppt.EmpID=CR.CROwner 
		inner join HR.Employee suprequestor on suprequestor.EmployeeNo = cast(CR.CRRequestedBy as varchar(20))
		inner join IT.SupportTeamAssgn suppta on suppta.isapprover=1
		-- and suppta.SupportTeamID=suppt.SupportTeamID
		--and suppta.SupportID=CR.SupportID 
		inner join IT.SupportTeam supp on supp.SupportTeamID=suppta.SupportTeamID
		Left join IT.Approver appr1 on appr1.Approver1=supp.SupportTeamID and appr1.ClassificationID=CR.ClassifcationID and appr1.CategoryID=CR.CategoryID-- and appr1.supportid=cr.SupportID
		Left join IT.Approver appr2 on appr2.Approver2=supp.SupportTeamID and appr2.ClassificationID=CR.ClassifcationID and appr2.CategoryID=CR.CategoryID-- and appr2.supportid=cr.SupportID
		Left join IT.Approver appr3 on appr2.Approver3=supp.SupportTeamID and appr3.ClassificationID=CR.ClassifcationID and appr3.CategoryID=CR.CategoryID-- and appr3.supportid=cr.SupportID
		--left join IT.approver apprn on apprn.ClassificationID=CR.ClassifcationID and apprn.CategoryID=CR.CategoryID and apprn.PlantID=cr.PlantID
		left join IT.approver apprn on apprn.approverstage =(select (case 
		when (CR.Stage='Initated' and CR.[Status]='Pending Approval') Then 'N'
		when (CR.Stage='Approval' and CR.[Status]='Approved Level1') Then 'N'
		when (CR.Stage='Approval' and CR.[Status]='Approved Level2') Then 'N'
		when (CR.Stage='Approval' and CR.[Status]='Approved') Then 'N'
		when (CR.Stage='Release' and CR.[Status]='Approved Level1') Then 'R'
		when (CR.Stage='Release' and CR.[Status]='Approved Level2') Then 'R'
		when (CR.Stage='Release' and CR.[Status]='Approved') Then 'R'
		when (CR.Stage='Closure' and CR.[Status]='Approved Level1') Then 'C'
		when (CR.Stage='Closure' and CR.[Status]='Approved Level2') Then 'C'
		when (CR.Stage='Closure' and CR.[Status]='Approved') Then 'C'
		End)) and apprn.ClassificationID=CR.ClassifcationID and apprn.CategoryID=CR.CategoryID and apprn.level=1 
		and apprn.PlantID=CR.PlantID and apprn.SupportID=CR.SupportID
		where CR.[Status] not in ('Draft','Cancelled')
		--order by CR.ITCRID desc
GO
/****** Object:  View [IT].[vw_SupportTeamDtls ]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE View [IT].[vw_SupportTeamDtls ] as

select 
suppt.SupportTeamID,suppt.email,suppt.First_Name, suppt.Middle_Name, suppt.Last_Name, suppt.DOL, suppt.DOB, suppt.EmpID
,suppta.isApprover,suppta.ischangeanalyst, suppta.isadmin,suppta.isSuperAdmin, suppta.issupportengineer,suppta.CategoryID,cat.CategoryName,
suppta.ClassificationID,cal.ClassificationName,cattype.CategoryTypeID,
cattype.CategoryType,
suppta.SupportID,sup.SupportName,suppta.PlantID,plant.Code,suppt.Designation,suppt.Role,
suppt.Img_Url,suppt.IsActive,suppta.SupportTeamAssgnID
from IT.SupportTeam suppt 
inner join IT.SupportTeamAssgn suppta on suppta.supportteamid=suppt.supportteamid
left join it.Category cat on cat.ITCategoryID = suppta.CategoryID
left join It.CategoryTyp cattype on cattype.CategoryTypeID = suppta.CategoryTypID
left join it.Classification cal on cal.ITClassificationID = suppta.ClassificationID
left join it.Support sup on sup.SupportID = suppta.SupportID
left join Plant_Master plant on plant.Id = suppta.PlantID
		
GO
/****** Object:  View [IT].[vw_RPTCRExecPlan]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE View [IT].[vw_RPTCRExecPlan] as

	select CR.ITCRID, CR.CRCode,CR.SupportID
	, Emp.First_Name CROwner
	, CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID,
	Class.ClassificationName,CR.CRDate,CR.ModifiedDt,CR.Stage
	,cattyp.CategoryTypeID,cattyp.CategoryType
	,nature.NatureofChange
	,Support.First_Name +' '+ Support.Last_Name as Supportname
	,assgnto.First_Name +' '+ assgnto.Last_Name as AssignedTo,fwdto.First_Name +' '+ fwdto.Last_Name as ForwardedTo
	,execplan.Status,CR.PriorityType,Pro.PriorityName
	,syslan.SysLandscape,deptland.SysLandscape as DependSyelanscape,deptask.ExecutionStepDesc as depndtask
	,execplan.ITCRExecID as TaskID
	,execplan.StartDt as plantstartdate,execplan.EndDT,execplan.ActualStartDt,execplan.ActualEndDt
	,plant.Code,plant.Id plantId
		from IT.ChangeRequest as CR
		inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
		inner join IT.Classification Class on Class.ITClassificationID=cr.ClassifcationID
		inner join IT.SupportTeam Emp on Emp.EmpID=CR.CROwner
		inner join IT.CategoryTyp cattyp on cattyp.CategoryTypeID=CR.CategoryTypeID
		inner join IT.NatureofChange nature on nature.NatureofChangeID=CR.NatureOfChange
		inner join IT.SupportTeam Support on Support.EmpID=CR.CRInitiatedFor
		inner Join IT.CRExecutionPlan execplan on execplan.ITCRID=CR.ITCRID
		inner Join IT.Priority Pro on Pro.PriorityID = CR.PriorityType
		left join IT.SupportTeam assgnto on assgnto.EmpID=execplan.AssignedTo
		left join IT.SupportTeam fwdto on fwdto.EmpID=execplan.ForwardedTo
		left join it.SysLandscape syslan on syslan.SysLandscapeID = execplan.SysLandscape
		left join it.SysLandscape deptland on deptland.SysLandscapeID = execplan.DependSysLandscape
		left join it.CRExecutionPlan deptask on deptask.DependTaskID = execplan.ITCRExecID
		left join Plant_Master plant on plant.Id = cr.PlantID


GO
/****** Object:  Table [IT].[ChangeRequestHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ChangeRequestHistory](
	[CRHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[CRHistoryDt] [datetime] NULL,
	[ITCRID] [int] NOT NULL,
	[CRCode] [varchar](50) NOT NULL,
	[EventName] [varchar](50) NOT NULL,
	[SupportID] [int] NULL,
	[ClassifcationID] [int] NULL,
	[CategoryID] [int] NULL,
	[CROwner] [int] NULL,
	[CRDate] [datetime] NULL,
	[CRRequestedBy] [int] NULL,
	[CRRequestedDt] [datetime] NULL,
	[CRInitiatedFor] [int] NULL,
	[Stage] [nchar](50) NULL,
	[Status] [nchar](50) NULL,
	[ReferenceID] [int] NULL,
	[ReferenceTyp] [int] NULL,
	[CategoryTypeID] [int] NULL,
	[NatureOfChange] [int] NULL,
	[PriorityType] [int] NULL,
	[PlantID] [int] NULL,
	[SysLandscapeID] [nvarchar](500) NULL,
	[GXPClassification] [bit] NULL,
	[GXPPlantID] [int] NULL,
	[ChangeControlNo] [nchar](10) NULL,
	[ChangeControlDt] [date] NULL,
	[ChangeControlAttach] [bit] NULL,
	[ChangeDesc] [varchar](2000) NULL,
	[ReasonForChange] [varchar](2000) NULL,
	[AlternateConsidetation] [varchar](2000) NULL,
	[ImpactNotDoing] [varchar](2000) NULL,
	[BusinessImpact] [varchar](2000) NULL,
	[TriggeredBy] [varchar](2000) NULL,
	[Benefits] [varchar](2000) NULL,
	[EstimatedCost] [numeric](18, 0) NULL,
	[EstimatedCostCurr] [char](3) NULL,
	[EstimatedEffort] [int] NULL,
	[EstimatedEffortUnit] [nchar](10) NULL,
	[EstimatedDateCompletion] [date] NULL,
	[RollbackPlan] [varchar](2000) NULL,
	[BackoutPlan] [varchar](2000) NULL,
	[DownTimeRequired] [bit] NULL,
	[DownTimeFromDate] [datetime] NULL,
	[DownTimeToDate] [datetime] NULL,
	[ImpactedLocation] [nvarchar](50) NULL,
	[ImpactedDept] [nvarchar](50) NULL,
	[ImactedFunc] [nvarchar](50) NULL,
	[ApprovedBy] [int] NULL,
	[ApprovedDt] [nchar](10) NULL,
	[isSubmitted] [bit] NULL,
	[isApproved] [bit] NULL,
	[isImplemented] [bit] NULL,
	[isReleased] [bit] NULL,
	[ClosedStatus] [nvarchar](150) NULL,
	[ClosureRemarks] [nvarchar](max) NULL,
	[ClosedBy] [int] NULL,
	[ClosedDt] [datetime] NULL,
	[Feedback] [nvarchar](max) NULL,
	[Remarks] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_ChangeRequestHistory] PRIMARY KEY CLUSTERED 
(
	[CRHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_ChangeRequestHistory ]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [IT].[vw_ChangeRequestHistory ] as

select CRHistoryID, CRHistoryDt,ITCRID,CRCode,EventName,CROwner,CRRequestedBy,CRRequestedDt,CRInitiatedFor,CreatedDt,
CONCAT(isNull(suppt.First_Name,''), isNull(suppt.Middle_Name,''), isNull(suppt.Last_Name,'')) as supptname
from it.ChangeRequestHistory as CR
inner join IT.SupportTeam suppt on suppt.EmpID = CR.CreatedBy

GO
/****** Object:  Table [IT].[CRRelease]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[CRRelease](
	[CRReleaseID] [int] IDENTITY(1,1) NOT NULL,
	[ITCRID] [int] NOT NULL,
	[SysLandscape] [int] NOT NULL,
	[ReleaseComments] [nvarchar](max) NOT NULL,
	[AssignedTo] [int] NULL,
	[ReleaseDt] [datetime] NULL,
	[Attachments] [nvarchar](500) NULL,
	[Status] [nchar](10) NULL,
	[ApprovedBy] [int] NULL,
	[ApprovedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.CRRelease] PRIMARY KEY CLUSTERED 
(
	[CRReleaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_CRRelease]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE View [IT].[vw_CRRelease] as
SELECT [CRReleaseID]
      ,[ITCRID]
      ,[SysLandscape]
      ,[ReleaseComments]
      ,[AssignedTo]
      ,[ReleaseDt]
      ,[Attachments]
      ,[Status]
      ,[ApprovedBy]
      ,[ApprovedDt]
      ,[CreatedBy]
      ,[CreatedDt]
      ,[ModifiedBy]
      ,[ModifiedDt]
  FROM [MicroLabs_Dev].[IT].[CRRelease]
GO
/****** Object:  Table [IT].[ServiceCitrix]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ServiceCitrix](
	[ServiceCitrixID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceCode] [nvarchar](50) NULL,
	[RaisedBy] [int] NOT NULL,
	[SRDate] [datetime] NOT NULL,
	[ShotDesc] [nvarchar](200) NOT NULL,
	[SRDesc] [nvarchar](2000) NOT NULL,
	[SRRaiseFor] [int] NULL,
	[PlantID] [int] NULL,
	[AssetID] [int] NULL,
	[CategoryID] [int] NULL,
	[CategoryTypID] [int] NULL,
	[Priority] [int] NULL,
	[Source] [nvarchar](100) NULL,
	[Service] [nvarchar](50) NULL,
	[Attachment] [nvarchar](100) NULL,
	[Status] [nvarchar](10) NULL,
	[ApprovedLevel1] [int] NULL,
	[ApprovedLevel1By] [int] NULL,
	[ApprovedLevel1On] [datetime] NULL,
	[ApprovedLevel2] [int] NULL,
	[ApprovedLevel2By] [int] NULL,
	[ApprovedLevel2On] [datetime] NULL,
	[ApprovedLevel3] [int] NULL,
	[ApprovedLevel3By] [int] NULL,
	[ApprovedLevel3On] [datetime] NULL,
	[AssignedTo] [int] NULL,
	[AssignedBy] [int] NULL,
	[AssignedOn] [datetime] NULL,
	[ProposedResolutionOn] [datetime] NULL,
	[ResolutionDt] [datetime] NULL,
	[ResolutionRemarks] [nvarchar](3000) NULL,
	[Remarks] [nvarchar](3000) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_ServiceCitrix] PRIMARY KEY CLUSTERED 
(
	[ServiceCitrixID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_ServiceCitrix]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE View [IT].[vw_ServiceCitrix] as
	select sercit.ServiceCitrixID,sercit.ServiceCode,sercit.RaisedBy,sercit.SRDate,sercit.ShotDesc ,sercit.SRDesc,sercit.SRRaiseFor as SRRaiseForid,
	isnull(emp.First_Name,null) + isnull(emp.Middle_Name,null) + isnull(emp.Last_Name,null) as SRRaiseFor
	
	
	
		from it.ServiceCitrix as sercit
		left join Employee_Master as emp on emp.Employee_ID = cast(sercit.SRRaiseFor as varchar(20))
GO
/****** Object:  Table [IT].[SRDomain]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRDomain](
	[SRDomainID] [int] IDENTITY(1,1) NOT NULL,
	[Support] [int] NULL,
	[SRID] [int] NULL,
	[DomainName] [nvarchar](max) NULL,
	[Plant] [nvarchar](200) NULL,
	[Department] [nvarchar](200) NULL,
	[NoofUser] [int] NULL,
	[PurPoseDomain] [nvarchar](200) NULL,
	[DueDate] [datetime] NULL,
	[TypeofSSL] [nvarchar](250) NULL,
	[RenewalPeriod] [int] NULL,
	[Justification] [nvarchar](250) NULL,
	[DiscontinuationDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[ReqDomainName] [nvarchar](200) NULL,
	[ModifyBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRDomain] PRIMARY KEY CLUSTERED 
(
	[SRDomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_SRDomain]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [IT].[vw_SRDomain] AS
SELECT TOP (1000) 
    -- From SRDomain table
    SRDomain.SRDomainID,
    SRDomain.Support,
    SRDomain.SRID,
    SRDomain.DomainName,
    SRDomain.Plant,
    SRDomain.Department,
    SRDomain.NoofUser,
    SRDomain.PurPoseDomain,
    SRDomain.DueDate,
    SRDomain.TypeofSSL,
    SRDomain.RenewalPeriod,
    SRDomain.Justification,
    SRDomain.DiscontinuationDate,
    SRDomain.IsActive,
    SRDomain.ReqDomainName,
    SRDomain.ModifyBy,
    SRDomain.ModifiedDt,
    SRDomain.CreatedBy,
    SRDomain.CreatedDt,
    
    -- From ServiceRequest table
    ServiceRequest.SRID AS SRID_ServiceRequest,
	ServiceRequest.GuestReportingManagerName,
    ServiceRequest.SRCode,
    ServiceRequest.SupportID,
    ServiceRequest.SRRaiseBy,
    ServiceRequest.SRDate,
    ServiceRequest.SRShotDesc,
    ServiceRequest.SRDesc,
    ServiceRequest.SRRaiseFor,
    ServiceRequest.GuestEmployeeId,
    ServiceRequest.GuestName,
    ServiceRequest.GuestEmail,
	ServiceRequest.SRSelectedfor,
    ServiceRequest.GuestContactNo,
    ServiceRequest.GuestReportingManagerEmployeeId,
    ServiceRequest.Type,
    ServiceRequest.GuestCompany,
    ServiceRequest.PlantID,
    ServiceRequest.AssetID,
    ServiceRequest.CategoryID,
    ServiceRequest.CategoryTypID,
    ServiceRequest.Priority,
    ServiceRequest.SRForGuest,
    ServiceRequest.Source,
    ServiceRequest.Attachment,
    ServiceRequest.Status,
    ServiceRequest.AssignedTo,
    ServiceRequest.AssignedBy,
    ServiceRequest.AssignedOn,
    ServiceRequest.ProposedResolutionOn,
    ServiceRequest.Remarks,
    ServiceRequest.Stage,
    ServiceRequest.isApproved,
    ServiceRequest.Approverstage,
    ServiceRequest.ApprovedBy,
    ServiceRequest.ApprovedDt,
    ServiceRequest.CreatedBy AS SR_CreatedBy,
    ServiceRequest.CreatedDt AS SR_CreatedDt,
    ServiceRequest.ModifiedBy AS SR_ModifiedBy,
    ServiceRequest.ModifiedDt AS SR_ModifiedDt,
	ServiceRequest.rpmEmail,
	ServiceRequest.hodEmail,
	ServiceRequest.hodToName,
	ServiceRequest.rpmToName,
    s.IsHODReq,
    s.IsRPMReq
FROM 
    [MicroLabs_Dev].[IT].[SRDomain] AS SRDomain
JOIN [IT].[vw_ServiceRequest] AS ServiceRequest ON SRDomain.SRID = ServiceRequest.SRID
LEFT JOIN [MicroLabs_Dev].[IT].[Support] AS s ON ServiceRequest.SupportID = s.SupportID
LEFT JOIN [MicroLabs_Dev].[IT].[Support] AS p ON s.ParentID = p.SupportID;

GO
/****** Object:  Table [IT].[CRFollowup]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[CRFollowup](
	[CRFollowupID] [int] IDENTITY(1,1) NOT NULL,
	[ITCRID] [int] NOT NULL,
	[FollowupDt] [datetime] NULL,
	[FollowupToPerson] [int] NULL,
	[FollowupComments] [nvarchar](max) NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.CRFollowup] PRIMARY KEY CLUSTERED 
(
	[CRFollowupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_CRFollowup]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE View [IT].[vw_CRFollowup] as
SELECT [CRFollowupID]
      ,[ITCRID]
      ,[FollowupDt]
      ,[FollowupToPerson]
      ,[FollowupComments]
      ,[CreatedBy]
      ,[CreatedDt]
      ,[ModifiedBy]
      ,[ModifiedDt]
  FROM [IT].[CRFollowup]
GO
/****** Object:  View [IT].[vw_Barchart ]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [IT].[vw_Barchart ] AS
Select CR.CROwner, CR.ITCRID, CR.ClassifcationID, CR.CategoryID, CR.CategoryTypeID,CR.PlantID,CR.CRDate,
 
    COUNT(CASE WHEN CR.Status = 'Completed' THEN ITCRID END) AS CompletedIDNum,
    COUNT(CASE WHEN CR.Status != 'Completed' THEN ITCRID END) AS NonCompletedIDNum
	,MONTH(CR.CRDate) AS crmonth
    
FROM 
    IT.ChangeRequest CR
GROUP BY 
   CR.CRDate,CR.CROwner,CR.ITCRID, CR.ClassifcationID, CR.CategoryID, CR.CategoryTypeID,CR.PlantID
GO
/****** Object:  View [IT].[vw_ITSpareDetails]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [IT].[vw_ITSpareDetails] AS
	SELECT 
	   spare.ITSpareCode
	  ,spare.ITSpareID
      ,spare.Requesttype
      ,spare.RequestedBY
	  ,isNull(requestby.FirstName, '')+ ' ' + isNull(requestby.MiddleName, '') + ' ' + isNull(requestby.LastName, '') AS RequestedByName
      ,spare.RequestedFor
	  ,isNull(requestfor.FirstName, '')+ ' ' + isNull(requestfor.MiddleName, '') + ' ' + isNull(requestfor.LastName, '') AS  RequestedForName
      ,spare.SelectedFor
      ,spare.Guest_Id
      ,spare.Guest_Name
      ,spare.Guest_Email
      ,spare.Guest_RManagerId
	  ,isNull(grpmId.FirstName, '')+ ' ' + isNull(grpmId.MiddleName, '') + ' ' + isNull(grpmId.LastName, '') AS  Guest_RManagerName
      ,spare.Guest_ContactNo
	   ,spare.EmpType
      ,spare.Emp_Id
      ,spare.GxpReq
      ,spare.Asset_Type
      ,spare.Spare_Type
      ,spare.Spare_Model
      ,spare.Spare_SerialNo
      ,spare.Specs_Requirements
	  ,spare.Specification
      ,spare.Justification
      ,spare.HOD_Approval
	  ,spare.Status
	  ,spare.AssignedTo
	  ,isNull(assinTo.FirstName, '') + ' ' + isNull(assinTo.MiddleName, '')+ ' ' + isNull(assinTo.LastName, '') AS AssignedToName
	  ,spare.AssignedBy
	  ,isNull(assigBy.FirstName, '') + ' ' + isNull(assigBy.MiddleName, '')+ ' ' + isNull(assigBy.LastName, '') AS AssignedByName
	  ,spare.HOD_ApproverID
	  ,spare.HOD_ApprovedDt
	  ,spare.HOD_ApproverRemarks
	  ,spare.RPM_ApproverID
	  ,spare.RPM_ApprovedDt
	  ,spare.RPM_ApproverRemarks
	  ,spare.ResolRemarks
	  ,spare.UserRemarks
	  ,spare.ProposedResolDt
	  ,spare.ResolDt
	  ,spare.Description
	  ,supportData.SupportName
	  ,supportData.IsHODReq
	  ,supportData.IsRPMReq
	  ,spare.SupportID
	  ,hodEmp.EmployeeNo
	  ,rpm.Employee_ID as rpmEmpNO
	  ,hod.Employee_ID as hodEmpNo
	  --OnHoldReason
      ,onhold.OnholdReason
	  ,isNull(hodEmp.FirstName, '') + ' ' + isNull(hodEmp.LastName, '') + ' ' + '(' + cast(hodEmp.EmployeeNo as nvarchar) + ')' AS hodToName
	  ,hodEmp.OfficialEmailId As hodEmail
	  ,isNull(rpmEmp.FirstName, '') + ' ' + isNull(rpmEmp.LastName, '') + ' ' + '(' + cast(rpmEmp.EmployeeNo as nvarchar) + ')' AS rpmToName
	  ,rpmEmp.OfficialEmailId As rpmEmail
      ,spare.IsActive
	  ,isNull(CreatedBy.FirstName, '') + ' ' + isNull(CreatedBy.MiddleName, '')+ ' ' + isNull(CreatedBy.LastName, '') AS CreatedBy
	  ,spare.CreatedDt
	  ,isNull(modifyby.FirstName, '') + ' ' + isNull(modifyby.MiddleName, '')+ ' ' + isNull(modifyby.LastName, '') AS ModifiedBy
	  ,spare.ModifiedDt
	from IT.ITSpare AS spare
	LEFT JOIN HR.Employee CreatedBy ON CreatedBy.EmployeeNo = cast(spare.CreatedBy as nvarchar(100))
	LEFT JOIN HR.Employee modifyby ON modifyby.EmployeeNo = cast(spare.ModifiedBy as nvarchar(100))
	LEFT JOIN HR.Employee requestby ON requestby.EmployeeNo = cast(spare.RequestedBY as nvarchar(100))
	LEFT JOIN HR.Employee requestfor ON requestfor.EmployeeNo = cast(spare.RequestedFor as nvarchar(100))
	LEFT JOIN HR.Employee assinTo ON assinTo.EmployeeNo = cast(spare.AssignedTo as nvarchar(100))
	LEFT JOIN HR.Employee assigBy ON assigBy.EmployeeNo = cast(spare.AssignedBy as nvarchar(100))
	left join Employee_Master rpm on rpm.ID = requestfor.ReportingManagerId
	left join Employee_Master hod on hod.ID = requestfor.ApprovingManagerId
	LEFT JOIN it.Support supportData ON supportData.SupportID = spare.SupportID
	left join hr.Employee hodEmp on hodEmp.EmployeeNo = cast(hod.Employee_ID as nvarchar(100))
	left join hr.Employee rpmEmp on rpmEmp.EmployeeNo = cast(rpm.Employee_ID as nvarchar(100))
	--OnHoldReason
	LEFT JOIN [IT].[IssueOnholdCat] AS onhold ON onhold.IssueOnholdCatID = spare.OnHoldReason
	--GuestRManager
	LEFT JOIN HR.Employee grpmId ON grpmId.EmployeeNo = cast(spare.Guest_RManagerId as nvarchar(100))
GO
/****** Object:  Table [IT].[CRLesson]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[CRLesson](
	[CRLessonID] [int] IDENTITY(1,1) NOT NULL,
	[ITCRID] [int] NOT NULL,
	[Lessons] [nvarchar](max) NOT NULL,
	[Attachment] [nvarchar](max) NOT NULL,
	[LessonDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.CRLesson] PRIMARY KEY CLUSTERED 
(
	[CRLessonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [IT].[vw_CRLesson]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [IT].[vw_CRLesson] as
SELECT [CRLessonID]
      ,[ITCRID]
      ,[Lessons]
      ,[Attachment]
      ,[LessonDt]
      ,[CreatedBy]
      ,[CreatedDt]
      ,[ModifiedBy]
      ,[ModifiedDt]
  FROM [IT].[CRLesson]
GO
/****** Object:  View [IT].[vw_ChangeRequest ]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [IT].[vw_ChangeRequest ] as

select distinct CR.ITCRID, CR.CRCode,CR.SupportID,CR.CRREmailNotification,
	suppt.First_Name+' '+isNull(suppt.Middle_Name,'')+' '+suppt.Last_Name as CROwner,CR.CROwner as CROwnerid, CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID,
	Class.ClassificationName,CR.CRDate, CR.isSubmitted,CR.isApproved, CR.isReleased,CR.SysLandscapeID, CR.Stage,CR.[Status], CR.EstimatedCost, CR.EstimatedCostCurr, CR.EstimatedDateCompletion, CR.ApprovedBy
	,CR.PriorityType,Pro.PriorityName,cr.CROwner as ChangeRequestor,plant.Code PlantID,cr.PlantID as plantcode
	,Nature.NatureofChange,CatTyp.CategoryType,cr.CategoryTypeID, CR.CRInitiatedFor
	,isNull(supteam.First_Name,'')+' '+isNull(suppt.Middle_Name,'')+' '+isNull(suppt.Last_Name,'') as InitiatedFor
	,CR.isImplemented,cr.CRRequestedBy, crrplant.Code as RequestorPlant
	,isNull(crr.FirstName,'')+' '+isNull(crr.MiddleName,'')+' '+isNull(crr.LastName,'') as CRRequestorName,Crr.OfficialEmailId As CRREmail
	,CR.Attachment,CR.ReferenceID,CR.ReferenceTyp,CR.TriggeredBy,CR.AlternateConsidetation,CR.BackoutPlan,CR.Benefits,CR.GXPClassification,CR.GXPPlantID
	,CR.ImactedFunc,CR.ImpactedDept,CR.ImpactedLocation,CR.ImpactNotDoing,CR.BusinessImpact,CR.DownTimeFromDate,CR.DownTimeToDate,CR.DownTimeRequired
	,(select count(explan.ITCRExecID) from IT.CRExecutionPlan explan where explan.ITCRID=CR.ITCRID) taskcount
		,CR.ModifiedDt,CR.RollbackPlan
		from IT.ChangeRequest as CR
		inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
		inner join IT.Classification Class on Class.ITClassificationID=cr.ClassifcationID
		inner join IT.CategoryTyp CatTyp on CatTyp.CategoryTypeID = CR.CategoryTypeID
		inner join IT.SupportTeam suppt on suppt.EmpID=CR.CROwner
		inner Join IT.Priority Pro on Pro.PriorityID = CR.PriorityType
		inner join Plant_Master plant on plant.Id = CR.PlantID
		inner join IT.NatureofChange Nature on Nature.NatureofChangeID=cr.NatureOfChange
		INNER JOIN IT.SupportTeam supteam ON supteam.EmpID = CR.CROwner --OR supteam.SupportTeamID = CR.CROwner
		inner Join HR.Employee crr on crr.EmployeeNo = cast(CR.CRRequestedBy as varchar(20))
		inner join Plant_Master crrplant on crrplant.Id = crr.PlantId
GO
/****** Object:  View [IT].[vw_Assets]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [IT].[vw_Assets] As Select * from [MLLITAMS].[dbo].[NewITAssetDetails_Desktop] assets
GO
/****** Object:  View [IT].[vw_DepartmentMaster]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [IT].[vw_DepartmentMaster] as
select Id,Name,Description from Department_Master where IsActive=1
GO
/****** Object:  View [IT].[vw_EmployeeDetails]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [IT].[vw_EmployeeDetails] as
select
emp.EmployeeNo as Employee_ID,
(emp.FirstName+' '+isNull(emp.MiddleName,'')+' '+isNull(emp.LastName,'')) as EmployeeName,
emp.FirstName First_Name,emp.MiddleName Middle_Name,emp.LastName Last_Name,
emp.TelephoneNo, emp.MobileNo, emp.OfficialEmailId,dept.Name Department,

emp.DesignationId,
(select des.Name from dbo.Designation_Master des where des.id = emp.Designationid) as Designation,
emp.DateOfLeaving,emp.DateOfBirth,emp.ReportingManagerId ReportingManagerId,
(rptmgr.First_Name+' '+isNull(rptmgr.Middle_Name,'')+' '+isNull(rptmgr.Last_Name,'')) as ReportManagerName,

(select paygroup.Long_Desc from dbo.Paygroup_Master paygroup where paygroup.id = emp.PaygroupId) as PayGroup,
(select rolemaster.Role_ltxt from dbo.Role_Master rolemaster where rolemaster.id = emp.RoleId) as Role,
(select catmaster.CATLTXT from dbo.emp_category_master catmaster where catmaster.id = emp.RoleId)as StaffCategory,
(select plantcode.Code from dbo.Plant_Master plantcode where plantcode.Id= emp.PlantId) as Plantcode
--(select empaddress.PhoneNumber from Employee_Address empaddress where empaddress.FK_Emp_ID = emp.EmployeeNo) as  contactNumber
from HR.Employee emp
left join Employee_Master rptmgr on rptmgr.id=emp.ReportingManagerId 
left join Employee_Address empaddress on empaddress.ID=rptmgr.FK_Address_ID
inner join Department_Master dept on dept.Id=emp.DepartmentId
where emp.Active=1
GO
/****** Object:  View [IT].[vw_EmployeeMaster]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE View [IT].[vw_EmployeeMaster] as
select emp.Employee_ID, empaddress.PhoneNumber, emp.Email,emp.First_Name,emp.Middle_Name,emp.Last_Name,(emp.First_Name+' '+isNull(emp.Middle_Name,'')+' '+isNull(emp.Last_Name,'')) as EmployeeName,emp.Img_Url,
emp.Designation,emp.DOL,emp.DOB,emp.FK_Reporting_Manager ReportingManagerId,
(rptmgr.First_Name+' '+isNull(rptmgr.Middle_Name,'')+' '+isNull(rptmgr.Last_Name,'')) as ReportManagerName,
dept.Name Department,
(select paygroup.Long_Desc from dbo.Paygroup_Master paygroup where paygroup.id = emp.FK_Payroll) as PayGroup,
(select rolemaster.Role_ltxt from dbo.Role_Master rolemaster where rolemaster.id = emp.FK_Role_ID) as Role,
(select catmaster.CATLTXT from dbo.emp_category_master catmaster where catmaster.id = emp.FK_Role_ID)as StaffCategory,
(select plantcode.Code from dbo.Plant_Master plantcode where plantcode.Id= emp.Base_Location) as Plantcode
--,(select empaddress.PhoneNumber from Employee_Address empaddress where empaddress.FK_Emp_ID = emp.Employee_ID) as  contactNumber
from [MicroLabs_Dev].[dbo].Employee_Master emp
left join Employee_Master rptmgr on rptmgr.id=emp.FK_Reporting_Manager 
left join Employee_Address empaddress on empaddress.ID=emp.FK_Address_ID
inner join Department_Master dept on dept.Id=emp.FK_Department
where emp.IsActive=1
GO
/****** Object:  View [IT].[vw_GetSRApprover]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [IT].[vw_GetSRApprover] AS
SELECT  hr.EmployeeNo,
		hr.ReportingManagerId,
		hr.ApprovingManagerId,
		emp.Employee_ID as rpmEmpId,
		hod.Employee_ID as hodEmpId,
		isNULL(emp.First_Name,'')+' '+isNULL(emp.Middle_Name,'')+' '+isNULL(emp.Last_Name,'') as ReportingManagerName,
		emp.Email as ReportingManager_Email,
		isNULL(hod.First_Name,'')+' '+isNULL(hod.Middle_Name,'')+' '+isNULL(hod.Last_Name,'') as HODName,
		hod.Email as HOD_Email
		from HR.Employee hr
		
		left join Employee_Master emp on emp.ID = hr.ReportingManagerId
		left join Employee_Master hod on hod.ID = hr.ApprovingManagerId
GO
/****** Object:  View [IT].[vw_Unnati(EmployeeMaster)]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE View [IT].[vw_Unnati(EmployeeMaster)] as
select emp.Employee_ID, empaddress.PhoneNumber, emp.Email,emp.First_Name,emp.Middle_Name,emp.Last_Name,(emp.First_Name+' '+isNull(emp.Middle_Name,'')+' '+isNull(emp.Last_Name,'')) as EmployeeName,emp.Img_Url,
emp.Designation,emp.DOL,emp.DOB,emp.FK_Reporting_Manager ReportingManagerId,
(rptmgr.First_Name+' '+isNull(rptmgr.Middle_Name,'')+' '+isNull(rptmgr.Last_Name,'')) as ReportManagerName,
dept.Name Department,
(select paygroup.Long_Desc from dbo.Paygroup_Master paygroup where paygroup.id = emp.FK_Payroll) as PayGroup,
(select rolemaster.Role_ltxt from dbo.Role_Master rolemaster where rolemaster.id = emp.FK_Role_ID) as Role,
(select catmaster.CATLTXT from dbo.emp_category_master catmaster where catmaster.id = emp.FK_Role_ID)as StaffCategory,
(select plantcode.Code from dbo.Plant_Master plantcode where plantcode.Id= emp.Base_Location) as Plantcode
--,(select empaddress.PhoneNumber from Employee_Address empaddress where empaddress.FK_Emp_ID = emp.Employee_ID) as  contactNumber
from Employee_Master emp
left join Employee_Master rptmgr on rptmgr.id=emp.FK_Reporting_Manager 
left join Employee_Address empaddress on empaddress.ID=emp.FK_Address_ID
inner join Department_Master dept on dept.Id=emp.FK_Department
where emp.IsActive=1
GO
/****** Object:  Table [IT].[ASResolution]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ASResolution](
	[ASResolID] [int] IDENTITY(1,1) NOT NULL,
	[AssetID] [int] NOT NULL,
	[ITSpareID] [int] NOT NULL,
	[ResolRemarks] [nvarchar](max) NULL,
	[UserRemarks] [nvarchar](200) NULL,
	[ProposedResolDt] [datetime] NULL,
	[ResolDt] [datetime] NULL,
	[Description] [nvarchar](200) NULL,
	[OnHoldReason] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[AttachFile]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[AttachFile](
	[AttachID] [int] IDENTITY(1,1) NOT NULL,
	[ITCRID] [int] NULL,
	[FileName] [nvarchar](500) NULL,
	[Stage] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_AttachFile] PRIMARY KEY CLUSTERED 
(
	[AttachID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[CRApproverHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[CRApproverHistory](
	[ITCRApproverHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[CRHistoryDt] [datetime] NULL,
	[ITCRApproverID] [int] NULL,
	[PlantID] [int] NOT NULL,
	[SupportID] [int] NOT NULL,
	[CRID] [int] NOT NULL,
	[ApproverLevel] [int] NULL,
	[Comments] [varchar](2000) NULL,
	[Stage] [varchar](150) NULL,
	[ApproverID] [int] NULL,
	[ApprovedDt] [datetime] NOT NULL,
	[Remarks] [varchar](2000) NULL,
	[Status] [varchar](150) NOT NULL,
	[Attachment] [varchar](2000) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_ITCRApproverHistoryID] PRIMARY KEY CLUSTERED 
(
	[ITCRApproverHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[CRExecutionPlanHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[CRExecutionPlanHistory](
	[ITCRExecHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[CRHistoryDt] [datetime] NULL,
	[ITCRExecID] [int] NULL,
	[ITCRID] [int] NULL,
	[SysLandscape] [int] NULL,
	[ExecutionStepName] [nvarchar](500) NULL,
	[ExecutionStepDesc] [nvarchar](2000) NULL,
	[AssignedTo] [int] NULL,
	[StartDt] [datetime] NULL,
	[EndDT] [datetime] NULL,
	[Attachments] [nvarchar](500) NULL,
	[Status] [nvarchar](50) NULL,
	[ForwardStatus] [nvarchar](50) NULL,
	[ForwardedTo] [int] NULL,
	[ForwardedDt] [datetime] NULL,
	[ReasonForwarded] [nvarchar](500) NULL,
	[Remarks] [nvarchar](2000) NULL,
	[PickedStatus] [nvarchar](50) NULL,
	[PickedDt] [datetime] NULL,
	[ActualStartDt] [datetime] NULL,
	[ActualEndDt] [datetime] NULL,
	[DependSysLandscape] [int] NULL,
	[DependTaskID] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.CRExecutionPlanHistory] PRIMARY KEY CLUSTERED 
(
	[ITCRExecHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[issueCommentsBox]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[issueCommentsBox](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[issueId] [int] NULL,
	[textChat] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[IssueSLA]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[IssueSLA](
	[IssueSLAID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[IssueID] [int] NULL,
	[EscalationID] [int] NULL,
	[EscalationDt] [datetime] NULL,
	[Remarks] [nvarchar](2000) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_IT.[IssueSLA] PRIMARY KEY CLUSTERED 
(
	[IssueSLAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[ITSpareHistory]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ITSpareHistory](
	[ITSpareHID] [int] IDENTITY(1,1) NOT NULL,
	[ITSpareID] [int] NULL,
	[ITSpareCode] [nvarchar](200) NULL,
	[SupportID] [int] NULL,
	[Requesttype] [nvarchar](500) NULL,
	[RequestedBY] [int] NULL,
	[RequestedFor] [int] NULL,
	[SelectedFor] [nvarchar](500) NULL,
	[Guest_Id] [int] NULL,
	[Guest_Name] [nvarchar](500) NULL,
	[Guest_Email] [nvarchar](500) NULL,
	[Guest_RManagerId] [int] NULL,
	[Guest_ContactNo] [int] NULL,
	[EmpType] [nvarchar](200) NULL,
	[Emp_Id] [int] NULL,
	[GxpReq] [nvarchar](200) NULL,
	[Asset_Type] [nvarchar](300) NULL,
	[Spare_Type] [nvarchar](500) NULL,
	[Spare_Model] [nvarchar](500) NULL,
	[Spare_SerialNo] [nvarchar](500) NULL,
	[Specs_Requirements] [nvarchar](500) NULL,
	[Specification] [nvarchar](max) NULL,
	[Justification] [nvarchar](200) NULL,
	[HOD_Approval] [nvarchar](500) NULL,
	[IsActive] [bit] NULL,
	[HOD_ApproverID] [int] NULL,
	[HOD_ApprovedDt] [datetime] NULL,
	[HOD_ApproverRemarks] [nvarchar](max) NULL,
	[RPM_ApproverID] [int] NULL,
	[RPM_ApprovedDt] [datetime] NULL,
	[RPM_ApproverRemarks] [nvarchar](max) NULL,
	[ResolRemarks] [nvarchar](max) NULL,
	[UserRemarks] [nvarchar](200) NULL,
	[ProposedResolDt] [datetime] NULL,
	[ResolDt] [datetime] NULL,
	[Description] [nvarchar](200) NULL,
	[OnHoldReason] [int] NULL,
	[Status] [nvarchar](200) NULL,
	[AssignedBy] [int] NULL,
	[AssignedTo] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[ProjectMgmt]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ProjectMgmt](
	[ProjectMgmtID] [int] IDENTITY(1,1) NOT NULL,
	[SupportID] [int] NULL,
	[ProjectName] [varchar](500) NULL,
	[ProjectDesc] [varchar](2000) NULL,
	[ProjectOwner] [int] NULL,
	[StartDt] [datetime] NULL,
	[EndDt] [datetime] NULL,
	[ActualStartDt] [datetime] NULL,
	[ActualEndDt] [datetime] NULL,
	[isStrict] [bit] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.ProjectMgmt] PRIMARY KEY CLUSTERED 
(
	[ProjectMgmtID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[ProjMember]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ProjMember](
	[ProjMemberID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectMgmtID] [int] NOT NULL,
	[EmpID] [int] NULL,
	[StartDt] [datetime] NULL,
	[EndDt] [datetime] NULL,
	[isResponsible] [bit] NULL,
	[isAccountable] [bit] NULL,
	[isConsulted] [bit] NULL,
	[isInformed] [bit] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.ProjMember] PRIMARY KEY CLUSTERED 
(
	[ProjMemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[ProjMilestone]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ProjMilestone](
	[ProjMilestoneID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectMgmtID] [int] NOT NULL,
	[MilestoneTitle] [nvarchar](500) NULL,
	[MilestoneDesc] [nvarchar](2000) NULL,
	[StartDt] [datetime] NULL,
	[EndDt] [datetime] NULL,
	[ActualStartDt] [datetime] NULL,
	[ActualEndDt] [datetime] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.ProjMilestone] PRIMARY KEY CLUSTERED 
(
	[ProjMilestoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[ProjTask]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[ProjTask](
	[ProjTaskID] [int] IDENTITY(1,1) NOT NULL,
	[ProjMilestoneID] [int] NOT NULL,
	[ProjectMgmtID] [int] NOT NULL,
	[EmpID] [int] NOT NULL,
	[TaskTitle] [nvarchar](500) NULL,
	[TaskDesc] [nvarchar](2000) NULL,
	[StartDt] [datetime] NULL,
	[EndDt] [datetime] NULL,
	[ActualStartDt] [datetime] NULL,
	[ActualEndDt] [datetime] NULL,
	[IsActive] [bit] NULL,
	[Attachment] [nvarchar](500) NULL,
	[MainProjTaskID] [int] NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT.ProjTask] PRIMARY KEY CLUSTERED 
(
	[ProjTaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[RiskPlan]    Script Date: 2024-11-29 10:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[RiskPlan](
	[ITRiskID] [int] IDENTITY(1,1) NOT NULL,
	[PlantID] [int] NULL,
	[SupportID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[TestPlan] [nvarchar](2000) NULL,
	[TestPlanAttachment] [varchar](max) NULL,
	[CommunicationPlan] [nvarchar](2000) NULL,
	[CommunicationPlanAttachment] [varchar](max) NULL,
	[CommunicationDays] [nchar](10) NULL,
 CONSTRAINT [PK_RiskPlan] PRIMARY KEY CLUSTERED 
(
	[ITRiskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SERVICE_MASTER]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SERVICE_MASTER](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[request_no] [nvarchar](20) NULL,
	[plant_code] [nvarchar](5) NULL,
	[storage_location] [nvarchar](500) NULL,
	[service_description] [nvarchar](max) NULL,
	[detailed_desc] [nvarchar](500) NULL,
	[SAC_Code] [nvarchar](50) NULL,
	[uom] [nvarchar](500) NULL,
	[purchase_group] [nvarchar](500) NULL,
	[service_catagory] [nvarchar](500) NULL,
	[service_group] [nvarchar](500) NULL,
	[machine_name] [nvarchar](500) NULL,
	[app_value] [nvarchar](500) NULL,
	[where_used] [nvarchar](500) NULL,
	[purpose] [nvarchar](500) NULL,
	[justification] [nvarchar](max) NULL,
	[valuation_class] [nvarchar](500) NULL,
	[attachment] [nvarchar](500) NULL,
	[app_satus] [nvarchar](500) NULL,
	[request_date] [datetime] NULL,
	[requested_by] [nvarchar](500) NULL,
	[approve_date] [datetime] NULL,
	[SAP_CODE_NO] [nvarchar](100) NULL,
	[SAP_CODE_EXISTS] [nvarchar](50) NULL,
	[SAP_CREATION_DATE] [datetime] NULL,
	[SAP_CREATED_BY] [int] NULL,
	[CREATED_DATE] [datetime] NULL,
	[CREATED_BY] [int] NULL,
	[last_approver] [nvarchar](100) NULL,
	[pending_approver] [nvarchar](100) NULL,
	[rejected_flag] [nvarchar](50) NULL,
	[MODIFIED_DATE] [datetime] NULL,
	[MODIFIED_BY] [nvarchar](50) NULL,
	[Sr_Module_ID] [int] NULL,
	[Sr_number] [varchar](200) NULL,
	[Approved_By] [int] NULL,
	[Approved_On] [date] NULL,
	[Approval_Reamarks] [varchar](max) NULL,
	[Approval_Status] [varchar](200) NULL,
	[Resolution_By] [int] NULL,
	[Resolution_On] [date] NULL,
	[Resolution_Reamarks] [varchar](max) NULL,
	[Resolution_Status] [varchar](200) NULL,
 CONSTRAINT [PK_SERVICE_MASTER] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRAccess](
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](100) NULL,
	[SRAccessID] [int] IDENTITY(1,1) NOT NULL,
	[SoftName] [nvarchar](200) NULL,
	[SoftVersion] [nvarchar](max) NULL,
	[ReferDocument] [nvarchar](max) NULL,
	[DORemovalAccess] [datetime] NULL,
	[SWRemoved] [bit] NULL,
	[ServerAccess] [bit] NULL,
	[KindAccess] [nvarchar](100) NULL,
	[DowntimeRequired] [nvarchar](100) NULL,
	[TypeServerAccess] [nvarchar](100) NULL,
	[IPDetails] [nvarchar](max) NULL,
	[VenderName] [nvarchar](200) NULL,
	[VenderFocalName] [nvarchar](200) NULL,
	[VenderFocalEmailID] [nvarchar](200) NULL,
	[AccessStartTime] [datetime] NULL,
	[AccessEndTime] [datetime] NULL,
	[Justification] [nvarchar](max) NULL,
	[ReferenceDocument] [nvarchar](max) NULL,
	[DORemoteAccess] [datetime] NULL,
	[Attachment] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRAccess] PRIMARY KEY CLUSTERED 
(
	[SRAccessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRAccessHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRAccessHistory](
	[SRAHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](100) NULL,
	[SRAccessID] [int] NULL,
	[SoftName] [nvarchar](200) NULL,
	[SoftVersion] [nvarchar](max) NULL,
	[ReferDocument] [nvarchar](max) NULL,
	[DORemovalAccess] [datetime] NULL,
	[SWRemoved] [bit] NULL,
	[ServerAccess] [bit] NULL,
	[KindAccess] [nvarchar](100) NULL,
	[DowntimeRequired] [nvarchar](100) NULL,
	[TypeServerAccess] [nvarchar](100) NULL,
	[IPDetails] [nvarchar](max) NULL,
	[VenderName] [nvarchar](200) NULL,
	[VenderFocalName] [nvarchar](200) NULL,
	[VenderFocalEmailID] [nvarchar](200) NULL,
	[AccessStartTime] [datetime] NULL,
	[AccessEndTime] [datetime] NULL,
	[Justification] [nvarchar](max) NULL,
	[ReferenceDocument] [nvarchar](max) NULL,
	[DORemoteAccess] [datetime] NULL,
	[Attachment] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRAccessHistory] PRIMARY KEY CLUSTERED 
(
	[SRAHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRAntivirus]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRAntivirus](
	[SRAVID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NOT NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](200) NULL,
	[InstallDts] [nvarchar](200) NULL,
	[UninstallDts] [nvarchar](200) NULL,
	[ExcDts] [nvarchar](200) NULL,
	[IncDts] [nvarchar](200) NULL,
	[Attachment] [nvarchar](max) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRAntivirus] PRIMARY KEY CLUSTERED 
(
	[SRAVID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRAntivirusHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRAntivirusHistory](
	[SRAVHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[SRAVID] [int] NULL,
	[SRID] [int] NOT NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](200) NULL,
	[InstallDts] [nvarchar](200) NULL,
	[UninstallDts] [nvarchar](200) NULL,
	[ExcDts] [nvarchar](200) NULL,
	[IncDts] [nvarchar](200) NULL,
	[Attachment] [nvarchar](max) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRCitrixAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRCitrixAccess](
	[SRID] [int] NULL,
	[SRCID] [int] IDENTITY(1,1) NOT NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](100) NULL,
	[ADID] [int] NULL,
	[ReplaceADID] [int] NULL,
	[AssetDetails] [nvarchar](max) NULL,
	[IPAddress] [nvarchar](200) NULL,
	[HostName] [nvarchar](200) NULL,
	[SoftwareRequired] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](200) NULL,
	[OUPath] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRCitrixAccess] PRIMARY KEY CLUSTERED 
(
	[SRCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRCitrixAccessHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRCitrixAccessHistory](
	[SRCAHID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SRCID] [int] NOT NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](100) NULL,
	[ADID] [int] NULL,
	[ReplaceADID] [int] NULL,
	[AssetDetails] [nvarchar](max) NULL,
	[IPAddress] [nvarchar](200) NULL,
	[HostName] [nvarchar](200) NULL,
	[SoftwareRequired] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](200) NULL,
	[OUPath] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_SRCitrixAccessHistory] PRIMARY KEY CLUSTERED 
(
	[SRCAHID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRDomainHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRDomainHistory](
	[SRDHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[SRDomainID] [int] NULL,
	[Support] [int] NULL,
	[SRID] [int] NULL,
	[DomainName] [nvarchar](max) NULL,
	[Plant] [varchar](200) NULL,
	[Department] [nvarchar](200) NULL,
	[NoofUser] [int] NULL,
	[PurPoseDomain] [nvarchar](200) NULL,
	[DueDate] [datetime] NULL,
	[TypeofSSL] [nvarchar](250) NULL,
	[RenewalPeriod] [int] NOT NULL,
	[Justification] [nvarchar](250) NULL,
	[DiscontinuationDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[ModifyBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRDomainHistory] PRIMARY KEY CLUSTERED 
(
	[SRDHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SREmail]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SREmail](
	[SREmailID] [int] IDENTITY(1,1) NOT NULL,
	[SupportID] [int] NOT NULL,
	[SRID] [int] NOT NULL,
	[Requesttype] [nvarchar](200) NULL,
	[EmpID] [int] NULL,
	[EmpCategory] [nvarchar](200) NULL,
	[EmpName] [nvarchar](200) NULL,
	[Designation] [nvarchar](200) NULL,
	[Department] [nvarchar](200) NULL,
	[Location] [int] NULL,
	[Intercom] [int] NULL,
	[MoblieNo] [nvarchar](50) NULL,
	[ReportManager] [nvarchar](200) NULL,
	[HOD] [nvarchar](200) NULL,
	[CommonEmailID] [nvarchar](200) NULL,
	[PreEmailID] [nvarchar](200) NULL,
	[OutsideComm] [nvarchar](20) NULL,
	[MailAccess] [nvarchar](50) NULL,
	[MailGroup] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](200) NULL,
	[Description] [nvarchar](500) NULL,
	[EmpType] [nvarchar](200) NULL,
	[GB] [nvarchar](20) NULL,
	[MemberAdded] [varchar](max) NULL,
	[GroupName] [varchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SREmail] PRIMARY KEY CLUSTERED 
(
	[SREmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SREmailHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SREmailHistory](
	[SREHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[SREmailID] [int] NULL,
	[SupportID] [int] NOT NULL,
	[SRID] [int] NOT NULL,
	[Requesttype] [nvarchar](200) NULL,
	[EmpID] [int] NULL,
	[EmpCategory] [nvarchar](200) NULL,
	[EmpName] [nvarchar](200) NULL,
	[Designation] [nvarchar](200) NULL,
	[Department] [nvarchar](200) NULL,
	[Location] [int] NULL,
	[Intercom] [int] NULL,
	[MoblieNo] [nvarchar](50) NULL,
	[ReportManager] [nvarchar](200) NULL,
	[HOD] [nvarchar](200) NULL,
	[CommonEmailID] [nvarchar](200) NULL,
	[PreEmailID] [nvarchar](200) NULL,
	[OutsideComm] [nvarchar](20) NULL,
	[MailAccess] [nvarchar](50) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](200) NULL,
	[Description] [nvarchar](500) NULL,
	[EmpType] [nvarchar](200) NULL,
	[GB] [nvarchar](20) NULL,
	[MemberAdded] [nvarchar](1) NULL,
	[GroupName] [nvarchar](1) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SREmailHistory] PRIMARY KEY CLUSTERED 
(
	[SREHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRExternalDrive]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRExternalDrive](
	[SREDID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[ReqType] [nvarchar](200) NULL,
	[ForSelf] [nvarchar](200) NULL,
	[Name] [nvarchar](200) NULL,
	[Designation] [nvarchar](200) NULL,
	[EmpCategory] [nvarchar](200) NULL,
	[Role] [nvarchar](200) NULL,
	[Department] [nvarchar](200) NULL,
	[SubDepartment] [nvarchar](200) NULL,
	[PlantId] [int] NULL,
	[ReportingManager] [nvarchar](200) NULL,
	[HOD] [nvarchar](200) NULL,
	[AccessPath] [nvarchar](200) NULL,
	[AccessType] [nvarchar](200) NULL,
	[AccessRequired] [nvarchar](200) NULL,
	[OnwerEmail] [nvarchar](200) NULL,
	[OnwerPlant] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](500) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [date] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [date] NULL,
 CONSTRAINT [PK_IT_SRExternalDriveAccess] PRIMARY KEY CLUSTERED 
(
	[SREDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRExternalDriveHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRExternalDriveHistory](
	[SREDHID] [int] IDENTITY(1,1) NOT NULL,
	[SREDID] [int] NOT NULL,
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[ReqType] [nvarchar](200) NULL,
	[ForSelf] [nvarchar](200) NULL,
	[Name] [nvarchar](200) NULL,
	[Designation] [nvarchar](200) NULL,
	[EmpCategory] [nvarchar](200) NULL,
	[Role] [nvarchar](200) NULL,
	[Department] [nvarchar](200) NULL,
	[SubDepartment] [nvarchar](200) NULL,
	[PlantId] [int] NULL,
	[ReportingManager] [nvarchar](200) NULL,
	[HOD] [nvarchar](200) NULL,
	[AccessPath] [nvarchar](200) NULL,
	[AccessType] [nvarchar](200) NULL,
	[AccessRequired] [nvarchar](200) NULL,
	[OnwerEmail] [nvarchar](200) NULL,
	[OnwerPlant] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](500) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [date] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [date] NULL,
 CONSTRAINT [PK_SRExternalDriveHistory] PRIMARY KEY CLUSTERED 
(
	[SREDHID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRFTPAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRFTPAccess](
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SRFTPAID] [int] IDENTITY(1,1) NOT NULL,
	[ReqType] [nvarchar](200) NULL,
	[AccessRequire] [nvarchar](200) NULL,
	[AccessType] [nvarchar](max) NULL,
	[AccessPath] [nvarchar](200) NULL,
	[Description] [nvarchar](200) NULL,
	[OwnerEmail] [nvarchar](200) NULL,
	[OwnerPlant] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRFTPAccess] PRIMARY KEY CLUSTERED 
(
	[SRFTPAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRFTPAccessHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRFTPAccessHistory](
	[SRFTPHID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SRFTPAID] [int] NULL,
	[ReqType] [nvarchar](200) NULL,
	[AccessRequire] [int] NULL,
	[AccessType] [nvarchar](max) NULL,
	[AccessPath] [nvarchar](200) NULL,
	[Description] [nvarchar](200) NULL,
	[OwnerEmail] [nvarchar](200) NULL,
	[OwnerPlant] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRResolutionHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRResolutionHistory](
	[SRResolHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NOT NULL,
	[ResolRemarks] [nvarchar](max) NULL,
	[UserRemarks] [nvarchar](200) NULL,
	[ProposedResolDt] [datetime] NULL,
	[ResolDt] [datetime] NULL,
	[Description] [nvarchar](200) NULL,
	[OnHoldReason] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRResolutionHistory] PRIMARY KEY CLUSTERED 
(
	[SRResolHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRRestorationAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRRestorationAccess](
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SRRID] [int] IDENTITY(1,1) NOT NULL,
	[RequestType] [nvarchar](100) NULL,
	[OTS] [nvarchar](200) NULL,
	[Descriptions] [nvarchar](200) NULL,
	[Date] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[ProvideDescription] [nvarchar](200) NULL,
	[TransferingData] [nvarchar](max) NULL,
	[Restoration] [datetime] NULL,
	[Attachment] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRRestorationAccess] PRIMARY KEY CLUSTERED 
(
	[SRRID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRRestorationAccessHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRRestorationAccessHistory](
	[SRRAHID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SRRID] [int] NULL,
	[RequestType] [nvarchar](100) NULL,
	[OTS] [nvarchar](200) NULL,
	[Descriptions] [nvarchar](200) NULL,
	[StartDate] [datetime] NULL,
	[Date] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[ProvideDescription] [nvarchar](200) NULL,
	[TransferingData] [nvarchar](max) NULL,
	[Restoration] [datetime] NULL,
	[Attachment] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRServerAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRServerAccess](
	[SRID] [int] NULL,
	[SRServerID] [int] IDENTITY(1,1) NOT NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](100) NULL,
	[IPAddress] [nvarchar](200) NULL,
	[HostName] [nvarchar](200) NULL,
	[FileServerName] [nvarchar](200) NULL,
	[FolderPath] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](200) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRServerAccess] PRIMARY KEY CLUSTERED 
(
	[SRServerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRServerAccessHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRServerAccessHistory](
	[SRSAHID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SRServerID] [int] NOT NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](100) NULL,
	[IPAddress] [nvarchar](200) NULL,
	[HostName] [nvarchar](200) NULL,
	[FileServerName] [nvarchar](200) NULL,
	[FolderPath] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](200) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRURLAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRURLAccess](
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SRURLID] [int] IDENTITY(1,1) NOT NULL,
	[RequestType] [nvarchar](200) NULL,
	[HostName] [nvarchar](200) NULL,
	[IPAddress] [nvarchar](200) NULL,
	[URLRequired] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](200) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRURLAccess] PRIMARY KEY CLUSTERED 
(
	[SRURLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRURLAccessHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRURLAccessHistory](
	[SRURLHID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SRURLID] [int] NOT NULL,
	[RequestType] [nvarchar](200) NULL,
	[HostName] [nvarchar](200) NULL,
	[IPAddress] [nvarchar](200) NULL,
	[URLRequired] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](200) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRUSBAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRUSBAccess](
	[SRID] [int] NULL,
	[SRUSBAID] [int] IDENTITY(1,1) NOT NULL,
	[SupportID] [int] NULL,
	[ADID] [int] NULL,
	[AssetDetails] [nvarchar](200) NULL,
	[HostName] [nvarchar](200) NULL,
	[DeviceType] [nvarchar](200) NULL,
	[DurationFrom] [datetime] NULL,
	[DurationTo] [datetime] NULL,
	[AccessType] [nvarchar](200) NULL,
	[IPAddress] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRUSBAccess] PRIMARY KEY CLUSTERED 
(
	[SRUSBAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRUSBAccessHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRUSBAccessHistory](
	[SRUSBHID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SRUSBAID] [int] NOT NULL,
	[SupportID] [int] NULL,
	[ADID] [int] NULL,
	[AssetDetails] [nvarchar](200) NULL,
	[HostName] [nvarchar](200) NULL,
	[DeviceType] [nvarchar](200) NULL,
	[DurationFrom] [datetime] NULL,
	[DurationTo] [datetime] NULL,
	[AccessType] [nvarchar](200) NULL,
	[IPAddress] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRVirtual]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRVirtual](
	[SRVMID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NOT NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](200) NULL,
	[EmailID] [nvarchar](200) NULL,
	[NoParticipants] [nvarchar](200) NULL,
	[StartDt] [datetime] NULL,
	[EndDt] [datetime] NULL,
	[Location] [int] NULL,
	[Department] [nvarchar](200) NULL,
	[Justification] [nvarchar](200) NULL,
	[Attachment] [nvarchar](max) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRVirtual] PRIMARY KEY CLUSTERED 
(
	[SRVMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRVirtualHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRVirtualHistory](
	[SRVHID] [int] IDENTITY(1,1) NOT NULL,
	[SRVMID] [int] NULL,
	[SRID] [int] NOT NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](200) NULL,
	[EmailID] [nvarchar](200) NULL,
	[NoParticipants] [nvarchar](200) NULL,
	[StartDt] [datetime] NULL,
	[EndDt] [datetime] NULL,
	[Location] [int] NULL,
	[Department] [nvarchar](200) NULL,
	[Justification] [nvarchar](200) NULL,
	[Attachment] [nvarchar](max) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRVPNAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRVPNAccess](
	[SRID] [int] NULL,
	[SRVPNID] [int] IDENTITY(1,1) NOT NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](200) NULL,
	[EmpPlant] [nvarchar](200) NULL,
	[AccessPermission] [nvarchar](200) NULL,
	[AccessList] [nvarchar](200) NULL,
	[AccessType] [nvarchar](200) NULL,
	[AccessFromDt] [datetime] NULL,
	[AccessToDt] [datetime] NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](200) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRVPNAccess] PRIMARY KEY CLUSTERED 
(
	[SRVPNID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRVPNAccessHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRVPNAccessHistory](
	[SRVPNHID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SRVPNID] [int] NULL,
	[SupportID] [int] NULL,
	[RequestType] [nvarchar](200) NULL,
	[EmpPlant] [nvarchar](200) NULL,
	[AccessPermission] [nvarchar](200) NULL,
	[AccessList] [nvarchar](200) NULL,
	[AccessType] [nvarchar](200) NULL,
	[AccessFromDt] [datetime] NULL,
	[AccessToDt] [datetime] NULL,
	[EmpType] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Attachment] [nvarchar](200) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRWIFIAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRWIFIAccess](
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SRWIFIID] [int] IDENTITY(1,1) NOT NULL,
	[RequestType] [nvarchar](200) NULL,
	[SpecifyPlant] [nvarchar](200) NULL,
	[Location] [nvarchar](200) NULL,
	[SpecifyOffice] [nvarchar](200) NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[Attachment] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Description] [nvarchar](200) NULL,
	[ISActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
 CONSTRAINT [PK_IT_SRWIFIAccess] PRIMARY KEY CLUSTERED 
(
	[SRWIFIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRWIFIAccessHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRWIFIAccessHistory](
	[SRWHID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SRWIFIID] [int] NULL,
	[RequestType] [nvarchar](200) NULL,
	[SpecifyPlant] [nvarchar](200) NULL,
	[Location] [nvarchar](200) NULL,
	[SpecifyOffice] [nvarchar](200) NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[Attachment] [nvarchar](200) NULL,
	[Justification] [nvarchar](max) NULL,
	[Description] [nvarchar](200) NULL,
	[ISActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRWindowLogin]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRWindowLogin](
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SRWLID] [int] IDENTITY(1,1) NOT NULL,
	[RequestType] [nvarchar](100) NULL,
	[EmpID] [int] NULL,
	[Date] [datetime] NULL,
	[Initials] [nvarchar](200) NULL,
	[FirstName] [nvarchar](200) NULL,
	[LastName] [nvarchar](200) NULL,
	[Designation] [nvarchar](max) NULL,
	[PlantID] [int] NULL,
	[PayGroup] [nvarchar](200) NULL,
	[StaffCategory] [nvarchar](200) NULL,
	[Department] [nvarchar](200) NULL,
	[ReportingTO] [nvarchar](200) NULL,
	[HOD] [nvarchar](200) NULL,
	[Role] [nvarchar](200) NULL,
	[UserType] [nvarchar](200) NULL,
	[ChangeOUPath] [nvarchar](200) NULL,
	[Justification] [nvarchar](200) NULL,
	[EIDIndividual] [datetime] NULL,
	[UserID] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Attachment] [nvarchar](200) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_IT_SRWindowLogin] PRIMARY KEY CLUSTERED 
(
	[SRWLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[SRWindowLoginHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[SRWindowLoginHistory](
	[SRWLHID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [int] NULL,
	[SupportID] [int] NULL,
	[SRWLID] [int] NULL,
	[RequestType] [nvarchar](100) NULL,
	[EmpID] [int] NULL,
	[Date] [datetime] NULL,
	[Initials] [nvarchar](200) NULL,
	[FirstName] [nvarchar](200) NULL,
	[LastName] [nvarchar](200) NULL,
	[Designation] [nvarchar](max) NULL,
	[PlantID] [int] NULL,
	[PayGroup] [nvarchar](200) NULL,
	[StaffCategory] [nvarchar](200) NULL,
	[Department] [nvarchar](200) NULL,
	[ReportingTO] [nvarchar](200) NULL,
	[HOD] [nvarchar](200) NULL,
	[Role] [nvarchar](200) NULL,
	[UserType] [nvarchar](200) NULL,
	[ChangeOUPath] [nvarchar](200) NULL,
	[Justification] [nvarchar](200) NULL,
	[EIDIndividual] [datetime] NULL,
	[UserID] [nvarchar](200) NULL,
	[EmpType] [nvarchar](200) NULL,
	[Attachment] [nvarchar](200) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IT].[UserVal]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[UserVal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[empNum] [int] NULL,
	[valCode] [nvarchar](max) NULL,
	[isActive] [bit] NULL,
	[securityCode] [varchar](50) NULL,
 CONSTRAINT [PK_UserVal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [IT].[AttachFile] ADD  CONSTRAINT [DF_AttachFile_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [IT].[ChangeRequest] ADD  CONSTRAINT [DF_ChangeRequest_isSubmitted]  DEFAULT ((0)) FOR [isSubmitted]
GO
ALTER TABLE [IT].[ChangeRequest] ADD  CONSTRAINT [DF_ChangeRequest_isApproved]  DEFAULT ((0)) FOR [isApproved]
GO
ALTER TABLE [IT].[ChangeRequest] ADD  CONSTRAINT [DF_ChangeRequest_isImplemented]  DEFAULT ((0)) FOR [isImplemented]
GO
ALTER TABLE [IT].[ChangeRequest] ADD  CONSTRAINT [DF_ChangeRequest_isReleased]  DEFAULT ((0)) FOR [isReleased]
GO
ALTER TABLE [IT].[ISAttachment] ADD  CONSTRAINT [DF_ISAttachment_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [IT].[SRAttachment] ADD  CONSTRAINT [DF_SRAttachment_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [IT].[SRWindowLogin] ADD  CONSTRAINT [DF__SRWindowL__IsAct__269C4CB9]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [IT].[UserVal] ADD  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [IT].[Approver]  WITH CHECK ADD  CONSTRAINT [FK_Approver_Approver2] FOREIGN KEY([Approver2])
REFERENCES [IT].[SupportTeam] ([SupportTeamID])
GO
ALTER TABLE [IT].[Approver] CHECK CONSTRAINT [FK_Approver_Approver2]
GO
ALTER TABLE [IT].[Approver]  WITH CHECK ADD  CONSTRAINT [FK_Approver_Approver3] FOREIGN KEY([Approver3])
REFERENCES [IT].[SupportTeam] ([SupportTeamID])
GO
ALTER TABLE [IT].[Approver] CHECK CONSTRAINT [FK_Approver_Approver3]
GO
ALTER TABLE [IT].[Approver]  WITH CHECK ADD  CONSTRAINT [FK_Approver_Support] FOREIGN KEY([SupportID])
REFERENCES [IT].[Support] ([SupportID])
GO
ALTER TABLE [IT].[Approver] CHECK CONSTRAINT [FK_Approver_Support]
GO
ALTER TABLE [IT].[Approver]  WITH CHECK ADD  CONSTRAINT [FK_Approver_SupportTeam] FOREIGN KEY([Approver1])
REFERENCES [IT].[SupportTeam] ([SupportTeamID])
GO
ALTER TABLE [IT].[Approver] CHECK CONSTRAINT [FK_Approver_SupportTeam]
GO
ALTER TABLE [IT].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Support] FOREIGN KEY([SupportID])
REFERENCES [IT].[Support] ([SupportID])
GO
ALTER TABLE [IT].[Category] CHECK CONSTRAINT [FK_Category_Support]
GO
ALTER TABLE [IT].[ChangeRequest]  WITH CHECK ADD  CONSTRAINT [FK_ChangeRequest_Category] FOREIGN KEY([CategoryID])
REFERENCES [IT].[Category] ([ITCategoryID])
GO
ALTER TABLE [IT].[ChangeRequest] CHECK CONSTRAINT [FK_ChangeRequest_Category]
GO
ALTER TABLE [IT].[ChangeRequest]  WITH CHECK ADD  CONSTRAINT [FK_ChangeRequest_Classification] FOREIGN KEY([ClassifcationID])
REFERENCES [IT].[Classification] ([ITClassificationID])
GO
ALTER TABLE [IT].[ChangeRequest] CHECK CONSTRAINT [FK_ChangeRequest_Classification]
GO
ALTER TABLE [IT].[Checklist]  WITH CHECK ADD  CONSTRAINT [FK_Checklist_Support] FOREIGN KEY([SupportID])
REFERENCES [IT].[Support] ([SupportID])
GO
ALTER TABLE [IT].[Checklist] CHECK CONSTRAINT [FK_Checklist_Support]
GO
ALTER TABLE [IT].[CRExecutionPlan]  WITH CHECK ADD  CONSTRAINT [FK_CRExecutionPlan_ChangeRequest1] FOREIGN KEY([ITCRID])
REFERENCES [IT].[ChangeRequest] ([ITCRID])
GO
ALTER TABLE [IT].[CRExecutionPlan] CHECK CONSTRAINT [FK_CRExecutionPlan_ChangeRequest1]
GO
ALTER TABLE [IT].[CRFollowup]  WITH CHECK ADD  CONSTRAINT [FK_CRFollowup_ChangeRequest] FOREIGN KEY([ITCRID])
REFERENCES [IT].[ChangeRequest] ([ITCRID])
GO
ALTER TABLE [IT].[CRFollowup] CHECK CONSTRAINT [FK_CRFollowup_ChangeRequest]
GO
ALTER TABLE [IT].[CRLesson]  WITH CHECK ADD  CONSTRAINT [FK_CRLessonID_ChangeRequest] FOREIGN KEY([ITCRID])
REFERENCES [IT].[ChangeRequest] ([ITCRID])
GO
ALTER TABLE [IT].[CRLesson] CHECK CONSTRAINT [FK_CRLessonID_ChangeRequest]
GO
ALTER TABLE [IT].[CRMilestone]  WITH CHECK ADD  CONSTRAINT [FK_CRMilestone_ChangeRequest] FOREIGN KEY([ITCRID])
REFERENCES [IT].[ChangeRequest] ([ITCRID])
GO
ALTER TABLE [IT].[CRMilestone] CHECK CONSTRAINT [FK_CRMilestone_ChangeRequest]
GO
ALTER TABLE [IT].[CRRelease]  WITH CHECK ADD  CONSTRAINT [FK_CRReleaseID_ChangeRequest] FOREIGN KEY([ITCRID])
REFERENCES [IT].[ChangeRequest] ([ITCRID])
GO
ALTER TABLE [IT].[CRRelease] CHECK CONSTRAINT [FK_CRReleaseID_ChangeRequest]
GO
ALTER TABLE [IT].[CRTemplateDtls]  WITH CHECK ADD  CONSTRAINT [FK_CRTemplateDtls_CRTemplate] FOREIGN KEY([CRTemplateID])
REFERENCES [IT].[CRTemplate] ([CRTemplateID])
GO
ALTER TABLE [IT].[CRTemplateDtls] CHECK CONSTRAINT [FK_CRTemplateDtls_CRTemplate]
GO
ALTER TABLE [IT].[RiskPlan]  WITH CHECK ADD  CONSTRAINT [FK_RiskPlan_Category] FOREIGN KEY([CategoryID])
REFERENCES [IT].[Category] ([ITCategoryID])
GO
ALTER TABLE [IT].[RiskPlan] CHECK CONSTRAINT [FK_RiskPlan_Category]
GO
ALTER TABLE [IT].[RiskPlan]  WITH CHECK ADD  CONSTRAINT [FK_RiskPlan_Support] FOREIGN KEY([SupportID])
REFERENCES [IT].[Support] ([SupportID])
GO
ALTER TABLE [IT].[RiskPlan] CHECK CONSTRAINT [FK_RiskPlan_Support]
GO
ALTER TABLE [IT].[SERVICE_MASTER]  WITH CHECK ADD  CONSTRAINT [FK_Sr_Module_ID] FOREIGN KEY([Sr_Module_ID])
REFERENCES [IT].[Support] ([SupportID])
GO
ALTER TABLE [IT].[SERVICE_MASTER] CHECK CONSTRAINT [FK_Sr_Module_ID]
GO
ALTER TABLE [IT].[SLA]  WITH CHECK ADD  CONSTRAINT [FK_SLA_Category] FOREIGN KEY([CategoryID])
REFERENCES [IT].[Category] ([ITCategoryID])
GO
ALTER TABLE [IT].[SLA] CHECK CONSTRAINT [FK_SLA_Category]
GO
ALTER TABLE [IT].[SLA]  WITH CHECK ADD  CONSTRAINT [FK_SLA_ITClassification] FOREIGN KEY([ClassificationID])
REFERENCES [IT].[Classification] ([ITClassificationID])
GO
ALTER TABLE [IT].[SLA] CHECK CONSTRAINT [FK_SLA_ITClassification]
GO
ALTER TABLE [IT].[SLA]  WITH CHECK ADD  CONSTRAINT [FK_SLA_Plant_Master] FOREIGN KEY([PlantID])
REFERENCES [dbo].[Plant_Master] ([Id])
GO
ALTER TABLE [IT].[SLA] CHECK CONSTRAINT [FK_SLA_Plant_Master]
GO
ALTER TABLE [IT].[SLA]  WITH CHECK ADD  CONSTRAINT [FK_SLA_Support] FOREIGN KEY([SupportID])
REFERENCES [IT].[Support] ([SupportID])
GO
ALTER TABLE [IT].[SLA] CHECK CONSTRAINT [FK_SLA_Support]
GO
ALTER TABLE [IT].[SysLandscape]  WITH CHECK ADD  CONSTRAINT [FK_SysLandscape_Category] FOREIGN KEY([CategoryID])
REFERENCES [IT].[Category] ([ITCategoryID])
GO
ALTER TABLE [IT].[SysLandscape] CHECK CONSTRAINT [FK_SysLandscape_Category]
GO
ALTER TABLE [IT].[SysLandscape]  WITH CHECK ADD  CONSTRAINT [FK_SysLandscape_Classification] FOREIGN KEY([ClassificationID])
REFERENCES [IT].[Classification] ([ITClassificationID])
GO
ALTER TABLE [IT].[SysLandscape] CHECK CONSTRAINT [FK_SysLandscape_Classification]
GO
ALTER TABLE [IT].[SysLandscape]  WITH CHECK ADD  CONSTRAINT [FK_SysLandscape_Support] FOREIGN KEY([SupportID])
REFERENCES [IT].[Support] ([SupportID])
GO
ALTER TABLE [IT].[SysLandscape] CHECK CONSTRAINT [FK_SysLandscape_Support]
GO
/****** Object:  StoredProcedure [IT].[sp_ApproverRemoved]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <23-Mar-2024,,>
-- Description:	<Create Approver Assignment Team Member,,>
-- =============================================
Create PROCEDURE [IT].[sp_ApproverRemoved]
	@SupportTeamID [int] NULL,
	@PlantID int NULL,
	@SupportID int NULL,
	@CategoryID int NULL,
	@ClassificationID int NULL,
	@Approverstage Char(1) NULL,
	@Level int NULL,
	@CreatedBy [int] 
	
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @err_num int, @err_msg varchar(100)
	Declare @count int, @ApproverID int, @pos int
	Declare @Approver1 int, @Approver2 int, @Approver3 int,@Fill int,@ITApproverID int
	Select @Fill=0 , @ITApproverID=0


	BEGIN TRANSACTION
		select @count=count(appr1.ITApproverID), 
			@ApproverID=appr1.ITApproverID, @Approver1=appr1.Approver1, @Approver2=appr1.Approver2, @Approver3=appr1.Approver3,
			@pos=(select (case 
			when (appr.Approver1=@SupportTeamID) then 1
			when (appr.Approver2=@SupportTeamID) then 2
			when (appr.Approver3=@SupportTeamID) then 3
			End)
			from IT.Approver appr where (appr.Approver1=@SupportTeamID or appr.Approver2=@SupportTeamID or appr.Approver3=@SupportTeamID)
			and appr.PlantID=@PlantID and appr.CategoryID=@CategoryID and appr.ClassificationID=@Classificationid and appr.level=1 and appr.Approverstage='N' and appr.SupportID=@SupportID)
			from IT.Approver appr1 where (appr1.Approver1=@SupportTeamID or appr1.Approver2=@SupportTeamID or appr1.Approver3=@SupportTeamID)
			and appr1.PlantID=@PlantID and appr1.CategoryID=@CategoryID  and appr1.ClassificationID=@Classificationid and appr1.level=1 and appr1.Approverstage='N' and appr1.SupportID=@SupportID
			group by appr1.ITApproverID, appr1.Approver1, appr1.Approver2,appr1.Approver3

			if(@count>0)
			
				Begin
					if (@pos=1)
					Begin
						if(@Approver2 is NULL and @Approver3 is NULL)
						Begin
							Begin transaction
							Delete from IT.Approver where ITApproverID=@ApproverID
							commit transaction
						End
						Else
						Begin
							Update IT.Approver  set Approver1=@Approver2, Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
						End
					End
					Else if(@pos=2)
					Begin
						Update IT.Approver set Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
					
					End
					Else
					Begin
						Update IT.Approver  set Approver3=NULL where ITApproverID=@ApproverID
					End

				
			End
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_ASApprover]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_ASApprover](
	@Flag Char(1),
	@ITAssetID [int],
	@ITSpareID [int],
	@ISHOD [bit] NULL,
	@ISRPM [bit] NULL,
	@HOD_ApproverID [int],
	@HOD_ApproverRemarks [varchar](2000) NULL,
	@RPM_ApproverID [int],
	@RPM_ApproverRemarks [varchar](2000) NULL,
	@Status [varchar](150),
	@CreatedBy int NULL)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @level int=0

	IF @Flag = 'A' -- Insert AS Approver Fields

	BEGIN 
		IF @ISRPM = 1
			BEGIN
				BEGIN TRANSACTION
					UPDATE [IT].[ITAssetDetails] 
					SET 
						RPM_ApproverID=@RPM_ApproverID,
						RPM_ApprovedDt = GETDATE(),
						RPM_ApproverRemarks = @RPM_ApproverRemarks,
						Status = @Status,
						ModifiedBy = @CreatedBy,
						ModifiedDt = getdate()
					WHERE ITAssetID = @ITAssetID
				COMMIT TRANSACTION
			END
		ELSE 
			BEGIN
				BEGIN TRANSACTION
					UPDATE [IT].[ITAssetDetails] 
					SET 
						HOD_ApproverID=@HOD_ApproverID,
						HOD_ApprovedDt = GETDATE(),
						HOD_ApproverRemarks = @HOD_ApproverRemarks,
						Status = @Status,
						ModifiedBy = @CreatedBy,
						ModifiedDt = getdate()
					WHERE ITAssetID = @ITAssetID
				COMMIT TRANSACTION
			END
	END
	
	IF @Flag = 'S' -- Insert AS Approver Fields

	BEGIN 
		IF @ISRPM = 1
			BEGIN
				BEGIN TRANSACTION
					UPDATE [IT].[ITSpare] 
					SET 
						RPM_ApproverID=@RPM_ApproverID,
						RPM_ApprovedDt = GETDATE(),
						RPM_ApproverRemarks = @RPM_ApproverRemarks,
						Status = @Status,
						ModifiedBy = @CreatedBy,
						ModifiedDt = getdate()
					WHERE ITSpareID = @ITSpareID
				COMMIT TRANSACTION
			END
		ELSE 
			BEGIN
				BEGIN TRANSACTION
					UPDATE [IT].[ITSpare] 
					SET 
						HOD_ApproverID=@HOD_ApproverID,
						HOD_ApprovedDt = GETDATE(),
						HOD_ApproverRemarks = @HOD_ApproverRemarks,
						Status = @Status,
						ModifiedBy = @CreatedBy,
						ModifiedDt = getdate()
					WHERE ITSpareID = @ITSpareID
				COMMIT TRANSACTION
			END
	END
	
	ELSE
		RETURN error_message()
	
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_ASResolution]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_ASResolution](
	@Flag Char(1),
	@ITAssetID [int],
	@ITSpareID [int],
	@UserRemarks [nvarchar](MAX) NULL,
	@ProposedResolDt [datetime] NULL,
	@ResolDt [datetime] NULL,
	@Description [nvarchar](MAX) NULL,
	@OnHoldReason [int] NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@Remarks [nvarchar](2000) NULL,
	@Status [nvarchar](150),
	@CreatedBy [int] NULL)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @level int=0

	IF @Flag = 'A' -- Insert AS Approver Fields
	BEGIN 
		BEGIN TRANSACTION
			UPDATE [IT].[ITAssetDetails] 
			SET 
				ResolRemarks =@Remarks
			  ,UserRemarks = @UserRemarks
			  ,ProposedResolDt =@ProposedResolDt
			  ,ResolDt = getDate() 
			  ,Description = @Description
			  ,OnHoldReason = @OnHoldReason
			  ,Status = @Status
			  ,AssignedTo = @AssignedTo
			  ,AssignedBy = @AssignedBy
			  ,ModifiedBy = @CreatedBy
			  ,ModifiedDt = getdate()
			WHERE ITAssetID = @ITAssetID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag = 'S' -- Insert AS Approver Fields
	BEGIN 
		BEGIN TRANSACTION
			UPDATE [IT].[ITSpare] 
			SET 
				ResolRemarks =@Remarks
			  ,UserRemarks = @UserRemarks
			  ,ProposedResolDt =@ProposedResolDt
			  ,ResolDt = getDate() 
			  ,Description = @Description
			  ,OnHoldReason = @OnHoldReason
			   ,AssignedTo = @AssignedTo
			  ,AssignedBy = @AssignedBy
			  ,Status = @Status
			  ,ModifiedBy = @CreatedBy
			  ,ModifiedDt = getdate()
			WHERE ITSpareID = @ITSpareID
		COMMIT TRANSACTION
	END
	
	ELSE
		RETURN error_message()
	
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_AssignApprover]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <23-Mar-2024,,>
-- Description:	<Create Approver Assignment Team Member,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_AssignApprover]
	@SupportTeamID [int] NULL,
	@PlantID int NULL,
	@SupportID int NULL,
	@CategoryID int NULL,
	@ClassificationID int NULL,
	@Approverstage Char(1) NULL,
	@Level int NULL,
	@CreatedBy [int] 
	
AS
BEGIN 
BEGIN TRY
	SET NOCOUNT ON;

	DECLARE @err_num int, @err_msg varchar(100)
	DECLARE @Approver1 int, @Approver2 int, @Approver3 int, @Fill int, @ITApproverID int
	SELECT @Fill = 0, @ITApproverID = 0

	SELECT @ITApproverID = ITApproverID, @Approver1 = Approver1, @Approver2 = Approver2, @Approver3 = Approver3 
	FROM [IT].[Approver]
	WHERE SupportID = @SupportID 
		AND CategoryID = @CategoryID 
		AND ClassificationID = @ClassificationID 
		AND PlantID = @PlantID
		AND Approverstage = @Approverstage 
		AND Level = @Level

	IF (@Approver1 IS NULL) -- Assign @SupportTeamID to @Approver1 if it's null
	BEGIN
		SET @Approver1 = @SupportTeamID
		SET @Fill = 1
	END
	ELSE IF ((@Approver1 IS NOT NULL AND @Approver1 != '') 
		AND (@Approver2 IS NOT NULL AND @Approver2 != '')  
		AND (@Approver3 IS NOT NULL AND @Approver3 != ''))
	BEGIN
		SET @err_num = 4000
		SET @err_msg = 'Max Approvers are already assigned for this group'
		RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg)
		RETURN
	END 
	ELSE IF (@Approver1 = @SupportTeamID)
	BEGIN
		SET @err_num = 4000
		SET @err_msg = 'Approver 1 is already assigned for level ' + CAST(@Level AS varchar(5))
		RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
		RETURN
	END
	ELSE IF (@Approver2 = @SupportTeamID) 
	BEGIN
		SET @err_num = 4000
		SET @err_msg = 'Approver 2 is already assigned for level ' + CAST(@Level AS varchar(5))
		RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
		RETURN
	END
	ELSE IF (@Approver3 = @SupportTeamID) 
	BEGIN
		SET @err_num = 4000
		SET @err_msg = 'Approver 3 is already assigned for level ' + CAST(@Level AS varchar(5))
		RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
		RETURN
	END
	ELSE
	BEGIN
		IF (@Approver2 IS NULL AND @Fill = 0)
		BEGIN
			SET @Approver2 = @SupportTeamID
			SET @Fill = 1
		END
		IF (@Approver3 IS NULL AND @Fill = 0)
		BEGIN
			SET @Approver3 = @SupportTeamID
			SET @Fill = 1
		END

		IF (@ITApproverID != 0)
		BEGIN
			BEGIN TRANSACTION
			UPDATE [IT].[Approver] 
			SET [Approver1] = @Approver1,
				[Approver2] = @Approver2,
				[Approver3] = @Approver3,
				[ModifiedBy] = @CreatedBy,
				[ModifiedDt] = GETDATE()
			WHERE ITApproverID = @ITApproverID
			COMMIT TRANSACTION
		END
		ELSE
		BEGIN
			BEGIN TRANSACTION
			INSERT INTO [IT].[Approver] (
				[PlantID],
				[SupportID],
				[CategoryID],
				[ClassificationID],
				[Approverstage],
				[Approver1],
				[Approver2],
				[Approver3],
				[Level],
				[CreatedBy],
				[CreatedDt],
				[ModifiedBy],
				[ModifiedDt])
			VALUES (
				@PlantID,
				@SupportID,
				@CategoryID,
				@ClassificationID,
				@Approverstage,
				@Approver1,
				@Approver2,
				@Approver3,
				@Level,
				@CreatedBy,
				GETDATE(),
				@CreatedBy,
				GETDATE())
			COMMIT TRANSACTION
		END
	END			
END TRY
	
BEGIN CATCH
	ROLLBACK TRANSACTION
	SET @err_num = ERROR_NUMBER()
	SET @err_msg = ERROR_MESSAGE()
	RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
END CATCH
END

GO
/****** Object:  StoredProcedure [IT].[sp_Attachfile]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [IT].[sp_Attachfile](
	@CRID [int] NULL,
	@FileName [nvarchar] (500) Null,
	@Stage [nvarchar] (200) Null,
	@IsActive [bit] NULL,
	@CreatedBy [int] NULL,
	@CreatedDt [datetime] NULL,
	@ModifiedBy [int] NULL,
	@ModifiedDt [datetime] NULL
)
	
AS
BEGIN 

BEGIN TRY
		SET NOCOUNT ON;
		 BEGIN 
		BEGIN TRANSACTION

		
			INSERT INTO [IT].[AttachFile] (
			[ITCRID],
			[FileName]
			,[Stage]
			,[IsActive]
			,[CreatedBy]
			,[CreatedDt]
			,[ModifiedBy]
			,[ModifiedDt]
		 )
			VALUES (
			@CRID,
			@FileName,
			@Stage,
			@IsActive,
			@CreatedBy,
			@CreatedDt,
			@ModifiedBy,
			@ModifiedDt
			)
		COMMIT TRANSACTION
	END
	
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_Bootstrap]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [IT].[sp_Bootstrap]
	
AS
BEGIN 
Declare 
@SupportID int

Select @SupportID=SupportID from Support where SupportName='Change Request'
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

	BEGIN 

	Declare @count int

		BEGIN TRANSACTION

		Select @count= count(*) from  [IT].[Category] where ITCategoryID=1
		
		If @count=0 
		Begin
			INSERT INTO [IT].[Category] (
			[SupportID],
			[CategoryName],
			[IsActive],
			[CreatedBy],
			[CreatedDt]
		 )
			VALUES (
			@SupportID,
			'Server',
			1,
			135055,
			getdate()
			)
		End

		-- Insert into Classification Table

		Select @count= count(*) from  [IT].[Classification] where ITClassificationID=1
		
		If @count=0 
		Begin
			INSERT INTO [IT].[Classification] (
			[ClassificationName],
			[CreatedBy],
			[CreatedDt]
			)
			VALUES (
			'Standard',
			135055,
			getdate()
			)
		End

			-- Insert into SupportTeam table
			INSERT INTO [IT].[SupportTeam](
			
						[Email],
						[First_Name],
						[Middle_Name],
						[Last_Name],
						[Img_Url],
						[Designation],
						[Role],
						[EmpID],
						[IsActive],
						[DOL],
						[DOB],
						[CreatedBy],
						[CreatedDate],
						[ModifiedBy],
						[ModifiedDate])
						select
						emp.OfficialEmailId,
						emp.FirstName,
						emp.MiddleName,
						emp.LastName,
						NULL,
						emp.DepartmentId,
						'Super Admin',
						emp.EmployeeNo,
						1,
						emp.DateOfLeaving,
						emp.DateOfBirth,
						135055,
						getdate(),
						135055,
						getdate() from HR.Employee emp where emp.EmployeeNo='135055'

						INSERT INTO [IT].[SupportTeamAssgn]
           ([SupportTeamID]
		   ,[SupportID]
           ,[CategoryID]
           ,[ClassificationID]
           ,[CategoryTypID]
           ,[PlantID]
           ,[isApprover]
           ,[isChangeAnalyst]
           ,[isSupportEngineer]
           ,[isAdmin]
           ,[isSuperAdmin]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[ModifiedBy]
           ,[ModifiedDate]
           ,[IsActive])
     VALUES
           (1
		   ,1
           ,1
           ,1
           ,1
           ,5
           ,0
           ,1
           ,1
           ,1
           ,1
           ,135055
           ,getdate()
           ,135055
           ,getdate()
           ,1)


		COMMIT TRANSACTION
	END
	
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Bootstrap Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_Category]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_Category](
	@Flag [char](1),
	@ITCategoryID [int]NULL,
	@SupportID [int] NULL,
	@CategoryName[nvarchar](MAX)NULL,
	@IsActive [bit] NULL,
	@CreatedBy [int] NULL,
	@CreatedDt [datetime] NULL,
	@ModifiedBy [int] NULL,
	@ModifiedDt [datetime] NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION
			INSERT INTO [IT].[Category] (
			[SupportID],
			[CategoryName],
			[IsActive],
			[CreatedBy],
			[CreatedDt]
		 )
			VALUES (
			@SupportID,
			@CategoryName,
			@IsActive,
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[Category] SET
				[SupportID]=@SupportID,
				[CategoryName]=@CategoryName,
				[IsActive]=@IsActive,
				[ModifiedBy]=@ModifiedBy,
				[ModifiedDt]=getdate()
			WHERE ITCategoryID=@ITCategoryID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[Category] WHERE ITCategoryID=@ITCategoryID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Category Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_Categorytyp]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_Categorytyp](
	@Flag [char](1),
	@CategoryTypeID [int]NULL,
	@CategoryID [int]NULL,
	@CategoryType [nvarchar](MAX)NULL,
	@IsActive [bit] NULL,
	@CreatedBy [nchar](10) NULL,
	@CreatedDate [datetime] NULL,
	@ModifiedBy [nchar](10) NULL,
	@ModifiedDate [datetime] NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION

		
			INSERT INTO [IT].[CategoryTyp] (
			[CategoryID],
			[CategoryType],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
		 )
			VALUES (
			@CategoryID,
			@CategoryType,
			@IsActive,
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[CategoryTyp] SET
				[CategoryID]=@CategoryID,
				[CategoryType]=@CategoryType,
				[IsActive]=@IsActive,
				[ModifiedBy]=@ModifiedBy,
				[ModifiedDate]=getdate()
			WHERE CategoryTypeID=@CategoryTypeID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[CategoryTyp] WHERE CategoryTypeID=@CategoryTypeID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Categorytyp Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_ChangeRequest]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [IT].[sp_ChangeRequest](
	@Flag Char,
	@ITCRID [int] Output,
	@SupportID int NULL,
	@ClassifcationID int NULL,
	@CategoryID int NULL,
	@CROwner int= NULL,
	@CRDate datetime NULL,
	@CRRequestedBy int NULL,
	@CRRequestedDt datetime NUll,
	@CRREmailNotification bit =NULL,
	@CRInitiatedFor int NULL,
	@Status nvarchar(50) NULL,
	@ReferenceID [int] NULL,
	@ReferenceTyp [nvarchar](50) NULL,
	@CategoryTypeID [int] NULL,
	@NatureOfChange varchar(50)= NULL,
	@PriorityType int= NULL,
	@PlantID int = NULL,
	@SysLandscapeID nvarchar(500) = NUll,
	@GXPClassification bit= NULL,
	@GXPPlantID int =NULL,
	@ChangeControlNo varchar(50)= NULL,
	@ChangeControlDt date= NULL,
	@ChangeControlAttach bit= NULL,
	@ChangeDesc varchar(2000)= NULL,
	@ReasonForChange varchar(2000)= NULL,
	@AlternateConsidetation varchar(2000)= NULL,
	@ImpactNotDoing varchar(2000)= NULL,
	@BusinessImpact [varchar](2000)= NULL,
	@TriggeredBy varchar(2000)= NULL,
	@Benefits varchar(2000)= NULL,
	@EstimatedCost numeric= NULL,
	@EstimatedCostCurr varchar(3)= NULL,
	@EstimatedEffort int= NULL,
	@EstimatedEffortUnit varchar(50)= NULL,
	@EstimatedDateCompletion date= NULL,
	@RollbackPlan varchar(2000)= NULL,
	@BackoutPlan varchar(2000)= NULL,
	@DownTimeRequired bit= NULL,
	@DownTimeFromDate datetime= NULL,
	@DownTimeToDate datetime= NULL,
	@ImpactedLocation [nvarchar](50)= NULL,
	@ImpactedDept [nvarchar](50)= NULL,
	@ImactedFunc [nvarchar](50)= NULL,
	@Attachment [nvarchar] (max) = NULL,
	@isSubmitted bit = NULL,
	@isApproved bit = NULL,
	@isImplemented bit = NULL,
	@isReleased bit = NULL,
	@CreatedBy int NULL
)
AS
set nocount on;

Declare
@PlantCode  varchar(6),
@CRCode varchar(20),
@MaxCount varchar(4),
@Year varchar(4),
@LastYear varchar(4),
@return_value varchar(20),
@count int
BEGIN TRY
-- INSERT FIELDS
	IF @Flag ='I' 
	BEGIN
	    select @PlantCode= Code from dbo.Plant_Master where id=@PlantID
		select @LastYear= max(DATEPART(year, CRDate)) from [IT].[ChangeRequest]
		--select @MaxCount = count(ITCRID)+1 from [IT].[ChangeRequest]
		select @Year=DATEPART(year, getdate())
		if(@LastYear!=@Year)
			select @MaxCount =1
		else
			select @MaxCount = count(ITCRID)+1 from [IT].[ChangeRequest]
	    
		select @CRCode= CONCAT (@PlantCode,'/CR/',@Year,'/',@MaxCount)
		
		--select @ITCRID=@CRCode

		BEGIN TRANSACTION
			
			Insert into [IT].[ChangeRequest] (
					[CRCode],
					[SupportID],
					[ClassifcationID],
					[CategoryID],
					[CROwner],
					[CRDate],
					[CRRequestedBy],
					[CRRequestedDt],
					[CRREmailNotification],
					[CRInitiatedFor],
					[Stage],
					[Status],
					[ReferenceID],
					[ReferenceTyp],
					[CategoryTypeID],
					[NatureOfChange],
					[PriorityType],
					[PlantID],
					[SysLandscapeID],
					[GXPClassification],
					[GXPPlantID],
					[ChangeControlNo],
					[ChangeControlDt],
					[ChangeControlAttach],
					[ChangeDesc],
					[ReasonForChange],
					[AlternateConsidetation],
					[ImpactNotDoing],
					[BusinessImpact],
					[TriggeredBy],
					[Benefits],
					[EstimatedCost],
					[EstimatedCostCurr],
					[EstimatedEffort],
					[EstimatedEffortUnit],
					[EstimatedDateCompletion],
					[RollbackPlan],
					[BackoutPlan],
					[DownTimeRequired],
					[DownTimeFromDate],
					[DownTimeToDate],
					[ImpactedLocation],
					[ImpactedDept],
					[ImactedFunc],
					[CreatedBy],
					[CreatedDt],
					[ModifiedBy],
					[ModifiedDt]
					) values
				(
				ltrim(rtrim(@CRCode)),
				@SupportID,
				@ClassifcationID,
				@CategoryID,
				@CROwner,
				GETDATE(),
				@CRRequestedBy,
				GETDATE(),
				@CRREmailNotification,
				@CRInitiatedFor ,
				'Initiated',
				@Status,
				@ReferenceID,
				@ReferenceTyp,
				@CategoryTypeID,
				@NatureOfChange ,
				ltrim(rtrim(@PriorityType)) ,
				@PlantID , 
				@SysLandscapeID,
				ltrim(rtrim(@GXPClassification)) ,
				@GXPPlantID,
				ltrim(rtrim(@ChangeControlNo)) ,
				GETDATE(),
				@ChangeControlAttach ,
				@ChangeDesc ,
				@ReasonForChange ,
				@AlternateConsidetation ,
				@ImpactNotDoing,
				@BusinessImpact,
				@TriggeredBy,
				@Benefits ,
				@EstimatedCost ,
				@EstimatedCostCurr,
				@EstimatedEffort ,
				@EstimatedEffortUnit ,
				@EstimatedDateCompletion,
				@RollbackPlan ,
				@BackoutPlan ,
				@DownTimeRequired ,
				@DownTimeFromDate ,
				@DownTimeToDate ,
				@ImpactedLocation,
				@ImpactedDept,
				@ImactedFunc,
				@CreatedBy ,
				getdate(),
				@CreatedBy,
				getdate())

				Commit Transaction
		END
	ELSE IF @Flag ='U'
	BEGIN
		BEGIN transaction
			UPDATE  [IT].[ChangeRequest] Set
				ClassifcationID=@ClassifcationID ,
				CategoryID = @CategoryID ,
				CROwner= @CROwner ,
				CRDate=@CRDate ,
				CRRequestedBy=@CRRequestedBy,
				CRRequestedDt=@CRRequestedDt,
				CRREmailNotification = @CRREmailNotification,
				CRInitiatedFor=@CRInitiatedFor,
				[Status]=@Status,
				ReferenceID=@ReferenceID,
				ReferenceTyp=@ReferenceTyp,
				CategoryTypeID=@CategoryTypeID,
				NatureOfChange=@NatureOfChange,
				PriorityType=@PriorityType,
				PlantID=@PlantID,
				SysLandscapeID = @SysLandscapeID,
				GXPClassification=@GXPClassification,
				GXPPlantID=@GXPPlantID,
				ChangeControlNo=@ChangeControlNo ,
				ChangeControlDt=@ChangeControlDt,
				ChangeControlAttach=@ChangeControlAttach ,
				ChangeDesc=@ChangeDesc ,
				ReasonForChange=@ReasonForChange ,
				AlternateConsidetation=@AlternateConsidetation ,
				ImpactNotDoing=@ImpactNotDoing ,
				BusinessImpact=@BusinessImpact,
				TriggeredBy=@TriggeredBy ,
				Benefits=@Benefits ,
				EstimatedCost=@EstimatedCost ,
				EstimatedCostCurr=@EstimatedCostCurr,
				EstimatedEffort=@EstimatedEffort ,
				EstimatedEffortUnit=@EstimatedEffortUnit ,
				EstimatedDateCompletion=@EstimatedDateCompletion,
				RollbackPlan=@RollbackPlan ,
				BackoutPlan=@BackoutPlan ,
				DownTimeRequired=@DownTimeRequired ,
				DownTimeFromDate=@DownTimeFromDate ,
				DownTimeToDate=@DownTimeToDate ,
				ImpactedLocation=@ImpactedLocation,
				ImpactedDept=@ImpactedDept,
				ImactedFunc=@ImactedFunc,
				isSubmitted = @isSubmitted,
				ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() 
				where ITCRID=@ITCRID
			COMMIT TRANSACTION	
		END
	---Delete Fields
	ELSE IF @Flag='D'
	BEGIN
		BEGIN TRANSACTION
			Update [IT].[ChangeRequest] Set [Status]='Cancelled' , ModifiedBy=@CreatedBy , ModifiedDt=getdate() where ITCRID=@ITCRID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
	


	IF @Flag!='D'
	Begin
	
		IF (@Status='Submitted') 
		BEGIN
			BEGIN transaction
				update IT.ChangeRequest set [Status]='Pending Approval', [Stage]='Initiated' , isSubmitted=1, ApprovedBy=1 where ITCRID=@ITCRID
			commit transaction
		END
	
		IF (@Status='Pending Approval') 
		BEGIN
			BEGIN transaction
				
				update IT.ChangeRequest set [Status]='Pending Approval', [Stage]='Initiated' , isSubmitted=1, ApprovedBy=1 where CRCode=@CRCode
			
			commit transaction
		END

		IF (@Status='Seek Clarification')
		BEGIN
			BEGIN transaction
				update IT.ChangeRequest set [Status]='Draft', [Stage]='Initiated' where ITCRID=@ITCRID
			commit transaction
		END
	End

	if (@CRCODE='')
		select @CRCode=CRCODE from IT.ChangeRequest where CRCODE=@CRCODE
	
	select @ITCRID=ITCRID from IT.ChangeRequest where CRCODE=@CRCODE
	
	Select @count=count(ITCRID) from IT.CRMilestone where ITCRID=@ITCRID
	
	Begin
		if @count>0
		Begin
			if (@Status='Pending Approval' or @Status='Submitted')
				Update IT.CRMilestone Set [RFCSubmittedDt]=getdate() where ITCRID=@ITCRID
			else
				Update IT.CRMilestone Set RFCCreatedDt=getdate() where ITCRID=@ITCRID
		End
		Else
		Begin
		if (@Status='Pending Approval'  or @Status='Submitted')
				Insert into IT.CRMilestone (ITCRID,CRCode,CurrStatus,RFCCreatedDt,RFCSubmittedDt, CreatedBy, CreatedDt) VALUES
				(@ITCRID,@CRCode,@Status,getdate(),getdate(), @CreatedBy,getdate())
			else
				Insert into IT.CRMilestone (ITCRID,CRCode,CurrStatus,RFCCreatedDt,CreatedBy, CreatedDt) VALUES
				(@ITCRID,@CRCode,@Status,getdate(), @CreatedBy,getdate())
		End
	End

	--select @CRCode AS CRCODE
	
	--RETURN CAST(isNull(@CRCode,'') as nvarchar(20))

END TRY	


BEGIN CATCH
		--ROLLBACK TRANSACTION
		--BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		--END
END CATCH
GO
/****** Object:  StoredProcedure [IT].[sp_CheckList]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CheckList](
	@Flag [char](1),
	@ITChecklistID [int]NULL,
	@PlantID [int] NULL,
	@SupportID[int]NULL,
	@CategoryID[int]NULL,
	@ClassificationID[int]NULL,
	@ChecklistTitle varchar(150),
	@ChecklistDesc varchar(1500),
	@MandatoryFlag bit NULL,
	@CreatedBy [int] NULL,
	@CreatedDt [datetime] NULL,
	@ModifiedBy [int] NULL,
	@ModifiedDt [datetime] NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION
			INSERT INTO [IT].[Checklist] (
			[PlantID],
			[SupportID],
			[CategoryID],
			[ClassificationID],
			[ChecklistTitle],
			[ChecklistDesc],
			[MandatoryFlag],
			[CreatedBy],
			[CreatedDt]
		 )
			VALUES (
			@PlantID,
			@SupportID,
			@CategoryID,
			@ClassificationID,
			@ChecklistTitle,
			@ChecklistDesc,
			@MandatoryFlag,
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[Checklist] SET
				[PlantID]=@PlantID,
				[SupportID]=@SupportID,
				[CategoryID]=@CategoryID,
				[ClassificationID]=@ClassificationID,
				[ChecklistTitle]=@ChecklistTitle,
				[ChecklistDesc]=@ChecklistDesc,
				[MandatoryFlag]=@MandatoryFlag,
				[ModifiedBy]=@ModifiedBy,
				[ModifiedDt]=getdate()
			WHERE ITChecklistID=@ITChecklistID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[Checklist] WHERE ITChecklistID=@ITChecklistID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Category Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_Classification]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_Classification](
	@Flag [char](1),
	@ITClassificationID [int] NULL,
	@ClassificationName [nvarchar](MAX) NULL,
	@CreatedBy [nchar](10) NULL,
	@CreatedDt [datetime] NULL,
	@ModifiedBy [nchar](10) NULL,
	@ModifiedDt [datetime] NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION
			INSERT INTO [IT].[Classification] (
			[ClassificationName],
			[CreatedBy],
			[CreatedDt]
		 )
			VALUES (
			@ClassificationName,
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[Classification] SET
				[ClassificationName]=@ClassificationName,
				[ModifiedBy]=@ModifiedBy,
				[ModifiedDt]=getdate()
			WHERE ITClassificationID=@ITClassificationID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[Classification] WHERE ITClassificationID=@ITClassificationID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Classification Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_ClearITCRTables]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [IT].[sp_ClearITCRTables]
	
AS
BEGIN 

BEGIN TRY
	
			delete from it.Approver
			delete from it.CRApprover
			delete from it.CRApproverHistory
			delete from it.CRExecutionPlanHistory
			delete from it.CRExecutionPlan
			delete from it.CRFollowup
			delete from it.CRLesson
			delete from it.CRRelease
			delete from [IT].[AttachFile]
			delete from it.ChangeRequest
			delete from it.ChangeRequestHistory
			delete from it.SupportTeamAssgn
			delete from it.SupportTeam
			

			DBCC CHECKIDENT ('it.Approver', RESEED, 0);
			DBCC CHECKIDENT ('it.ChangeRequest', RESEED, 0);
			DBCC CHECKIDENT ('it.ChangeRequestHistory', RESEED, 0);
			DBCC CHECKIDENT ('it.CRApprover', RESEED, 0);
			DBCC CHECKIDENT ('it.CRApproverHistory', RESEED, 0);
			DBCC CHECKIDENT ('it.CRExecutionPlanHistory', RESEED, 0);
			DBCC CHECKIDENT ('it.CRExecutionPlan', RESEED, 0);
			DBCC CHECKIDENT ('it.CRFollowup', RESEED, 0);
			DBCC CHECKIDENT ('it.CRLesson', RESEED, 0);
			DBCC CHECKIDENT ('it.CRRelease', RESEED, 0);
			DBCC CHECKIDENT ('[IT].[AttachFile]', RESEED, 0);
			DBCC CHECKIDENT ('it.SupportTeam', RESEED, 0);
			DBCC CHECKIDENT ('it.SupportTeamAssgn', RESEED, 0);
		COMMIT TRANSACTION
	
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Bootstrap Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_ClearITTables]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [IT].[sp_ClearITTables]
	
AS
BEGIN 

BEGIN TRY
	

			delete from it.Approver
			delete from it.Category
			delete from it.CategoryTyp
			delete from it.ChangeRequest
			delete from it.ChangeRequestHistory
			delete from it.Checklist
			delete from it.Classification
			delete from it.CRApprover
			delete from it.CRApproverHistory
			delete from it.CRExecutionPlanHistory
			delete from it.CRExecutionPlan
			delete from it.SysLandscape
			delete from it.CRFollowup
			delete from it.CRLesson
			delete from it.CRRelease
			delete from it.IssueList
			delete from it.NatureofChange
			delete from it.Priority
			delete from it.Reference
			delete from it.ReferenceTyp
			delete from it.RiskPlan
			delete from it.SupportTeamAssgn
			delete from it.SupportTeam
			

			DBCC CHECKIDENT ('it.Approver', RESEED, 0);
			DBCC CHECKIDENT ('it.Category', RESEED, 0);
			DBCC CHECKIDENT ('it.CategoryTyp', RESEED, 0);
			DBCC CHECKIDENT ('it.ChangeRequest', RESEED, 0);
			DBCC CHECKIDENT ('it.ChangeRequestHistory', RESEED, 0);
			DBCC CHECKIDENT ('it.Checklist', RESEED, 0);
			DBCC CHECKIDENT ('it.Classification', RESEED, 0);
			DBCC CHECKIDENT ('it.CRApprover', RESEED, 0);
			DBCC CHECKIDENT ('it.CRApproverHistory', RESEED, 0);
			DBCC CHECKIDENT ('it.CRExecutionPlanHistory', RESEED, 0);
			DBCC CHECKIDENT ('it.CRExecutionPlan', RESEED, 0);
			DBCC CHECKIDENT ('it.SysLandscape', RESEED, 0);
			DBCC CHECKIDENT ('it.CRFollowup', RESEED, 0);
			DBCC CHECKIDENT ('it.CRLesson', RESEED, 0);
			DBCC CHECKIDENT ('it.CRRelease', RESEED, 0);
			DBCC CHECKIDENT ('it.IssueList', RESEED, 0);
			DBCC CHECKIDENT ('it.NatureofChange', RESEED, 0);
			DBCC CHECKIDENT ('it.Priority', RESEED, 0);
			DBCC CHECKIDENT ('it.Reference', RESEED, 0);
			DBCC CHECKIDENT ('it.ReferenceTyp', RESEED, 0);
			DBCC CHECKIDENT ('it.RiskPlan', RESEED, 0);
			DBCC CHECKIDENT ('it.Support', RESEED, 0);
			DBCC CHECKIDENT ('it.SupportTeam', RESEED, 0);
			DBCC CHECKIDENT ('it.SupportTeamAssgn', RESEED, 0);
			
	
		COMMIT TRANSACTION
	
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Bootstrap Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRApprover]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRApprover](
	@Flag Char(1),
	@CRApproverID [int] NULL,
	@PlantID [int],
	@SupportID [int],
	@CRID [int] ,
	@ApproverLevel [int],
	@Comments [varchar](2000) NULL,
	@Stage [varchar](150) NULL,
	@ApproverID [int],
	@ApprovedDt [datetime],
	@Remarks [varchar](2000) NULL,
	@Status [varchar](150),
	@Attachment [varchar](2000) NULL,
	@CreatedBy int NULL,
	@CreatedDt [datetime] ,
	@ModifiedBy int NULL,
	@ModifiedDt [datetime] NULL)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @level int=0

	IF @Flag = 'I' -- Insert CR Approver Fields
	BEGIN 
		BEGIN TRANSACTION
			INSERT INTO [IT].[CRApprover] (
			[PlantID],
			[SupportID],
			[CRID],
			[ApproverLevel],
			[Stage],
			[ApproverID],
			[ApprovedDt],
			[Comments],
			[Remarks],
			[Status],
			[Attachment],
			[CreatedBy],
			[CreatedDt],
			[ModifiedBy],
			[ModifiedDt])
			VALUES (
				@PlantID,
				@SupportID,
				@CRID,
				@ApproverLevel,
				@Stage,
				@ApproverID,
				getdate(),
				@Comments,				
				@Remarks,
				@Status,
				@Attachment,
				@CreatedBy,
				getdate(),
				@ModifiedBy,
				getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[CRApprover] SET
				PlantID=@PlantID,
				SupportID=@SupportID,
				CRID=@CRID,
				ApproverLevel=@ApproverLevel,
				Stage=@Stage,
				ApproverID=@ApproverID,
				ApprovedDt=@ApprovedDt,
				Comments=@Comments,
				Remarks=@Remarks,
				[Status]=@Status,
				Attachment=@Attachment,
				ModifiedBy=@CreatedBy,
				ModifiedDt=getdate()
			WHERE ITCRApproverID=@CRApproverID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[CRApprover] WHERE ITCRApproverID=@CRApproverID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()

	select @level = max(level) from it.Approver app
	inner join it.ChangeRequest cr on cr.CategoryID=app.CategoryID and cr.ClassifcationID=app.ClassificationID
	where cr.ITCRID=@CRID and app.Approverstage=@Stage

	IF @Stage ='N' and @Status='Approved'
	Begin
	  Begin transaction
		update IT.ChangeRequest set isApproved=1, Stage='Approval', [Status]='Approved', ApprovedBy = @level, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

		update IT.CRMilestone set  RFCApproved=@CreatedBy, RFCApprovedDt=getdate() where ITCRID=@CRID

	  commit transaction
	End
	IF @Stage ='N' and @Status ='Approved Level1'
	BEGIN
		BEGIN transaction
		if @level>1 
		Begin
			update it.ChangeRequest set Stage='Approval', Status='Approved level1', ApprovedBy = 1, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate()  where ITCRID=@CRID

			update IT.CRMilestone set  RFCApproverLevel1=@CreatedBy, RFCApproverLevel1Dt=getdate() where ITCRID=@CRID
		End
		else
		Begin
			update it.ChangeRequest set isApproved=1, Stage='Approval', Status='Approved' , ApprovedBy = 1, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

			update IT.CRMilestone set  RFCApproved=@CreatedBy, RFCApprovedDt=getdate() where ITCRID=@CRID
		End
		commit transaction
	END
	IF @Stage ='N' and @Status ='Approved Level2'
	BEGIN
		BEGIN transaction
		   if @level>2 
		   Begin
			update it.ChangeRequest set Stage='Approval', Status='Approved level2' , ApprovedBy = 2, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

			update IT.CRMilestone set  RFCApproverLevel2=@CreatedBy, RFCApproverLevel2Dt=getdate() where ITCRID=@CRID
			End
		else
			Begin
			update it.ChangeRequest set isApproved=1,Stage='Approval', Status='Approved' , ApprovedBy = 2, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate()  where ITCRID=@CRID

			update IT.CRMilestone set  RFCApproved=@CreatedBy, RFCApprovedDt=getdate() where ITCRID=@CRID
			End
		commit transaction
	END 
	
	IF @Stage ='N' and @Status ='Reject'
	BEGIN
		BEGIN transaction
			update it.ChangeRequest set isApproved=0,Stage='Approval', Status='Rejected', Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID
		commit transaction
	END
	IF @Stage ='N' and @Status ='Seek Clarification'
	BEGIN
		BEGIN transaction
			update it.ChangeRequest set isApproved=0,Stage='Initiated', Status='Draft', Remarks=@Remarks,ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID
		Commit transaction
	END
	
	IF @Stage ='R' and @Status='Approved Level1'
	BEGIN
		BEGIN transaction
		if @level>1 
		Begin
			update it.ChangeRequest set Stage='Release', Status='Approved level1' , ApprovedBy = 1, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

			update IT.CRMilestone set  RelApproverLevel1=@CreatedBy, RelApproverLevel1Dt=getdate() where ITCRID=@CRID
		End
		else
		Begin
			update it.ChangeRequest set isReleased=0 , Stage='Release', Status='Approved'  , ApprovedBy = 1, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

			update IT.CRMilestone set  RelApproved=@CreatedBy, RelApprovedDt=getdate() where ITCRID=@CRID
		End
		commit transaction
	END

	IF @Stage ='R' and @Status='Approved Level2'
	BEGIN
		BEGIN transaction
		if @level>2 
		Begin
			update it.ChangeRequest set Stage='Release', Status='Approved level2' , ApprovedBy = 1, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

			update IT.CRMilestone set  RelApproverLevel2=@CreatedBy, RelApproverLevel2Dt=getdate() where ITCRID=@CRID
		end
		else
		Begin
			update it.ChangeRequest set isReleased=0 , Stage='Release', Status='Approved', ApprovedBy = 1, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

			update IT.CRMilestone set  RelApproved=@CreatedBy, RelApprovedDt=getdate() where ITCRID=@CRID
		End
		commit transaction
	END

	IF @Stage ='R' and @Status='Reject'
	BEGIN
		BEGIN transaction
			update it.ChangeRequest set isReleased=0 , Stage='Release', Status='Rejected', Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID
		commit transaction
	END

	IF @Stage ='R' and @Status='Seek Clarification'
	BEGIN
		BEGIN transaction
			update it.ChangeRequest set isImplemented=0, isReleased=0 , Stage='Implementation', Status='Implement', Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID
		commit transaction
	END

	IF @Stage ='R' and @Status='Approved'
	BEGIN
		BEGIN transaction
			update it.ChangeRequest set isReleased=0 , Stage='Release', Status='Approved', ApprovedBy = 1, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

			update IT.CRMilestone set  RelApproved=@CreatedBy, RelApprovedDt=getdate() where ITCRID=@CRID
		commit transaction
	END


	IF @Stage ='C' and @Status='Approved Level1'
	BEGIN
		BEGIN transaction
		if @level>1 
		Begin
			update it.ChangeRequest set Stage='Closure', Status='Approved level1' , ApprovedBy = 1, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

			update IT.CRMilestone set  ColApproverLevel1=@CreatedBy, ColApproverLevel1Dt=getdate() where ITCRID=@CRID
		End
		else
		Begin
			update it.ChangeRequest set  Stage='Closure', Status='Approved' , ApprovedBy = 1 , Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

			update IT.CRMilestone set  ColApproved=@CreatedBy, ColApprovedDt=getdate() where ITCRID=@CRID
		End
		commit transaction
	END

	IF @Stage ='C' and @Status='Approved Level2'
	BEGIN
		BEGIN transaction
		if @level>2 
		Begin
			update it.ChangeRequest set Stage='Closure', Status='Approved level2', ApprovedBy = 2, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate()  where ITCRID=@CRID

			update IT.CRMilestone set  ColApproverLevel2=@CreatedBy, ColApproverLevel2Dt=getdate() where ITCRID=@CRID

		End
		else
		Begin
			update it.ChangeRequest set  Stage='Closure', Status='Approved', ApprovedBy = 2, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

			update IT.CRMilestone set  ColApproved=@CreatedBy, ColApprovedDt=getdate() where ITCRID=@CRID
		End
		commit transaction
	END

	IF @Stage ='C' and @Status='Reject'
	BEGIN
		BEGIN transaction
			update it.ChangeRequest set  Stage='Closure', Status='Rejected', Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID
		commit transaction
	END

	IF @Stage ='C' and @Status='Seek Clarification'
	BEGIN
		BEGIN transaction
			update it.ChangeRequest set isReleased=1 , Stage='Closure', Status='Seek Clarification', Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID
		commit transaction
	END

	IF @Stage ='C' and @Status='Approved'
	BEGIN
		BEGIN transaction
			update it.ChangeRequest set  Stage='Closure', Status='Approved', ApprovedBy = @level, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@CRID

			update IT.CRMilestone set  ColApproved=@CreatedBy, ColApprovedDt=getdate() where ITCRID=@CRID
		commit transaction
	END
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRApproverView]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRApproverView](
	@ApproverID [int]
)
AS
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
    CR.CRCODE,
    CR.Status,
    CR.[Stage],
	 (SELECT CRA.ApproverID 
     FROM IT.CRApprover CRA 
     WHERE CRA.CRID = CR.ITCRID 
       AND CRA.ModifiedDt = (SELECT MAX(ModifiedDt) 
                             FROM IT.CRApprover 
                             WHERE CRID = CR.ITCRID)) AS LastApprovedID,
    (SELECT CONCAT(sta1.First_Name, ' ', sta1.Middle_Name, ' ', sta1.Last_Name)
        FROM  IT.CRApprover CRA 
        LEFT JOIN  IT.SupportTeam sta1 ON sta1.EmpID = CRA.ApproverID
        WHERE 
            CRA.CRID = CR.ITCRID 
            AND CRA.ModifiedDt = (
                SELECT 
                    MAX(ModifiedDt) 
                FROM 
                    IT.CRApprover 
                WHERE 
                    CRID = CR.ITCRID
            )
    ) AS LastApproverName,
    (SELECT CRA.ApprovedDt 
     FROM IT.CRApprover CRA 
     WHERE CRA.CRID = CR.ITCRID 
       AND CRA.ModifiedDt = (SELECT MAX(ModifiedDt) 
                             FROM IT.CRApprover 
                             WHERE CRID = CR.ITCRID)) AS LastApprovedDate
,(
		SELECT CASE 
			WHEN (CR.Stage = 'Initiated' AND CR.[Status] = 'Pending Approval') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=1 and appr.Approverstage='N' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=2 and appr.Approverstage='N' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=3 and appr.Approverstage='N' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Implementation' AND CR.[Status] = 'Implemented') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=1 and appr.Approverstage='R' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=2 and appr.Approverstage='R' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=3 and appr.Approverstage='R' and  appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Released') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver1 from IT.approver appr where appr.level=2 and appr.Approverstage='C' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level2')
				THEN (select appr.Approver1 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			
		END
	) as Approver1
	, (
		SELECT CASE 
			WHEN (CR.Stage = 'Initiated' AND CR.[Status] = 'Pending Approval') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=1 and appr.Approverstage='N' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=2 and appr.Approverstage='N' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=3 and appr.Approverstage='N' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Implementation' AND CR.[Status] = 'Implemented') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=1 and appr.Approverstage='R' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=2 and appr.Approverstage='R' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=3 and appr.Approverstage='R' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Released') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver2 from IT.approver appr where appr.level=2 and appr.Approverstage='C' and appr.supportid=CR.supportid and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level2')
				THEN (select appr.Approver2 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			
		END
	) as Approver2
	,(
		SELECT CASE 
			WHEN (CR.Stage = 'Initiated' AND CR.[Status] = 'Pending Approval') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=1 and appr.Approverstage='N' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=2 and appr.Approverstage='N' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Approval' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=3 and appr.Approverstage='N' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Implementation' AND CR.[Status] = 'Implemented') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=1 and appr.Approverstage='R' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=2 and appr.Approverstage='R' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Approved level2') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=3 and appr.Approverstage='R' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Release' AND CR.[Status] = 'Released') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level1') 
				THEN (select appr.Approver3 from IT.approver appr where appr.level=2 and appr.Approverstage='C' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			WHEN (CR.Stage = 'Closure' AND CR.[Status] = 'Approved level2')
				THEN (select appr.Approver3 from IT.approver appr where appr.level=1 and appr.Approverstage='C' and appr.plantID=CR.PlantID and appr.CategoryID=CR.CategoryID and appr.ClassificationID=CR.ClassifcationID)
			
		END
	) as Approver3

	from IT.ChangeRequest CR
	--Join IT.CRApprover CRA on CRA.CRID=CR.ITCRID
	
	where CR.Status in ('Pending Approval','Approved level1', 'Approved level2', 'Implemented','Released')
	
	--ORDER BY CR.ITCRID DESC
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRClosure]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRClosure](
	@ITCRID [int],
	@ClosedStatus [nvarchar](150) NULL,
	@ClosureRemarks [nvarchar](MAX),
	@ClosedBy int NULL,
	@ClosedDt [datetime] NULL,
	@Feedback [nvarchar](MAX) NULL,
	@CreatedBy int NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRANSACTION
			UPDATE [IT].[ChangeRequest] SET
				[Status]='Completed',
				[Stage]='Closure',
				[ClosedStatus]=@ClosedStatus,
				[ClosureRemarks]=@ClosureRemarks,
				[ClosedBy]=@ClosedBy,
				[ClosedDt]=@ClosedDt,
				[Feedback]=@Feedback,
				[Remarks]=@ClosureRemarks,
				[ModifiedBy]=@CreatedBy,
				[ModifiedDt]=getdate()
			WHERE ITCRID=@ITCRID

			Update IT.CRMilestone Set ClosedBy=@CreatedBy, ClosedDt=getdate() where ITCRID=@ITCRID
	COMMIT TRANSACTION


	IF @@ERROR<>''
		RETURN error_message()
	ELSE
		RETURN


	
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('CRClosure Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CREmail]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CREmail](
	@CRID [int]NULL
	
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
select distinct CR.ITCRID, CR.CRCode,CR.SupportID, 
isNull(suppt.First_Name,'')+' '+isNull(suppt.Middle_Name,'')+' '+isNull(suppt.Last_Name,'') CROwner, suppt.Email CROEmail,suppt.EmpID CROEmpid
,isNull(supptI.First_Name,'')+' '+isNull(supptI.Middle_Name,'')+' '+isNull(supptI.Last_Name,'') CRInitiator, supptI.Email CRIEmail, supptI.EmpID CRIEmpid
,isNull(supptR.First_Name,'')+' '+isNull(supptR.Middle_Name,'')+' '+isNull(supptR.Last_Name,'') CRRequestedBy, supptR.Email CRREmail, supptR.EmpID CRREmpid
--Approver Level 1
,isNull(supptA11N.First_Name,'')+' '+isNull(supptA11N.Middle_Name,'')+' '+isNull(supptA11N.Last_Name,'') CRApprover11N, supptA11N.Email CRApprover11NEmail ,supptA11N.EmpID CRApprover11NEmpID
,isNull(supptA11R.First_Name,'')+' '+isNull(supptA11R.Middle_Name,'')+' '+isNull(supptA11R.Last_Name,'') CRApprover11R, supptA11R.Email CRApprover11REmail ,supptA11R.EmpID CRApprover11REmpID
,isNull(supptA11C.First_Name,'')+' '+isNull(supptA11C.Middle_Name,'')+' '+isNull(supptA11C.Last_Name,'') CRApprover11C, supptA11C.Email CRApprover11CEmail , supptA11C.EmpID CRApprover11CEmpID
,isNull(supptA12N.First_Name,'')+' '+isNull(supptA12N.Middle_Name,'')+' '+isNull(supptA12N.Last_Name,'') CRApprover12N, supptA12N.Email CRApprover12NEmail , supptA12N.EmpID CRApprover12NEmpID
,isNull(supptA12R.First_Name,'')+' '+isNull(supptA12R.Middle_Name,'')+' '+isNull(supptA12R.Last_Name,'') CRApprover12R, supptA12R.Email CRApprover12REmail , supptA12R.EmpID CRApprover12REmpID
,isNull(supptA12C.First_Name,'')+' '+isNull(supptA12C.Middle_Name,'')+' '+isNull(supptA12C.Last_Name,'') CRApprover12C, supptA12C.Email CRApprover12CEmail , supptA12C.EmpID CRApprover12CEmpID
,isNull(supptA13N.First_Name,'')+' '+isNull(supptA13N.Middle_Name,'')+' '+isNull(supptA13N.Last_Name,'') CRApprover13N, supptA13N.Email CRApprover13NEmail , supptA13N.EmpID CRApprover13NEmpID
,isNull(supptA13R.First_Name,'')+' '+isNull(supptA13R.Middle_Name,'')+' '+isNull(supptA13R.Last_Name,'') CRApprover13R, supptA13R.Email CRApprover13REmail ,supptA13R.EmpID CRApprover13REmpID
,isNull(supptA13C.First_Name,'')+' '+isNull(supptA13C.Middle_Name,'')+' '+isNull(supptA13C.Last_Name,'') CRApprover13C, supptA13C.Email CRApprover13CEmail , supptA13C.EmpID CRApprover13CEmpID
--Approver Level 2
,isNull(supptA22N.First_Name,'')+' '+isNull(supptA22N.Middle_Name,'')+' '+isNull(supptA21N.Last_Name,'') CRApprover21N, supptA21N.Email CRApprover21NEmail , supptA21N.EmpID CRApprover21NEmpID
,isNull(supptA21R.First_Name,'')+' '+isNull(supptA21R.Middle_Name,'')+' '+isNull(supptA21R.Last_Name,'') CRApprover21R, supptA21R.Email CRApprover21REmail , supptA21R.EmpID CRApprover21REmpID
,isNull(supptA21C.First_Name,'')+' '+isNull(supptA21C.Middle_Name,'')+' '+isNull(supptA21C.Last_Name,'') CRApprover21C, supptA21C.Email CRApprover21CEmail , supptA21C.EmpID CRApprover21CEmpID
,isNull(supptA22N.First_Name,'')+' '+isNull(supptA22N.Middle_Name,'')+' '+isNull(supptA22N.Last_Name,'') CRApprover22N, supptA22N.Email CRApprover22NEmail , supptA22N.EmpID CRApprover22NEmpID
,isNull(supptA22R.First_Name,'')+' '+isNull(supptA22R.Middle_Name,'')+' '+isNull(supptA22R.Last_Name,'') CRApprover22R, supptA22R.Email CRApprover22REmail , supptA22R.EmpID CRApprover22REmpID
,isNull(supptA22C.First_Name,'')+' '+isNull(supptA22C.Middle_Name,'')+' '+isNull(supptA22C.Last_Name,'') CRApprover22C, supptA22C.Email CRApprover22CEmail , supptA22C.EmpID CRApprover22CEmpID
,isNull(supptA23N.First_Name,'')+' '+isNull(supptA23N.Middle_Name,'')+' '+isNull(supptA23N.Last_Name,'') CRApprover23N, supptA23N.Email CRApprover23NEmail , supptA23N.EmpID CRApprover23NEmpID
,isNull(supptA23R.First_Name,'')+' '+isNull(supptA23R.Middle_Name,'')+' '+isNull(supptA23R.Last_Name,'') CRApprover23R, supptA23R.Email CRApprover23REmail , supptA23R.EmpID CRApprover23REmpID
,isNull(supptA23C.First_Name,'')+' '+isNull(supptA23C.Middle_Name,'')+' '+isNull(supptA23C.Last_Name,'') CRApprover23C, supptA23C.Email CRApprover23CEmail , supptA23C.EmpID CRApprover23CEmpID
--Approver Level 3
,isNull(supptA31N.First_Name,'')+' '+isNull(supptA31N.Middle_Name,'')+' '+isNull(supptA31N.Last_Name,'') CRApprover31N, supptA31N.Email CRApprover31NEmail , supptA31N.EmpID CRApprover31NEmpID
,isNull(supptA31R.First_Name,'')+' '+isNull(supptA31R.Middle_Name,'')+' '+isNull(supptA31R.Last_Name,'') CRApprover31R, supptA31R.Email CRApprover31REmail , supptA31R.EmpID CRApprover31REmpID
,isNull(supptA31C.First_Name,'')+' '+isNull(supptA31C.Middle_Name,'')+' '+isNull(supptA31C.Last_Name,'') CRApprover31C, supptA31C.Email CRApprover31CEmail , supptA31C.EmpID CRApprover31CEmpID
,isNull(supptA32N.First_Name,'')+' '+isNull(supptA32N.Middle_Name,'')+' '+isNull(supptA32N.Last_Name,'') CRApprover32N, supptA32N.Email CRApprover32NEmail , supptA32N.EmpID CRApprover32NEmpID
,isNull(supptA32R.First_Name,'')+' '+isNull(supptA32R.Middle_Name,'')+' '+isNull(supptA32R.Last_Name,'') CRApprover32R, supptA32R.Email CRApprover32REmail , supptA32R.EmpID CRApprover32REmpID
,isNull(supptA32C.First_Name,'')+' '+isNull(supptA32C.Middle_Name,'')+' '+isNull(supptA32C.Last_Name,'') CRApprover32C, supptA32C.Email CRApprover32CEmail , supptA32C.EmpID CRApprover32CEmpID
,isNull(supptA33N.First_Name,'')+' '+isNull(supptA33N.Middle_Name,'')+' '+isNull(supptA33N.Last_Name,'') CRApprover33N, supptA33N.Email CRApprover33NEmail , supptA33N.EmpID CRApprover33NEmpID
,isNull(supptA33R.First_Name,'')+' '+isNull(supptA33R.Middle_Name,'')+' '+isNull(supptA33R.Last_Name,'') CRApprover33R, supptA33R.Email CRApprover33REmail , supptA33R.EmpID CRApprover33REmpID
,isNull(supptA33C.First_Name,'')+' '+isNull(supptA33C.Middle_Name,'')+' '+isNull(supptA33C.Last_Name,'') CRApprover33C, supptA33C.Email CRApprover33CEmail , supptA33C.EmpID CRApprover33CEmpID
,isNull(sappt.First_Name,'')+' '+isNull(sappt.Middle_Name,'')+' '+isNull(sappt.Last_Name,'') CRApproverBy, sappt.Email CRApproverByEmail,sappt.EmpID CRApproverByEmpID
,CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID, CR.PlantID as plantcode,
	Class.ClassificationName,CR.CRDate,CR.ModifiedDt,cr.isImplemented,cr.isSubmitted ,CR.isApproved, CR.isReleased,CR.Stage, CR.[Status] CRStatus , app.Remarks ApprovedByRemarks, app.ApprovedDt, app.Stage ApprovedByStage, app.status ApprovedByStatus
	
	/*CR.EstimatedCost, CR.EstimatedCostCurr, CR.EstimatedDateCompletion, CR.ApprovedBy
	,CR.PriorityType,cr.CROwner as ChangeRequestor,plant.Code PlantID,apprn.approver1,apprn.approver2,apprn.approver3, apprn.level,
	(select count(explan.ITCRExecID) from IT.CRExecutionPlan explan where explan.ITCRID=CR.ITCRID) taskcount*/
		from IT.ChangeRequest as CR
		inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
		inner join IT.Classification Class on Class.ITClassificationID=CR.ClassifcationID
		inner join IT.CategoryTyp catTyp on catTyp.CategoryID=CR.CategoryTypeID
		inner join Plant_Master plant on plant.Id = CR.PlantID
		LEFT Outer join [IT].[CRApprover] app on app.CRID=CR.ITCRID 
		LEFT Outer join [IT].SupportTeam sappt on sappt.EmpID=app.ApproverID 
		inner join IT.SupportTeam supptI on supptI.EmpID=CR.CRInitiatedFor
		inner join IT.SupportTeam supptR on supptR.EmpID=CR.CRRequestedBy
		-- Approver Level 1
		LEFT join IT.SupportTeam supptA11N on supptA11N.SupportTeamID=
		(select approver1 from  IT.Approver where level=1 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA11R on supptA11R.SupportTeamID=
		(select approver1 from  IT.Approver where level=1 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA11C on supptA11C.SupportTeamID=
		(select approver1 from  IT.Approver where level=1 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA12N on supptA12N.SupportTeamID=
		(select Approver2 from  IT.Approver where level=1 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA12R on supptA12R.SupportTeamID=
		(select Approver2 from  IT.Approver where level=1 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA12C on supptA12C.SupportTeamID=
		(select approver2 from  IT.Approver where level=1 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA13N on supptA13N.SupportTeamID=
		(select Approver3 from  IT.Approver where level=1 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA13R on supptA13R.SupportTeamID=
		(select Approver3 from  IT.Approver where level=1 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA13C on supptA13C.SupportTeamID=
		(select Approver3 from  IT.Approver where level=1 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		-- Approver Level 2
		LEFT join IT.SupportTeam supptA21N on supptA21N.SupportTeamID=
		(select approver1 from  IT.Approver where level=2 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA21R on supptA21R.SupportTeamID=
		(select approver1 from  IT.Approver where level=2 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA21C on supptA21C.SupportTeamID=
		(select approver1 from  IT.Approver where level=2 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA22N on supptA22N.SupportTeamID=
		(select Approver2 from  IT.Approver where level=2 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA22R on supptA22R.SupportTeamID=
		(select Approver2 from  IT.Approver where level=2 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA22C on supptA22C.SupportTeamID=
		(select approver2 from  IT.Approver where level=2 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA23N on supptA23N.SupportTeamID=
		(select Approver3 from  IT.Approver where level=2 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA23R on supptA13R.SupportTeamID=
		(select Approver3 from  IT.Approver where level=2 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA23C on supptA13C.SupportTeamID=
		(select Approver3 from  IT.Approver where level=2 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		
		-- Approver Level 3
		LEFT join IT.SupportTeam supptA31N on supptA31N.SupportTeamID=
		(select approver1 from  IT.Approver where level=3 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA31R on supptA31R.SupportTeamID=
		(select approver1 from  IT.Approver where level=3 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA31C on supptA31C.SupportTeamID=
		(select approver1 from  IT.Approver where level=3 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA32N on supptA32N.SupportTeamID=
		(select Approver2 from  IT.Approver where level=3 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA32R on supptA32R.SupportTeamID=
		(select Approver2 from  IT.Approver where level=3 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA32C on supptA32C.SupportTeamID=
		(select approver2 from  IT.Approver where level=3 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA33N on supptA33N.SupportTeamID=
		(select Approver3 from  IT.Approver where level=3 and approverstage='N' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA33R on supptA33R.SupportTeamID=
		(select Approver3 from  IT.Approver where level=3 and approverstage='R' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		LEFT join IT.SupportTeam supptA33C on supptA33C.SupportTeamID=
		(select Approver3 from  IT.Approver where level=1 and approverstage='C' and PlantID=CR.PlantID and ClassificationID=CR.ClassifcationID and CategoryID=CR.CategoryID)
		inner join IT.SupportTeam suppt on suppt.EmpID=CR.CROwner
		where CR.ITCRID=@CRID

END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Category Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRExecutionPlan]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRExecutionPlan](
	@Flag [char](1),
	@ITCRExecID [int]=NULL,
	@ITCRID [int],
	@SysLandscape [int],
	@ExecutionStepName [nvarchar](500) NULL,
	@ExecutionStepDesc [nvarchar](MAX) NULL,
	@AssignedTo [int] NULL,
	@StartDt [datetime] NULL,
	@EndDT [datetime] NULL,
	@Attachments [nvarchar](MAX) NULL,
	@Status [nvarchar](50) NULL,
	@ForwardStatus[nvarchar](50) NULL,
	@ForwardedTo [int] NULL,
	@ForwardedDt [datetime] NULL,
	@ReasonForwarded [nvarchar](500) NULL,
	@Remarks [nvarchar](2000) NULL,
	@PickedStatus [nvarchar](50) NULL,
	@PickedDt [datetime] NULL,
	@ActualStartDt [datetime] NULL,
	@ActualEndDt [datetime] NULL,
	@DependSysLandscape [int] NULL,
	@DependTaskID [int] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	If (@ForwardedTo<>'') 
	select @AssignedTo=@ForwardedTo

	IF @Flag = 'I' -- Insert CR Approver Fields
	BEGIN 
		BEGIN TRANSACTION
			INSERT INTO [IT].[CRExecutionPlan] (
			[ITCRID],
			[SysLandscape],
			[ExecutionStepName],
			[ExecutionStepDesc],
			[AssignedTo],
			[StartDt],
			[EndDT],
			[Attachments],
			[Status],
			[ForwardStatus],
			[ForwardedTo],
			[ForwardedDt],
			[ReasonForwarded],
			[Remarks],
			[PickedStatus],
			[PickedDt],
			[ActualStartDt],
			[ActualEndDt],
			[DependSysLandscape],
			[DependTaskID],
			[CreatedBy],
			[CreatedDt],
			[ModifiedBy],
			[ModifiedDt]
			)
			VALUES (
			@ITCRID,
			@SysLandscape,
			@ExecutionStepName,
			@ExecutionStepDesc,
			@AssignedTo,
			@StartDt,
			@EndDT,
			@Attachments,
			@Status,
			@ForwardStatus,
			@ForwardedTo,
			@ForwardedDt,
			@ReasonForwarded,
			@Remarks,
			@PickedStatus,
			@PickedDt,
			@ActualStartDt,
			@ActualEndDt,
			@DependSysLandscape,
			@DependTaskID,
			@CreatedBy,
			getdate(),
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[CRExecutionPlan] SET
				[ITCRID]=@ITCRID,
				[SysLandscape]=@SysLandscape,
				[ExecutionStepName]=@ExecutionStepName,
				[ExecutionStepDesc]=@ExecutionStepDesc,
				[AssignedTo]=@AssignedTo,
				[StartDt]=@StartDt,
				[EndDT]=@EndDT,
				[Attachments]=@Attachments,
				[Status]=@Status,
				[ForwardStatus]=@ForwardStatus,
				[ForwardedTo]=@ForwardedTo,
				[ForwardedDt]=@ForwardedDt,
				[ReasonForwarded]=@ReasonForwarded,
			    [Remarks]=@Remarks,
			    [PickedStatus]=@PickedStatus,
				[PickedDt]=@PickedDt,
				[ActualStartDt]=@ActualStartDt,
				[ActualEndDt]=@ActualEndDt,
				[DependSysLandscape]=@DependSysLandscape,
				[DependTaskID]=@DependTaskID,
				[ModifiedBy]=@CreatedBy,
				[ModifiedDt]=getdate()
			WHERE ITCRExecID=@ITCRExecID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[CRExecutionPlan] WHERE ITCRExecID=@ITCRExecID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='V'   -- Delete CR Approver Field
	BEGIN
		SELECT * FROM [IT].[CRExecutionPlan] WHERE ITCRID=@ITCRID AND SysLandscape=@SysLandscape
		
	END
	ELSE
		RETURN error_message()

	
	IF @Status='Implemented'
	Begin
	  Begin transaction
		update it.changerequest set Stage='Implementation', Status='Implemented', isImplemented=1, Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@ITCRID

		Update IT.CRMilestone Set ImplementedDt=getdate() where ITCRID=@ITCRID
		
	  commit transaction
	End
	Else
	Begin
	  Begin transaction
		update it.changerequest set Stage='Implementation', Status='Implement', Remarks=@Remarks, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@ITCRID
	  commit transaction
	End
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('CRExecutionPlan Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRFollowup]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRFollowup](
	@Flag [char](1),
	@CRFollowupID [int] NULL,
	@ITCRID [int],
	@FollowupDt [datetime] NULL,
	@FollowupToPerson [int] NULL,
	@FollowupComments [nvarchar](max),
	@CreatedBy [int] NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION
				
			INSERT INTO [IT].[CRFollowup] (
				[ITCRID],
				[FollowupDt],
				[FollowupToPerson],
				[FollowupComments] ,
				[CreatedBy] ,
				[CreatedDt])
			VALUES (
				@ITCRID,
				@FollowupDt,
				@FollowupToPerson,
				@FollowupComments,
				@CreatedBy,
				getdate()
				)
		COMMIT TRANSACTION

		 Begin transaction
		update it.changerequest set Remarks=@FollowupComments, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@ITCRID
	  commit transaction
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[CRFollowup] SET
				[ITCRID]=@ITCRID,
				[FollowupDt]=@FollowupDT,
				[FollowupToPerson]=@FollowupToPerson,
				[FollowupComments]=@FollowupComments,
				[ModifiedBy]=@CreatedBy,
				[ModifiedDt]=getdate()
			WHERE CRFollowupID=@CRFollowupID
		COMMIT TRANSACTION

		 Begin transaction
		update it.changerequest set Remarks=@FollowupComments, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@ITCRID
	  commit transaction
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[CRFollowup] WHERE CRFollowupID=@CRFollowupID
		COMMIT TRANSACTION
	END
	
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('CRLession Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRlesson]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRlesson](
	@Flag [char](1),
	@CRLessonID [int] NULL,
	@ITCRID [int],
	@Lessons [nvarchar](MAX)NULL,
	@Attachment [nvarchar](MAX) NULL,
	@LessonDt [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION

		
			INSERT INTO [IT].[CRLesson] (
			[ITCRID],
			[Lessons],
			[Attachment],
			[LessonDt],
			[CreatedBy],
			[CreatedDt]
		 )
			VALUES (
			@ITCRID,
			@Lessons,
			@Attachment,
			getdate(),
			@CreatedBy,
			getdate()
			)
		

	
		update it.changerequest  Set Remarks=@Lessons, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@ITCRID
	  COMMIT TRANSACTION
	
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[CRLesson] SET
				[ITCRID]=@ITCRID,
				[Lessons]=@Lessons,
				[Attachment]=@Attachment,
				[LessonDt]=getdate(),
				[ModifiedBy]=@CreatedBy,
				[ModifiedDt]=getdate()
			WHERE CRLessonID=@CRLessonID
		
		update it.changerequest Set Remarks=@Lessons, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@ITCRID
	  COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[CRLesson] WHERE CRLessonID=@CRLessonID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('CRLession Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRRefrence]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRRefrence](
	@Flag [char](1),
	@ReferenceID [int] NULL,
	@ReferenceName char(10) NULL,
	@IsActive bit NULL,
	@CreatedBy int NULL,
	@CreatedDate datetime NULL,
	@ModifiedBy int NULL,
	@ModifiedDate datetime NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION

		
			INSERT INTO [IT].[Reference] (
			[ReferenceName],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
		 )
			VALUES (
			@ReferenceName,
			@IsActive,
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[Reference] SET
				[ReferenceName]=@ReferenceName,
				[IsActive]=@IsActive,
				[ModifiedBy]=@ModifiedBy,
				[ModifiedDate]=getdate()
			WHERE ReferenceID=@ReferenceID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[Reference] WHERE ReferenceID=@ReferenceID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Refrence Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRRefrenceType]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRRefrenceType](
	@Flag [char](1),
	@ReferenceTypeID [int] NULL,
	@ReferenceType nchar(500) NULL,
	@IsActive bit NULL,
	@CreatedBy int NULL,
	@CreatedDate datetime NULL,
	@ModifiedBy int NULL,
	@ModifiedDate datetime NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION

		
			INSERT INTO [IT].[ReferenceTyp] (
			[ReferenceType],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
		 )
			VALUES (
			@ReferenceType,
			@IsActive,
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[ReferenceTyp] SET
				[ReferenceType]=@ReferenceType,
				[IsActive]=@IsActive,
				[ModifiedBy]=@ModifiedBy,
				[ModifiedDate]=getdate()
			WHERE ReferenceTypeID=@ReferenceTypeID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[ReferenceTyp] WHERE ReferenceTypeID=@ReferenceTypeID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Refrence Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRRelease]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRRelease](
	@Flag [char](1),
	@CRReleaseID [int] NULL,
	@ITCRID [int],
	@SysLandscape [int],
	@ReleaseComments [nvarchar](MAX),
	@AssignedTo [int] NULL,
	@ReleaseDt [datetime] NULL,
	@Attachments [nchar](50) NULL,
	@Status [nchar](10) NULL,
	@ApprovedBy [int] NULL,
	@ApprovedDt [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @Stage char(1), @level int
	select @Stage='R'

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION

		
			INSERT INTO [IT].[CRRelease] (
			[ITCRID],
			[SysLandscape],
			[ReleaseComments],
			[AssignedTo],
			[ReleaseDt],
			[Attachments],
			[Status],
			[ApprovedBy],
			[ApprovedDt],
			[CreatedBy],
			[CreatedDt]
			)
			VALUES (
			@ITCRID,
			@SysLandscape,
			@ReleaseComments,
			@AssignedTo,
			@ReleaseDt,
			@Attachments,
			@Status,
			@ApprovedBy,
			@ApprovedDt,
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[CRRelease] SET
				[Status]=@Status,
				[ModifiedBy]=@CreatedBy,
				[ModifiedDt]=getdate()
			WHERE CRReleaseID=@CRReleaseID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[CRRelease] WHERE CRReleaseID=@CRReleaseID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
	
	select @level = max(level) from it.Approver app
	inner join it.ChangeRequest cr on cr.CategoryID=app.CategoryID and cr.ClassifcationID=app.ClassificationID
	where cr.ITCRID=@ITCRID and app.Approverstage=@Stage

	IF @Stage ='R'
	BEGIN
		BEGIN transaction
			update it.ChangeRequest set isReleased=1 , Stage='Release', Status='Released', Remarks=@ReleaseComments, ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() where ITCRID=@ITCRID

			update IT.CRMilestone set  ReleasedBy=@CreatedBy, ReleasedDt=getdate() where ITCRID=@ITCRID
		commit transaction
	END
		
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('CRRelease Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRTaskEmail]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRTaskEmail](
	@CRID [int]  NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
select CR.ITCRID, CR.CRCode,CR.SupportID
,isNull(suppt.First_Name,'')+' '+isNull(suppt.Middle_Name,'')+' '+isNull(suppt.Last_Name,'') CROwner, suppt.Email CROEmail, suppt.Designation CRODesignation,suppt.Role CRORole,suppt.EmpID CROEmpid
,isNull(supptI.First_Name,'')+' '+isNull(supptI.Middle_Name,'')+' '+isNull(supptI.Last_Name,'') CRInitiator, supptI.Email CRIEmail, supptI.Designation CRIDesignation,supptI.Role CRIRole, supptI.EmpID CRIEmpid
,isNull(supptR.First_Name,'')+' '+isNull(supptR.Middle_Name,'')+' '+isNull(supptR.Last_Name,'') CRRequestor, supptR.Email CRREmail, supptR.Designation CRRDesignation,supptR.Role CRRRole, supptR.EmpID CRREmpid
,CR.ChangeDesc, Cat.ITCategoryID, Cat.CategoryName, Class.ITClassificationID, CR.PlantID as plantcode
,Class.ClassificationName,CR.CRDate,CR.Stage, CR.[Status], CR.ApprovedBy
,execp.ITCRExecID TaskID, execp.ExecutionStepName TaskName, execp.ExecutionStepDesc TaskDesc
,execp.AssignedTo AssignedTo, isNull(supptAssgn.First_Name,'')+' '+isNull(supptAssgn.Middle_Name,'')+' '+isNull(supptAssgn.Last_Name,'') AssignedToName, supptAssgn.Email AssgnEmail, supptAssgn.Designation AssgnDesignation,supptAssgn.Role AssgnRole,supptAssgn.EmpID AssgnEmpid
,execp.ForwardedTo, isNull(supptFwd.First_Name,'')+' '+isNull(supptFwd.Middle_Name,'')+' '+isNull(supptFwd.Last_Name,'') ForwardToName, supptFwd.Email ForwardToEmail, supptFwd.Designation ForwardToDesignation,supptFwd.Role ForwardToRole,supptFwd.EmpID ForwardToEmpid
,execp.Status EStatus, execp.PickedDt,execp.PickedStatus,  execp.ModifiedDt AssignedDt

		from IT.ChangeRequest as CR
		inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID 
		inner join IT.Classification Class on Class.ITClassificationID=CR.ClassifcationID
		inner join IT.CategoryTyp catTyp on catTyp.CategoryID=CR.CategoryTypeID
		inner join Plant_Master plant on plant.Id = CR.PlantID
		inner join IT.CRExecutionPlan execp on execp.ITCRID=CR.ITCRID
		inner join IT.SupportTeam suppt on suppt.EmpID=CR.CROwner
		inner join IT.SupportTeam supptI on supptI.EmpID=CR.CRInitiatedFor
		inner join IT.SupportTeam supptR on supptR.EmpID=CR.CRRequestedBy
		Left join IT.SupportTeam supptAssgn on supptAssgn.EmpID=execp.AssignedTo
		Left join IT.SupportTeam supptFwd on supptFwd.EmpID=execp.ForwardedTo
		where CR.ITCRID=@CRID

END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Category Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRTemplate]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRTemplate](
	@Flag Char(1),
	 @CRTemplateID int NULL
	 ,@TemplateName varchar(500)
	 ,@CRID int
	,@CRTemplateDtlsID int NULL
	,@SupportID int 
    ,@SysLandscapeID int NULL
	,@ClassificationID int
    ,@CategoryID int
    ,@CategoryTypID int
    ,@TaskName varchar(500) NULL
    ,@TaskDesc varchar(2000) NULL
    ,@Priority int NULL
    ,@IsActive bit
    ,@CreatedBy int 
	)
AS
BEGIN 
Declare @count int=0

BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select @count=count(CRTemplateID) from IT.CRTemplate where TemplateName=@TemplateName

	Select @count
	IF (@count=0)
	BEGIN 
		BEGIN TRANSACTION
	--	Print 'Inside'
			INSERT INTO [IT].[CRTemplate]
           ([SupportID]
           ,[CategoryID]
           ,[CategoryTypID]
           ,[TemplateName]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[ModifiedBy]
           ,[ModifiedDt])
			 VALUES
           (@SupportID
           ,@CategoryID
           ,@CategoryTypID
           ,@TemplateName
           ,@IsActive
           ,@CreatedBy
           ,getdate()
           ,@CreatedBy
           ,getdate())


			IF (@@ERROR<>'')
			BEGIN
				ROLLBACK TRANSACTION
				RETURN error_message()
			END
			COMMIT TRANSACTION
		
		--Insert into CR TEMPLATE DETAILS--
		Select @CRTemplateID=CRTemplateID from IT.CRTemplate where TemplateName=@TemplateName

		BEGIN TRANSACTION
		INSERT INTO [IT].[CRTemplateDtls]
				   ([CRTemplateID]
				   ,[SysLandscapeID]
				   ,[CategoryID]
				   ,[CategoryTypID]
				   ,[TaskName]
				   ,[TaskDesc]
				   ,[Priority]
				   ,[IsActive]
				   ,[CreatedBy]
				   ,[CreatedDt]
				   ,[ModifiedBy]
				   ,[ModifiedDt])
			 Select
				   @CRTemplateID
				   ,sysl.SysLandscapeID
				   ,@CategoryID
				   ,@CategoryTypID
				   ,CRE.ExecutionStepName
				   ,CRE.ExecutionStepDesc
				   ,sysl.PriorityNum
				   ,@IsActive
				   ,@CreatedBy
				   ,getdate()
				   ,@CreatedBy
				   ,getdate() from IT.CRExecutionPlan CRE 
				   inner join IT.SysLandscape sysl on sysl.SysLandscapeID=CRE.SysLandscape
				   where CRE.ITCRID=@CRID

		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()

	 
	
	END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_CRTemplateExecPlan]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_CRTemplateExecPlan](
	@Flag Char(1)
	,@CRTemplateID int
	,@CRID int
	,@CreatedBy int 
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @count int=0
	Select @count=count(ITCRID) from IT.CRExecutionPlan where ITCRID=@CRID

	
	IF (@count=0)
	BEGIN 
		BEGIN TRANSACTION
		Print 'Inside'
	
		INSERT INTO [IT].[CRExecutionPlan]
			   ([ITCRID]
			   ,[SysLandscape]
			   ,[ExecutionStepName]
			   ,[ExecutionStepDesc]
			   ,[CreatedBy]
			   ,[CreatedDt]
			   ,[ModifiedBy]
			   ,[ModifiedDt])
			  
		Select
				@CRID	  
				,tmpl.SysLandscapeID
				,tmpl.TaskName
				,tmpl.TaskDesc
				,@CreatedBy
				,getdate()
				,@CreatedBy
				,getdate()
				 from  [IT].[CRTemplateDtls]  tmpl
				where tmpl.CRTemplateID=@CRTemplateID

				IF (@@ERROR<>'')
				Begin
					ROLLBACK TRANSACTION
					return
				End
				
			COMMIT TRANSACTION
		END


	Select @count=count(ITCRID) from IT.CRExecutionPlan where ITCRID=@CRID
		
	
	If (@count>0)
	BEGIN
		BEGIN TRANSACTION

			UPDATE IT.ChangeRequest set Stage='Implementation', [Status]='Implement', ModifiedBy=@CreatedBy, ModifiedDt=getdate() where ITCRID=@CRID
		
		COMMIT TRANSACTION
		
	END
	

	END TRY
	
	BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
	END CATCH
END

GO
/****** Object:  StoredProcedure [IT].[sp_EmployeeMaster]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_EmployeeMaster](
	@Flag [char](1)
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag='V'   -- Delete CR Approver Field
	BEGIN
		select Employee_ID,Email,First_Name,Middle_Name,Last_Name,Img_Url,Designation,DOL,DOB from Employee_Master where isactive=1 and FK_Department=12
		
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('CRExecutionPlan Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_GetApprover]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_GetApprover](
	@Level [int],
	@stage [char](1) ,
	@plantid [int],
	@categoryid [int],
	@classificationid[int])
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select apv.ITApproverID, @stage stage,
	apv.Approver1,concat(sta1.First_Name,'',sta1.Middle_Name,' ',sta1.Last_Name,' (',sta1.EmpID,')')  Approver1Name,
	apv.Approver2,concat(sta2.First_Name,'',sta2.Middle_Name ,' ',sta2.Last_Name,' (',sta2.EmpID,')') Approver2Name,
	apv.Approver3,concat(sta3.First_Name,'',sta3.Middle_Name ,' ',sta3.Last_Name,' (',sta3.EmpID,')') Approver3Name,
	(select (count(Level)) from [IT].[Approver] where Approverstage=@stage and plantid=@plantid and CategoryID=@categoryid and ClassificationID=@classificationid and SupportID=1) as ApproverCount
	from IT.Approver apv
	inner join IT.SupportTeam sta1 on sta1.SupportTeamID=apv.Approver1 
	LEFT join IT.SupportTeam sta2 on sta2.SupportTeamID=apv.Approver2 
	Left join IT.SupportTeam sta3 on sta3.SupportTeamID=apv.Approver3 
	where apv.SupportID=1 and apv.Level=@Level and apv.Approverstage=@stage and plantid=@plantid and apv.ClassificationID=@classificationid and apv.CategoryID=@categoryid

	return
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_GetApproverforEmail]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_GetApproverforEmail](
	@stage [char](1) ,
	@plantid [int],
	@categoryid [int],
	@classificationid[int])
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select apv.level,apv.approverstage
	,apv.Approver1,concat(sta1.First_Name,'',sta1.Middle_Name,' ',sta1.Last_Name) Approver1Name,sta1.EmpID EmpID1,sta1.Email Approver1Email
	,apv.Approver2,concat(sta2.First_Name,'',sta2.Middle_Name ,' ',sta2.Last_Name) Approver2Name,sta2.EmpID EmpID2,sta2.Email Approver2Email
	,apv.Approver3,concat(sta3.First_Name,'',sta3.Middle_Name ,' ',sta3.Last_Name) Approver3Name,sta3.EmpID EmpID3,sta3.Email Approver3Email
	from IT.Approver apv
	inner join IT.SupportTeam sta1 on sta1.SupportTeamID=apv.Approver1 
	LEFT join IT.SupportTeam sta2 on sta2.SupportTeamID=apv.Approver2 
	Left join IT.SupportTeam sta3 on sta3.SupportTeamID=apv.Approver3 
	where apv.SupportID=1 and plantid=@plantid and apv.ClassificationID=@classificationid and apv.CategoryID=@categoryid and APV.LEVEL=1 and apv.approverstage=@stage
	Union All
	select apv.level,apv.approverstage
	,apv.Approver1,concat(sta1.First_Name,'',sta1.Middle_Name,' ',sta1.Last_Name) Approver1Name,sta1.EmpID EmpID1,sta1.Email Approver1Email
	,apv.Approver2,concat(sta2.First_Name,'',sta2.Middle_Name ,' ',sta2.Last_Name) Approver2Name,sta2.EmpID EmpID2,sta2.Email Approver2Email
	,apv.Approver3,concat(sta3.First_Name,'',sta3.Middle_Name ,' ',sta3.Last_Name) Approver3Name,sta3.EmpID EmpID3,sta3.Email Approver3Email
	from IT.Approver apv
	inner join IT.SupportTeam sta1 on sta1.SupportTeamID=apv.Approver1 
	LEFT join IT.SupportTeam sta2 on sta2.SupportTeamID=apv.Approver2 
	Left join IT.SupportTeam sta3 on sta3.SupportTeamID=apv.Approver3 
	where apv.SupportID=1 and plantid=@plantid and apv.ClassificationID=@classificationid and apv.CategoryID=@categoryid and APV.LEVEL=2 and apv.approverstage=@stage
	Union All
	select apv.level,apv.approverstage
	,apv.Approver1,concat(sta1.First_Name,'',sta1.Middle_Name,' ',sta1.Last_Name) Approver1Name,sta1.EmpID EmpID1,sta1.Email Approver1Email
	,apv.Approver2,concat(sta2.First_Name,'',sta2.Middle_Name ,' ',sta2.Last_Name) Approver2Name,sta2.EmpID EmpID2,sta2.Email Approver2Email
	,apv.Approver3,concat(sta3.First_Name,'',sta3.Middle_Name ,' ',sta3.Last_Name) Approver3Name,sta3.EmpID EmpID3,sta3.Email Approver3Email
	from IT.Approver apv
	inner join IT.SupportTeam sta1 on sta1.SupportTeamID=apv.Approver1 
	LEFT join IT.SupportTeam sta2 on sta2.SupportTeamID=apv.Approver2 
	Left join IT.SupportTeam sta3 on sta3.SupportTeamID=apv.Approver3 
	where apv.SupportID=1 and plantid=@plantid and apv.ClassificationID=@classificationid and apv.CategoryID=@categoryid and APV.LEVEL=3 and apv.approverstage=@stage

	return
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_GetCRHistory]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_GetCRHistory](
	@crid [int]
)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select 
	CR.CRHistoryDt,
	CR.ITCRID,
	CR.CRCode,
	'Change Request',
	CR.SupportID,
	CR.ClassifcationID,
	CR.CategoryID,
	CR.CROwner,
	CR.CRDate,
	CR.CRRequestedBy,
	CR.CRRequestedDt,
	CR.CRInitiatedFor,
	CR.Stage,
	CR.Status,
	CR.ReferenceID,
	CR.ReferenceTyp,
	CR.CategoryTypeID,
	CR.NatureOfChange,
	CR.PriorityType,
	CR.PlantID,
	CR.GXPClassification,
	CR.ChangeControlNo,
	CR.ChangeControlDt,
	CR.ChangeControlAttach,
	CR.ChangeDesc,
	CR.ReasonForChange,
	CR.AlternateConsidetation,
	CR.ImpactNotDoing,
	CR.BusinessImpact,
	CR.TriggeredBy,
	CR.Benefits,
	CR.EstimatedCost,
	CR.EstimatedCostCurr,
	CR.EstimatedEffort,
	CR.EstimatedEffortUnit,
	CR.EstimatedDateCompletion,
	CR.RollbackPlan,
	CR.BackoutPlan,
	CR.DownTimeRequired,
	CR.DownTimeFromDate,
	CR.DownTimeToDate,
	CR.ImpactedLocation,
	CR.ImpactedDept,
	CR.ImactedFunc,
	CR.ApprovedBy,
	CR.ApprovedDt,
	CR.isSubmitted,
	CR.isApproved,
	CR.isImplemented,
	CR.isReleased,
	CR.ClosedStatus,
	CR.ClosureRemarks,
	CR.ClosedBy,
	CR.ClosedDt,
	CR.Feedback,
	CR.Remarks,
	CR.CreatedBy,
	CR.ModifiedDt FROM it.ChangeRequestHistory AS CR WHERE CR.ITCRID=@crid

	return
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_IssueAssigned]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_IssueAssigned](
	@Flag [char](1),
	@IssueID [int] NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@Status [varchar](50) NULL
	--@CreatedBy [int] NULL,
	--@CreatedDt [datetime] NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[IssueList] SET
				[AssignedTo]=@AssignedTo,
				[AssignedBy]=@AssignedBy,
				[AssignedOn]=getdate(),
				[ModifiedBy]=@AssignedBy,
				[ModifiedDt]=getdate(),
				[Status]=@Status
			WHERE IssueID=@IssueID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('IssueList Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_IssueForwardTo]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_IssueForwardTo](
	@Flag [char](1),
	@IssueID [int] NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Status [varchar](50),
	@ResolutionRemarks [nvarchar](3000) NULL

	--@CreatedBy [int] NULL,
	--@CreatedDt [datetime] NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[IssueList] SET
				[AssignedTo]=@AssignedTo,
				[AssignedBy]=@AssignedBy,
				[AssignedOn]=getdate(),
				[ModifiedBy]=@AssignedBy,
				[ModifiedDt]=getdate(),
				[Status]=@Status,
				[ResolutionRemarks]=ResolutionRemarks,
				[ResolutionDt]=getdate()
			WHERE IssueID=@IssueID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('IssueList Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_IssueList]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_IssueList](
	@Flag [char](1),
	@IssueID [int] NULL Output, 
	@IssueSelectedfor [nvarchar](200) NULL,
	@IssueRaisedBy [int] NULL,
	@IssueDate [datetime],
	@IssueShotDesc [nvarchar](200),
	@IssueDesc [nvarchar](Max),
	@IssueRaiseFor [int] NULL,
	@IssueForGuest [nvarchar](500) NULL,
	@GuestEmployeeId [nvarchar](500) NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [varchar](20) NULL,
	@GuestReportingManagerEmployeeId [nvarchar](200) NULL,
    @Type [nvarchar](50) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@ResolutionDt [datetime] NULL,
	@ReasonID [int] NULL,
	@CreatedBy [int] NULL,
	@CreatedDt [datetime] NULL,
	@ModifiedBy [int] NULL,
	@ModifiedDt [datetime] NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Declare
@PlantCode  varchar(6),
@IssueCode varchar(20),
@MaxCount varchar(4),
@Year varchar(4),
@return_value varchar(20),
@err_num int,
@err_msg varchar(100)

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		select @PlantCode= Code from dbo.Plant_Master where id=@PlantID
		select @MaxCount = count(IssueID)+1 from [IT].[IssueList]
		select @Year=DATEPART(year, getdate())
	    select @IssueCode= CONCAT (@PlantCode,'/IS/',@Year,'/',@MaxCount)
		BEGIN TRANSACTION

			
			INSERT INTO [IT].[IssueList] (
			[IssueCode],
			[IssueSelectedfor],
			[IssueRaisedBy],
			[IssueDate],
			[IssueShotDesc],
			[IssueDesc],
			[IssueRaiseFor],
			[IssueForGuest],
			[GuestEmployeeId],
			[GuestName],
			[GuestEmail],
			[GuestContactNo],
			[GuestReportingManagerEmployeeId],
			[Type],
			[GuestCompany],
			[PlantID],
			[AssetID],
			[CategoryID],
			[CategoryTypID],
			[Priority],
			[Source],
			[Attachment],
			[Status],
			[AssignedTo],
			[AssignedBy],
			[AssignedOn],
			[Remarks],
			[ProposedResolutionOn],
			[ReasonID],
			[CreatedBy],
			[CreatedDt],
			[ModifiedBy],
			[ModifiedDt]
			
		 )
			VALUES (
			ltrim(rtrim(@IssueCode)),
			@IssueSelectedfor,
			@IssueRaisedBy,
			getdate(),
			@IssueShotDesc,
			@IssueDesc,
			@IssueRaiseFor,
			@IssueForGuest,
			@GuestEmployeeId,
			@GuestName,
			@GuestEmail,
			@GuestContactNo,
			@GuestReportingManagerEmployeeId,
			@Type,
			@GuestCompany,
			@PlantID,
			@AssetID,
			@CategoryID,
			@CategoryTypID,
			@Priority,
			@Source,
			@Attachment,
			@Status,
			@AssignedTo,
			@AssignedBy,
			getdate(),
			@Remarks,
			@ProposedResolutionOn,
			@ReasonID,
			@CreatedBy,
			getdate(),
			@ModifiedBy,
			getdate()
			
			)
			SET @IssueID = SCOPE_IDENTITY();
		COMMIT TRANSACTION
	END
		
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[IssueList] SET
				[IssueRaisedBy]=@IssueRaisedBy,
				[IssueDate]=getdate(),
				[IssueShotDesc]=@IssueShotDesc,
				[IssueDesc]=@IssueDesc,
				[IssueRaiseFor]=@IssueRaiseFor,
				[IssueSelectedfor]=@IssueSelectedfor,
				[IssueForGuest]=@IssueForGuest,
				[GuestCompany]=@GuestCompany,
				[GuestEmployeeId]=@GuestEmployeeId,
				[GuestName]=@GuestName,
				[GuestEmail]=@GuestEmail,
				[GuestContactNo]=@GuestContactNo,
				[GuestReportingManagerEmployeeId]=@GuestReportingManagerEmployeeId,
				[Type]=@Type,
				[PlantID]=@PlantID,
				[AssetID]=@AssetID,
				[CategoryID]=@CategoryID,
				[AssignedTo]=@AssignedTo,
				[AssignedBy]=@AssignedBy,
				[AssignedOn]=@AssignedOn,
				[CategoryTypID]=@CategoryTypID,
				[Priority]=@Priority,
				[Source]=@Source,
				[Attachment]=@Attachment,
				[Status]=@Status,
				[Remarks]=@Remarks,
				[ProposedResolutionOn]=@ProposedResolutionOn,
				[ResolutionDt]=@ResolutionDt,
				[ReasonID] = @ReasonID,
				[ModifiedBy]=@CreatedBy,
				[ModifiedDt]=getdate()
				
			WHERE IssueID=@IssueID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[IssueList] WHERE IssueID=@IssueID
		
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('IssueList Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_IssueResolution]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_IssueResolution](
	@Flag [char](1),
	@IssueID [int] NULL,
	@ProposedResolutionOn [datetime] NULL,
	@ResolutionDt [datetime] NULL,
	@ResolutionRemarks [nvarchar](3000) NULL,
	@Status [nvarchar](200) NULL,
	@CreatedBy [int] NULL,
	@CreatedDt [datetime] NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[IssueList] SET
				[ProposedResolutionOn]=getdate(),
				[ResolutionDt]=getdate(),
				[ResolutionRemarks]=@ResolutionRemarks,
				[Status] = @Status,
				[ModifiedBy]=@CreatedBy,
				[ModifiedDt]=getdate()
			WHERE IssueID=@IssueID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('IssueList Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_ITAssets]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_ITAssets](
	@Flag Char(1),
	@ITAssetID [int] NULL,
	@Requesttype [nvarchar](200) NULL,
	@RequestedBY [int] NULL,
	@RequestedFor [int] NULL,
	@SelectedFor [nvarchar](200) NULL,
	@PlantID [int] NULL,
	@SupportID [int] NULL,
	@EmpType [nvarchar](200) NULL,
	@Guest_Id [int] NULL,
	@Guest_Name [nvarchar](500) NULL,
	@Guest_Email [nvarchar](500) NULL,
	@Guest_RManagerId [int] NULL,
	@Guest_ContactNo [int] NULL,
	@Assettype [nvarchar](500) NULL,
	@Emp_Id [int] NULL,
	@GxpReq [nvarchar](200) NULL,
	@ExistingAsset [nvarchar](200) NULL,
	@AssetModel [nvarchar](500) NULL,
	@AssetSerialNo [nvarchar](300) NULL,
	@AssetsWarranty_EndDt [datetime] NULL,
	@SuggModel [nvarchar](200) NULL,
	@Specs_Requirements [nvarchar](200) NULL,
	@ApproximateINR [int] NULL,
	@Justification [nvarchar](200) NULL,
	@HOD_Approval [nvarchar](200) NULL,
	@IsActive [bit] NULL,
	@Status [nvarchar](200) NULL,
	@CreatedBy [int] NULL
	)
	
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @level int=0,
	@PlantCode  varchar(6),
	@AssetCode varchar(20),
	@MaxCount varchar(4),
	@Year varchar(4),
	@return_value varchar(20)

	IF @Flag = 'I' -- Insert SLA Fields
	BEGIN 
		select @PlantCode= Code from dbo.Plant_Master where id=@PlantID
		select @MaxCount = count(ITAssetID)+1 from [IT].[ITAssetDetails]
		select @Year=DATEPART(year, getdate())
	    select @AssetCode= CONCAT (@PlantCode,'/AS/',@Year,'/',@MaxCount)
		BEGIN TRANSACTION
			INSERT INTO [IT].[ITAssetDetails]
           (  [AssetCode]
		      ,[Requesttype]
			  ,[RequestedBY]
			  ,[RequestedFor]
			  ,[SelectedFor]
			  ,[EmpType]
			  ,[Guest_Id]
			  ,[Guest_Name]
			  ,[Guest_Email]
			  ,[Guest_RManagerId]
			  ,[Guest_ContactNo]
			  ,[Assettype]
			  ,[Emp_Id]
			  ,[SupportID]
			  ,[GxpReq]
			  ,[ExistingAsset]
			  ,[AssetModel]
			  ,[AssetSerialNo]
			  ,[AssetsWarranty_EndDt]
			  ,[SuggModel]
			  ,[Specs_Requirements]
			  ,[ApproximateINR]
			  ,[Justification]
			  ,[HOD_Approval]
			  ,[IsActive]
			  ,[Status]
			  ,[CreatedBy]
			  ,[CreatedDt]
			  ,[ModifiedBy]
			  ,[ModifiedDt]

			)
     VALUES
           (ltrim(rtrim(@AssetCode)) 
		    ,@Requesttype
			,@RequestedBY
			,@RequestedFor
			,@SelectedFor
			,@EmpType
			,@Guest_Id
			,@Guest_Name
			,@Guest_Email
			,@Guest_RManagerId
			,@Guest_ContactNo
			,@Assettype
			,@Emp_Id
			,@SupportID
			,@GxpReq
			,@ExistingAsset
			,@AssetModel
			,@AssetSerialNo
			,@AssetsWarranty_EndDt
			,@SuggModel
			,@Specs_Requirements
			,@ApproximateINR
			,@Justification
			,@HOD_Approval
			,@IsActive
			,@Status
			,@CreatedBy
			,getdate()
			,@CreatedBy
			,getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update SLA Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[ITAssetDetails] SET
			[Requesttype] =@Requesttype
			,[RequestedBY] =@RequestedBY
			,[RequestedFor] =@RequestedFor
			,[SelectedFor] = @SelectedFor
			,[EmpType] =@EmpType
			,[SupportID] =@SupportID
			,[Guest_Id] = @Guest_Id
			,[Guest_Name] = @Guest_Name
			,[Guest_Email] =@Guest_Email
			,[Guest_RManagerId] = @Guest_RManagerId
			,[Guest_ContactNo] = @Guest_ContactNo
			,[Assettype] = @Assettype
			,[Emp_Id] = @Emp_Id
			,[GxpReq] = @GxpReq
			,[ExistingAsset] = @ExistingAsset
			,[AssetModel] = @AssetModel
			,[AssetSerialNo] = @AssetSerialNo
			,[AssetsWarranty_EndDt] = @AssetsWarranty_EndDt
			,[SuggModel] = @SuggModel
			,[Specs_Requirements] = @Specs_Requirements
			,[ApproximateINR] = @ApproximateINR
			,[Justification] =@Justification
			,[HOD_Approval]=@HOD_Approval
			,[IsActive] = @IsActive
			,[Status] = @Status
			,[ModifiedBy] = @CreatedBy
			,[ModifiedDt] =GETDATE()
		
			WHERE ITAssetID=@ITAssetID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete SLA Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[ITAssetDetails] WHERE ITAssetID=@ITAssetID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()

	END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_ITSpare]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_ITSpare](
	@Flag Char(1),
	@ITSpareID [int] NULL,
	@SupportID [int] NULL,
	@Requesttype [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@RequestedBY [int] NULL,
	@RequestedFor [int] NULL,
	@SelectedFor [nvarchar](500) NULL,
	@Guest_Id [int] NULL,
	@Guest_Name [nvarchar](500) NULL,
	@Guest_Email [nvarchar](500) NULL,
	@Guest_RManagerId [int] NULL,
	@Guest_ContactNo [int] NULL,
	@EmpType [nvarchar](200) NULL,
	@Emp_Id [int] NULL,
	@GxpReq [nvarchar](200) NULL,
	@Asset_Type [nvarchar](300) NULL,
	@Spare_Type [nvarchar](500) NULL,
	@Spare_Model [nvarchar](500) NULL,
	@Spare_SerialNo [nvarchar](500) NULL,
	@Specs_Requirements [nvarchar](500) NULL,
	@Specification [nvarchar](max) NULL,
	@Justification [nvarchar](200) NULL,
	@HOD_Approval [nvarchar](500) NULL,
	@Status [nvarchar](500) NULL,
	@IsActive [bit] NULL,
	@CreatedBy [int] NULL
	)
	
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @level int=0,
	@PlantCode  varchar(6),
	@SpareCode varchar(20),
	@MaxCount varchar(4),
	@Year varchar(4),
	@return_value varchar(20)

	IF @Flag = 'I' -- Insert SLA Fields
	BEGIN 
		select @PlantCode= Code from dbo.Plant_Master where id=@PlantID
		select @MaxCount = count(ITSpareID)+1 from [IT].[ITSpare]
		select @Year=DATEPART(year, getdate())
	    select @SpareCode= CONCAT (@PlantCode,'/AS/',@Year,'/',@MaxCount)
		BEGIN TRANSACTION
			INSERT INTO [IT].[ITSpare]
           (
		   [ITSpareCode]
		   ,[Requesttype]
		   ,[SupportID]
		  ,[RequestedBY]
		  ,[RequestedFor]
		  ,[SelectedFor]
		  ,[Guest_Id]
		  ,[Guest_Name]
		  ,[Guest_Email]
		  ,[Guest_RManagerId]
		  ,[Guest_ContactNo]
		  ,[EmpType]
		  ,[Emp_Id]
		  ,[GxpReq]
		  ,[Asset_Type]
		  ,[Spare_Type]
		  ,[Spare_Model]
		  ,[Spare_SerialNo]
		  ,[Specs_Requirements]
		  ,[Specification]
		  ,[Justification]
		  ,[HOD_Approval]
		  ,[IsActive]
		  ,[Status]
		  ,[CreatedBy]
		  ,[CreatedDt]
		  ,[ModifiedBy]
		  ,[ModifiedDt]
			)
     VALUES
		   (ltrim(rtrim(@SpareCode)) 
			,@Requesttype
			,@SupportID
			,@RequestedBY
			,@RequestedFor
			,@SelectedFor
			,@Guest_Id
			,@Guest_Name
			,@Guest_Email
			,@Guest_RManagerId
			,@Guest_ContactNo
			,@EmpType
			,@Emp_Id
			,@GxpReq
			,@Asset_Type
			,@Spare_Type
			,@Spare_Model
			,@Spare_SerialNo
			,@Specs_Requirements
			,@Specification
	  		,@Justification
			,@HOD_Approval
			,@IsActive
			,@Status
			,@CreatedBy
			,GETDATE()
			,@CreatedBy
			,getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update SLA Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[ITSpare] SET
			[Requesttype] = @Requesttype
			,[SupportID] = @SupportID
			,[RequestedBY] = @RequestedBY
			,[RequestedFor] =@RequestedFor
			,[SelectedFor] = @SelectedFor
			,[Guest_Id] = @Guest_Id
			,[Guest_Name] = @Guest_Name
			,[Guest_Email] = @Guest_Email
			,[Guest_RManagerId] = @Guest_RManagerId
			,[Guest_ContactNo] = @Guest_ContactNo
			,[EmpType] = @EmpType
			,[Emp_Id] = @Emp_Id
			,[GxpReq] = @GxpReq
			,[Asset_Type] = @Asset_Type
			,[Spare_Type] =@Spare_Type
			,[Spare_Model] = @Spare_Model
			,[Spare_SerialNo] = @Spare_SerialNo
			,[Specs_Requirements] = @Specs_Requirements
			,[Specification] = @Specification
			,[Justification] = @Justification
			,[HOD_Approval] = @HOD_Approval
			,[IsActive] = @IsActive
			,[Status] =@Status
			,[ModifiedBy] =@CreatedBy
			,[ModifiedDt] = GETDATE()
		
			WHERE ITSpareID=@ITSpareID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete SLA Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[ITSpare] WHERE ITSpareID=@ITSpareID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()

	END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_Module]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_Module](
	@Flag [char](1),
	@SupportID [int] NULL,
	@SupportName nchar(500) NULL,
	@ParentID [int] NULL,
	@IsActive bit NULL,
	@CreatedBy int NULL,
	@CreatedDate datetime NULL,
	@UpdatedBy int NULL,
	@UpdatedDate datetime NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION

		
			INSERT INTO [IT].[Support] (
			[SupportName],
			[ParentID],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
		 )
			VALUES (
			@SupportName,
			@ParentID,
			@IsActive,
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[Support] SET
				[SupportName]=@SupportName,
				[ParentID]=@ParentID,
				[IsActive]=@IsActive,
				[UpdatedBy]=@UpdatedBy,
				[UpdatedDate]=getdate()
			WHERE SupportID=@SupportID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[Support] WHERE SupportID=@SupportID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Refrence Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_NatureofChange]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_NatureofChange](
	@Flag [char](1),
	@NatureofChangeID [int] NULL,
	@CategoryID [int] NULL,
	@NatureofChange[nvarchar](MAX) NULL,
	@IsActive [bit] NULL,
	@CreatedBy [int] NULL,
	@CreatedDate [datetime] NULL,
	@ModifiedBy [int] NULL,
	@ModifiedDate [datetime] NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION
		
		
			INSERT INTO [IT].[NatureofChange] (
			[CategoryID],
			[NatureofChange],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
		 )
			VALUES (
			@CategoryID,
			@NatureofChange,
			@IsActive,
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[NatureofChange] SET
				[CategoryID]=@CategoryID,
				[NatureofChange]=@NatureofChange,
				[IsActive]=@IsActive,
				[ModifiedBy]=@ModifiedBy,
				[ModifiedDate]=getdate()
			WHERE NatureofChangeID=@NatureofChangeID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag = 'D' -- Delete CR Approver Field
BEGIN
    BEGIN TRANSACTION
    -- Check if NatureofChangeID is linked in another table
    IF EXISTS (SELECT 1 FROM ChangeRequest WHERE NatureOfChange = @NatureofChangeID)
    BEGIN
        -- NatureofChangeID is linked, raise an error message
        ROLLBACK TRANSACTION
        RAISERROR('The NatureofChangeID is mapped in another table and cannot be deleted.', 16, 1)
        RETURN
    END
    ELSE
    BEGIN
        -- NatureofChangeID is not linked, proceed with deletion
        DELETE FROM [IT].[NatureofChange] WHERE NatureofChangeID = @NatureofChangeID
        COMMIT TRANSACTION
    END
END
ELSE
    RETURN ERROR_MESSAGE()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('NatureofChange Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_Priority]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_Priority](
	@Flag [char](1),
	@PriorityID [int] NULL,
	@PriorityName [nvarchar](MAX) NULL,
	@IsActive [bit] NULL,
	@CreatedBy [nchar](10) NULL,
	@CreatedDate [datetime] NULL,
	@UpdatedBy [nchar](10) NULL,
	@UpdatedDate [datetime] NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION
			INSERT INTO [IT].[Priority] (
			[PriorityName],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
		 )
			VALUES (
			@PriorityName,
			@IsActive,
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[Priority] SET
				[PriorityName]=@PriorityName,
				[IsActive]=@IsActive,
				[UpdatedBy]=@UpdatedBy,
				[UpdatedDate]=getdate()
			WHERE PriorityID=@PriorityID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[Priority] WHERE PriorityID=@PriorityID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Classification Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_projectmember]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [IT].[sp_projectmember](
	@Flag [char](1),
	@ProjMemberID [int]NULL,
	@ProjectMgmtID [int] NULL,
	@EmpID [int]NULL,
	@StartDt [datetime] NULL,
	@EndDt [datetime] NULL,
	@isResponsible [bit] NULL,
	@isAccountable [bit] NULL,
	@isConsulted [bit] NULL,
	@isInformed [bit] NULL,
	@IsActive [bit] NULL,
 	@CreatedBy [int] NULL,
	@CreatedDt [datetime] NULL,
	@ModifiedBy [int] NULL,
	@ModifiedDt [datetime] NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION
			INSERT INTO [IT].[ProjMember] (
			[ProjectMgmtID]
			,[EmpID]
			,[StartDt]
			,[EndDt]
			,[isResponsible]
			,[isAccountable]
			,[isConsulted]
			,[isInformed]
			,[IsActive]
			,[CreatedBy]
			,[CreatedDt]
			,[ModifiedBy]
			,[ModifiedDt]
		 )
			VALUES (
			@ProjectMgmtID,
			@EmpID,
			@StartDt,
			@EndDt,
			@isResponsible,
			@isAccountable,
			@isConsulted,
			@isInformed,
			@IsActive,
			@CreatedBy,
			getdate(),
			@ModifiedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_Projectmilestone]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================



CREATE PROCEDURE [IT].[sp_Projectmilestone](
	@Flag [char](1),
	@ProjMilestoneID [int]NULL,
	@ProjectMgmtID [int] NULL,
	@MilestoneTitle [nvarchar](MAX)NULL,
	@MilestoneDesc [nvarchar](MAX)NULL,
	@StartDt [datetime] NULL,
	@EndDt [datetime] NULL,
	@ActualStartDt [datetime] NULL,
	@ActualEndDt [datetime] NULL,
	@IsActive [bit] NULL,
	@CreatedBy [int] NULL,
	@CreatedDt [datetime] NULL,
	@ModifiedBy [int] NULL,
	@ModifiedDt [datetime] NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION
			INSERT INTO [IT].[ProjMilestone] (
		  [ProjectMgmtID]
		  ,[MilestoneTitle]
		  ,[MilestoneDesc]
		  ,[StartDt]
		  ,[EndDt]
		  ,[ActualStartDt]
		  ,[ActualEndDt]
		  ,[IsActive]
		  ,[CreatedBy]
		  ,[CreatedDt]
		  ,[ModifiedBy]
		  ,[ModifiedDt]
		 )
			VALUES (
			@ProjectMgmtID,
			@MilestoneTitle,
			@MilestoneDesc,
			@StartDt,
			@EndDt,
			@ActualStartDt,
			@ActualEndDt,
			@IsActive,
			@CreatedBy,
			getdate(),
			@ModifiedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Category Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_ServiceCitrix]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_ServiceCitrix](
	@Flag Char,
	@ServiceCitrixID int,
	@RaisedBy int,
	@SRDate datetime,
	@ShotDesc nvarchar(200),
	@SRDesc nvarchar(2000),
	@SRRaiseFor int NULL,
	@PlantID int NULL,
	@AssetID int NULL,
	@CategoryID int NULL,
	@CategoryTypID int NULL,
	@Priority int NULL,
	@Source nvarchar(100) NULL,
	@Service nvarchar (50) NULL,
	@Attachment nvarchar(100) NULL,
	@Status nvarchar(10) NULL,
	@CreatedBy int
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Declare
@PlantCode  varchar(6),
@ServiceCode varchar(20),
@MaxCount varchar(4),
@Year varchar(4),
@return_value varchar(20)

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		select @PlantCode= Code from dbo.Plant_Master where id=@PlantID
		select @MaxCount = count(IssueID)+1 from [IT].[IssueList]
		select @Year=DATEPART(year, getdate())
	    select @ServiceCode= CONCAT (@PlantCode,'/',@Year,'/',@MaxCount)
		BEGIN TRANSACTION
		
			INSERT INTO [IT].[ServiceCitrix] (
			[ServiceCode],
			[RaisedBy],
			[SRDate],
			[ShotDesc],
			[SRDesc],
			[SRRaiseFor],
			[PlantID],
			[AssetID],
			[CategoryID],
			[CategoryTypID],
			[Priority],
			[Source],
			[Service],
			[Attachment],
			[Status],
			[CreatedBy],
			[CreatedDt]
		 )
			VALUES (
			ltrim(rtrim(@ServiceCode)),
			@RaisedBy,
			GETDATE(),
			@ShotDesc,
			@SRDesc,
			@SRRaiseFor,
			@PlantID,
			@AssetID,
			@CategoryID,
			@CategoryTypID,				
			@Priority,
			@Source,
			@Service,
			@Attachment,
			@Status,
			@CreatedBy,
			getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[ServiceCitrix] SET
				RaisedBy = @RaisedBy,
				SRDate = GETDATE(),
				ShotDesc = @ShotDesc,
				SRDesc = @SRDesc,
				SRRaiseFor = @SRRaiseFor,
				PlantID = @PlantID,
				AssetID =@AssetID,
				CategoryID =@CategoryID,
				CategoryTypID =@CategoryTypID,
				[Priority] =@Priority,
				[Source] =@Source,
				[Service]=@Service,
				Attachment =@Attachment,
				[Status] =@Status,
				ModifiedBy=@CreatedBy,
				ModifiedDt=getdate() 
			WHERE ServiceCitrixID=@ServiceCitrixID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[ServiceCitrix] WHERE ServiceCitrixID =  @ServiceCitrixID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('IssueList Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_ServiceCitrixApp]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_ServiceCitrixApp](
	@Flag [char](1),
	@ServiceCitrixID [int] NULL,
	@ApprovedLevel1 [int] NULL,
	@ApprovedLevel1By [int] NULL,
	@ApprovedLevel1On [datetime] NULL,
	@ApprovedLevel2 [int] NULL,
	@ApprovedLevel2By [int] NULL,
	@ApprovedLevel2On [datetime] NULL,
	@ApprovedLevel3 [int] NULL,
	@ApprovedLevel3By [int] NULL,
	@ApprovedLevel3On [datetime] NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ModifiedBy [int] NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[ServiceCitrix] SET
				[ApprovedLevel1]=@ApprovedLevel1,
				[ApprovedLevel1By]=@ApprovedLevel1By,
				[ApprovedLevel1On]=getdate(),
				[ApprovedLevel2]=@ApprovedLevel2,
				[ApprovedLevel2By]=@ApprovedLevel2By,
				[ApprovedLevel2On]=getdate(),
				[ApprovedLevel3]=@ApprovedLevel3,
				[ApprovedLevel3By]=@ApprovedLevel3By,
				[ApprovedLevel3On]=getdate(),
				[AssignedTo]=@AssignedTo,
				[AssignedBy]=@AssignedBy,
				[AssignedOn]=getdate(),
				[Remarks]=@Remarks,
				[ModifiedBy]=@ModifiedBy,
				[ModifiedDt]=getdate()
			WHERE ServiceCitrixID=@ServiceCitrixID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('IssueList Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_ServiceCitrixRes]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_ServiceCitrixRes](
	@Flag [char](1),
	@ServiceCitrixID [int] NULL,
	@ProposedResolutionOn [datetime] NULL,	
	@ResolutionDt [datetime] NULL,
	@ResolutionRemarks [nvarchar](3000) NULL,
	@Remarks [nvarchar](3000) NULL,
	@ModifiedBy [int] NULL,
	@ModifiedDt [datetime] NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[ServiceCitrix] SET
				[ProposedResolutionOn]=getdate(),
				[ResolutionDt]=getdate(),
				[ResolutionRemarks]=@ResolutionRemarks,
				[Remarks]=@Remarks,
				[ModifiedBy]=@ModifiedBy,
				[ModifiedDt]=getdate()
			WHERE ServiceCitrixID=@ServiceCitrixID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('IssueList Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_ServiceRequest]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_ServiceRequest](
	@Flag [char](1),
	@SRID [int] OUTPUT,
	@SRCode [nvarchar](200) NULL, 
	@SupportID [int],
	@SRRaisedBy [int]  NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [varchar](20) NULL,
	@GuestReportingManagerEmployeeId [nvarchar](200) NULL,
    @Type [nvarchar] NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Declare
@PlantCode  varchar(6),
@MaxCount varchar(4),
@Year varchar(4),
@return_value varchar(20)

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		
		BEGIN TRANSACTION
			INSERT INTO [IT].[ServiceRequest] (
			[SRCode],
			[SupportID],
			[SRRaisedBy] ,
			[SRDate] ,
			[SRShotDesc] ,
			[SRDesc] ,
			[SRRaiseFor] ,
			[SRSelectedfor],
			[GuestEmployeeId],
			[GuestName],
			[GuestEmail],
			[GuestContactNo],
			[GuestReportingManagerEmployeeId],
			[Type],
			[GuestCompany],
			[PlantID],
			[AssetID],
			[CategoryID],
			[CategoryTypID],
			[Priority],
			[Source],
			[Attachment],
			[Status],
			[AssignedTo],
			[AssignedBy],
			[AssignedOn],
			[Remarks],
			[ProposedResolutionOn],
			[CreatedBy],
			[CreatedDt],
			[ModifiedBy],
			[ModifiedDt]
		 )
			VALUES (
			ltrim(rtrim(@SRCode)),
			@SupportID,
			@SRRaisedBy,
			getdate(),
			@SRShotDesc,
			@SRDesc,
			@SRRaiseFor,
			@SRSelectedfor,
			@GuestEmployeeId,
			@GuestName,
			@GuestEmail,
			@GuestContactNo,
			@GuestReportingManagerEmployeeId,
			@Type,
			@GuestCompany,
			@PlantID,
			@AssetID,
			@CategoryID,
			@CategoryTypID,
			@Priority,
			@Source,
			@Attachment,
			@Status,
			@AssignedTo,
			@AssignedBy,
			getdate(),
			@Remarks,
			@ProposedResolutionOn,
			@CreatedBy,
			getdate(),
			@CreatedBy,
			getdate()
			)
			SELECT @SRID = SCOPE_IDENTITY();
		COMMIT TRANSACTION
	END
		
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[ServiceRequest] SET
				[SRRaisedBy]=@SRRaisedBy,
				[SRDate]=getdate(),
				[SRShotDesc]=@SRShotDesc,
				[SRDesc]=@SRDesc,
				[SRRaiseFor]=@SRRaiseFor,
				[GuestCompany]=@GuestCompany,
				[GuestEmployeeId]=@GuestEmployeeId,
				[GuestName]=@GuestName,
				[GuestEmail]=@GuestEmail,
				[GuestContactNo]=@GuestContactNo,
				[GuestReportingManagerEmployeeId]=@GuestReportingManagerEmployeeId,
				[Type]=@Type,
				[PlantID]=@PlantID,
				[AssetID]=@AssetID,
				[CategoryID]=@CategoryID,
				[AssignedTo]=@AssignedTo,
				[AssignedBy]=@AssignedBy,
				[AssignedOn]=@AssignedOn,
				[CategoryTypID]=@CategoryTypID,
				[Priority]=@Priority,
				[Source]=@Source,
				[Attachment]=@Attachment,
				[Status]=@Status,
				[Remarks]=@Remarks,
				[ModifiedBy]=@CreatedBy,
				[ModifiedDt]=getdate(),
				[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID=@SRID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[ServiceRequest] WHERE SRID=@SRID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('ServiceRequest Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SLA]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SLA](
	 @Flag Char(1)
	,@ITSLAID int
	,@CategoryID int
	,@ClassificationID int
	,@CategoryTypID int
	,@SupportID int
	,@WaitTime int
	,@WaitTimeUnit varchar(50)
	,@AssignedTo int
	,@PlantID int
	,@Escalation1 int
	,@WaitTimeEscal1 int
	,@WaitTimeUnitEscal1 varchar(50)
	,@Escalation2 int
	,@WaitTimeEscal2 int
	,@WaitTimeUnitEscal2 varchar(50)
	,@CreatedBy int NULL)
	
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @level int=0

	IF @Flag = 'I' -- Insert SLA Fields
	BEGIN 
		BEGIN TRANSACTION
			INSERT INTO [IT].[SLA]
           ([CategoryID]
           ,[ClassificationID]
		   ,[CategoryTypID]
           ,[SupportID]
           ,[WaitTime]
           ,[WaitTimeUnit]
           ,[AssignedTo]
           ,[PlantID]
           ,[Escalation1]
           ,[WaitTimeEscal1]
           ,[WaitTimeUnitEscal1]
           ,[Escalation2]
           ,[WaitTimeEscal2]
           ,[WaitTimeUnitEscal2]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[ModifiedBy]
           ,[ModifiedDt])
     VALUES
           ( @CategoryID 
			,@ClassificationID 
			,@CategoryTypID 
			,@SupportID 
			,@WaitTime 
			,@WaitTimeUnit
			,@AssignedTo
			,@PlantID
			,@Escalation1
			,@WaitTimeEscal1
			,@WaitTimeUnitEscal1
			,@Escalation2
			,@WaitTimeEscal2
			,@WaitTimeUnitEscal2
			,@CreatedBy
			,getdate()
			,@CreatedBy
			,getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update SLA Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[SLA] SET
			 CategoryID = @CategoryID 
			,ClassificationID = @ClassificationID 
			,CategoryTypID=@CategoryTypID 
			,SupportID= @SupportID 
			,WaitTime=@WaitTime 
			,WaitTimeUnit=@WaitTimeUnit
			,AssignedTo=@AssignedTo
			,PlantID=@PlantID
			,Escalation1=@Escalation1
			,WaitTimeEscal1=@WaitTimeEscal1
			,WaitTimeUnitEscal1=@WaitTimeUnitEscal1
			,Escalation2=@Escalation2
			,WaitTimeEscal2=@WaitTimeEscal2
			,WaitTimeUnitEscal2=@WaitTimeUnitEscal2
			,ModifiedBy=@CreatedBy
			,ModifiedDt=getdate()
		
			WHERE ITSLAID=@ITSLAID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete SLA Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[SLA] WHERE ITSLAID=@ITSLAID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()

	END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SRAccess]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRAccessID [int] NULL,
	@RequestType [nvarchar](200) NULL,
	@SupportID [int] NULL,
	@SoftName [nvarchar](200) NULL,
	@SoftVersion [nvarchar](max) NULL,
	@ReferDocument [nvarchar](max) NULL,
	@DORemovalAccess [datetime] NULL,
	@SWRemoved [bit] NULL,
	@ServerAccess [bit] NULL,
	@KindAccess [nvarchar](200) NULL,
	@DowntimeRequired [nvarchar](200) NULL,
	@TypeServerAccess [nvarchar](200) NULL,
	@IPDetails [nvarchar](max) NULL,
	@VenderName [nvarchar](200) NULL,
	@VenderFocalName [nvarchar](200) NULL,
	@VenderFocalEmailID [nvarchar](200) NULL,
	@AccessStartTime [datetime] NULL,
	@AccessEndTime [datetime] NULL,
	@Justification [nvarchar](max) NULL,
	@ReferenceDocument [nvarchar](max) NULL,
	@DORemoteAccess [datetime] NULL,
	@IsActive [bit] NULL,
    
	---- Service Request
	@SRCode [nvarchar](200),
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar](200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert SRDomain Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@SRSelectedfor = @SRSelectedfor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRAccess] (
					 [SRID]
					,[SupportID]
					,[RequestType]
					,[SoftName]
					,[SoftVersion]
					,[ReferDocument]
					,[DORemovalAccess]
					,[SWRemoved]
					,[ServerAccess]
					,[KindAccess]
					,[DowntimeRequired]
					,[TypeServerAccess]
					,[IPDetails]
					,[VenderName]
					,[VenderFocalName]
					,[VenderFocalEmailID]
					,[AccessStartTime]
					,[AccessEndTime]
					,[Justification]
					,[ReferenceDocument]
					,[DORemoteAccess]
					,[Attachment]
					,[IsActive]
					,[CreatedBy]
					,[CreatedDt]
					,[ModifiedBy]
					,[ModifiedDt]
                )
				
                VALUES (
					     @SRID
						,@SupportID
						,@RequestType
						,@SoftName
						,@SoftVersion
						,@ReferDocument
						,@DORemovalAccess
						,@SWRemoved
						,@ServerAccess
						,@KindAccess
						,@DowntimeRequired
						,@TypeServerAccess
						,@IPDetails
						,@VenderName
						,@VenderFocalName
						,@VenderFocalEmailID
						,@AccessStartTime
						,@AccessEndTime
						,@Justification
						,@ReferenceDocument
						,@DORemoteAccess
						,@Attachment
						,@IsActive
						,@CreatedBy
						,GETDATE()
						,@CreatedBy
						,GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRDomain Fields
        BEGIN
            BEGIN TRANSACTION;

				UPDATE [IT].[SRAccess]
            
				  set[SRID] = @SRID,
				 [SupportID] = @SupportID,
				 [RequestType] = @RequestType,
				 [SoftName] = @SoftName,
				 [SoftVersion] = @SoftVersion,
				 [ReferDocument] = @ReferDocument,
				 [DORemovalAccess] = @DORemovalAccess,
				 [SWRemoved] = @SWRemoved,
				 [ServerAccess] = @ServerAccess,
				 [KindAccess] = @KindAccess,
				 [DowntimeRequired] = @DowntimeRequired,
				 [TypeServerAccess] = @TypeServerAccess,
				 [IPDetails] = @IPDetails,
				 [VenderName] = @VenderName,
				 [VenderFocalName] = @VenderFocalName,
				 [VenderFocalEmailID] = @VenderFocalEmailID,
				 [AccessStartTime] = @AccessStartTime,
				 [AccessEndTime] = @AccessEndTime,
				 [Justification] = @Justification,
				 [ReferenceDocument] = @ReferenceDocument,
				 [DORemoteAccess] = @DORemoteAccess,
				 [Attachment] = @Attachment,
				 [IsActive] = @IsActive,
				 [ModifiedBy] = @CreatedBy,
				 [ModifiedDt] = GETDATE()
			WHERE SRID = @SRID;
			update [IT].ServiceRequest set
			[SupportID]=@SupportID,
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRDomain Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRAccess] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('SRAccess Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRAntivirus]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SRAntivirus]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRAVID [int] NULL,
	@SupportID [int] NULL,
	@RequestType [nvarchar](200) NULL,
	@InstallDts [nvarchar](200) NULL,
	@UninstallDts [nvarchar](200) NULL,
	@ExcDts [nvarchar](200) NULL,
	@IncDts [nvarchar](200) NULL,
	@Description [nvarchar](200) NULL,
	@IsActive [nvarchar] (200) NULL,
    
	@SRCode [nvarchar](200)  NULL, 
	@SRSelectedfor [nvarchar](200) NULL,
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;
        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);
        IF @Flag = 'I' -- Insert SRVirtual Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRSelectedfor = @SRSelectedfor,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
					select @err_msg='Insert failed'
					raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
					Return;
				End
            BEGIN
                INSERT INTO [IT].[SRAntivirus] (
					  [SRID]
					  ,[SupportID]
					  ,[RequestType]
					  ,[InstallDts]
					  ,[UninstallDts]
					  ,[ExcDts]
					  ,[IncDts]
					  ,[Attachment]
					  ,[Description]
					  ,[IsActive]
					  ,[CreatedBy]
					  ,[CreatedDt]
				  )
				  VALUES (
					       @SRID
						  ,@SupportID
						  ,@RequestType
						  ,@InstallDts
						  ,@UninstallDts
						  ,@ExcDts
						  ,@IncDts
						  ,@Attachment
						  ,@Description
						  ,@IsActive
						  ,@CreatedBy
						  ,GetDate()
						);
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRVirtual Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRAntivirus]
            SET
				         [SRID] = @SRID
						,[SupportID] = @SupportID
						,[RequestType] = @RequestType
						,[InstallDts] = @InstallDts
						,[UninstallDts] =@UninstallDts
						,[ExcDts] = @ExcDts
						,[IncDts] = @IncDts
						,[Attachment] =@Attachment
						,[Description] =@Description
						,[IsActive] = @IsActive
						,[ModifiedBy] = @CreatedBy
						,[ModifiedDt] = GETDATE()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
			[SupportID]=@SupportID,
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRVirtual Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRAntivirus] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;

            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('SRAntivirus Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRApprover]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SRApprover](
	@Flag Char(1),
	@SRApproverID [int] NULL,
	@PlantID [int],
	@SupportID [int],
	@SRID [int] ,
	@ApproverLevel [int],
	@Stage [varchar](150) NULL,
	@ApproverID [int],
	--@ApprovedDt [datetime],
	@Remarks [varchar](2000) NULL,
	@Status [varchar](150),
	@Attachment [varchar](2000) NULL,
	@CreatedBy int NULL,
	@CreatedDt [datetime] ,
	@ModifiedBy int NULL,
	@ModifiedDt [datetime] NULL)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @level int=0

	IF @Flag = 'I' -- Insert SR Approver Fields
	BEGIN 
		BEGIN TRANSACTION
			INSERT INTO [IT].[SRApprover] (
			[PlantID],
			[SupportID],
			[SRID],
			[ApproverLevel],
			[Stage],
			[ApproverID],
			[ApprovedDt],
			[Remarks],
			[Status],
			[Attachment],
			[CreatedBy],
			[CreatedDt],
			[ModifiedBy],
			[ModifiedDt])
			VALUES (
				@PlantID,
				@SupportID,
				@SRID,
				@ApproverLevel,
				@Stage,
				@ApproverID,
				getdate(),				
				@Remarks,
				@Status,
				@Attachment,
				@CreatedBy,
				getdate(),
				@ModifiedBy,
				getdate()
			)
			UPDATE [IT].[ServiceRequest]
			SET [Status] = @Status,
				ModifiedBy = @ModifiedBy,
				ModifiedDt = getdate()
			WHERE SRID = @SRID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update SR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[SRApprover] SET
				PlantID=@PlantID,
				SupportID=@SupportID,
				SRID=@SRID,
				ApproverLevel=@ApproverLevel,
				Stage=@Stage,
				ApproverID=@ApproverID,
				ApprovedDt=getdate(),
				Remarks=@Remarks,
				Status=@Status,
				Attachment=@Attachment,
				ModifiedBy=@CreatedBy,
				ModifiedDt=getdate()
			WHERE SRApproverID=@SRApproverID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[SRApprover] WHERE SRApproverID=@SRApproverID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
	
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRCitrixAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [IT].[sp_SRCitrixAccess]
(
	@Flag [char](1),
	@SRCID  [int],
    @SRID [int] OUTPUT,
    @SupportID [int] NULL,
	@RequestType [nvarchar](100) NULL,
	@ADID [int] NULL,
	@ReplaceADID [int] NULL,
	@AssetDetails [nvarchar](max) NULL,
	@IPAddress [nvarchar](200) NULL,
	@HostName [nvarchar](200) NULL,
	@SoftwareRequired [nvarchar](200) NULL,
	@EmpType [nvarchar](200) NULL,
	@Justification [nvarchar](200) NULL,
	@OUPath [nvarchar](200) NULL,
	@IsActive [bit] NULL,
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert CR Release Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@SRSelectedfor =@SRSelectedfor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRCitrixAccess] (
					   [SRID]
                      ,[SupportID]
					  ,[RequestType]
					  ,[ADID]
					  ,[ReplaceADID]
					  ,[AssetDetails]
					  ,[IPAddress]
					  ,[HostName]
					  ,[SoftwareRequired]
					  ,[EmpType]
					  ,[Justification]
					  ,[OUPath]
					  ,[IsActive]
					  ,[CreatedBy]
					  ,[CreatedDt]
                )
				
                VALUES (
						 @SRID
						,@SupportID
                        ,@RequestType
						,@ADID
						,@ReplaceADID
						,@AssetDetails
						,@IPAddress
						,@HostName
						,@SoftwareRequired
						,@EmpType
						,@Justification
						,@OUPath
						,@IsActive
						,@CreatedBy
						,getDate()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update CR Approver Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRCitrixAccess]
            SET
                [SRID] = @SRID,
                [SupportID] = @SupportID
				,[RequestType] = @RequestType
				,[ADID] =@ADID
				,[ReplaceADID] =@ReplaceADID
				,[AssetDetails] = @AssetDetails
				,[SoftwareRequired] = @SoftwareRequired
				,[IPAddress] = @IPAddress
				,[HostName] = @HostName
				,[EmpType]= @EmpType
				,[OUPath] = @OUPath
				,[Justification] = @Justification
				,[IsActive]=@IsActive
				,[ModifiedBy] = @CreatedBy
                ,[ModifiedDt] = GETDATE()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
			[SupportID]=@SupportID,
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete CR Approver Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRCitrixAccess] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;

            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRDomain]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SRDomain]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRDomainID [int],
    @SupportID [int] NULL,
	@DomainName [nvarchar](max) NULL,
	@usePlant [nvarchar](200) NULL,
	@UseDepart [nvarchar](200) NULL,
	@NoofUser [int] NULL,
	@PurpDomain [nvarchar](200) NULL,
	@DueDt [datetime] NULL,
	@TypeofSSL [nvarchar](250) NULL,
	@RenewalPeriod [int] NULL,
	@Justification [nvarchar](250) NULL,
	@DiscontinationDt [datetime] NULL,
	@ReqDomainName [nvarchar](250) NULL,
    @IsActive [bit]  NULL,
    
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert SRDomain Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@SRSelectedfor = @SRSelectedfor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRDomain] (
                   [SRID]
				  ,[DomainName]
				  ,[Plant]
				  ,[Department]
				  ,[NoofUser]
				  ,[PurPoseDomain]
				  ,[DueDate]
				  ,[TypeofSSL]
				  ,[RenewalPeriod]
				  ,[Justification]
				  ,[DiscontinuationDate]
				  ,[ReqDomainName]
				  ,[CreatedBy]
				  ,[CreatedDt]
                )
				
                VALUES (
					@SRID,
					@DomainName,
					@usePlant,
					@UseDepart,
					@NoofUser,
					@PurpDomain,
					@DueDt,
					@TypeofSSL,
					@RenewalPeriod ,
					@Justification,
					@DiscontinationDt,
					@ReqDomainName,
                    @CreatedBy,
					GetDate()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRDomain Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRDomain]
            SET
                [SRID] = @SRID
				,[DomainName] =@DomainName
				,[Plant] =@usePlant
				,[Department] = @UseDepart
				,[NoofUser] =@NoofUser
				,[PurPoseDomain] =@PurpDomain
				,[DueDate] =@DueDt
				,[TypeofSSL] =@TypeofSSL
				,[RenewalPeriod] =@RenewalPeriod
				,[Justification] =@Justification
				,[DiscontinuationDate] = @DiscontinationDt
				,[ModifyBy] =@CreatedBy
				,[ModifiedDt] = GETDATE()
            WHERE SRID=@SRID;
			update [IT].ServiceRequest set
			[SupportID]=@SupportID,
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRDomain Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRDomain] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;

            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('SRDomain Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SREmail]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SREmail]
(
	@Flag [char](1),
	@SREmailID  [int],
    @SRID [int] OUTPUT,
    @SupportID [int] NULL,
	@Requesttype [nvarchar](200) NULL,
	@EmpID [int] NULL,
	@EmpCategory [nvarchar](200) NULL,
	@EmpName [nvarchar](200) NULL,
	@Designation [nvarchar](200) NULL,
	@Department [nvarchar](200) NULL,
	@Location [int] NULL,
	@Intercom [int] NULL,
	@MoblieNo [nvarchar](50) NULL,
	@ReportManager [nvarchar](200) NULL,
	@HOD [nvarchar](200) NULL,
	@CommonEmailID [nvarchar](200) NULL,
	@PreEmailID [nvarchar](200) NULL,
	@OutsideComm [nvarchar](20) NULL,
	@MailAccess [nvarchar](50) NULL,
	@Justification [nvarchar](max) NULL,
	@Description [nvarchar](500) NULL,
	@EmpType [nvarchar] (200) NULL,
	@GB [nvarchar](20) NULL,
	@MemberAdded [nvarchar](200) NULL,
	@GroupName [nvarchar](200) NULL,
	@IsActive [bit] NULL,
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert CR Release Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@SRSelectedfor =@SRSelectedfor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SREmail] (
					 [SRID]
                    ,[SupportID]
					,[Requesttype]
					,[EmpID]
					,[EmpCategory]
					,[EmpName]
					,[Designation]
					,[Department]
					,[Location]
					,[Intercom]
					,[MoblieNo]
					,[ReportManager]
					,[HOD]
					,[CommonEmailID]
					,[PreEmailID]
					,[OutsideComm]
					,[MailAccess]
					,[Justification]
					,[Attachment]
					,[Description]
					,[EmpType]
					,[GB]
					,[MemberAdded]
					,[GroupName]
                    ,[IsActive]
					,[CreatedBy]
					,[CreatedDt]
                )
				
                VALUES (
				
                    @SRID,
                    @SupportID,
                    @Requesttype,
					@EmpID,
					@EmpCategory,
					@EmpName,
					@Designation,
					@Department,
					@Location,
					@Intercom,
					@MoblieNo,
					@ReportManager,
					@HOD,
					@CommonEmailID,
					@PreEmailID,
					@OutsideComm,
					@MailAccess,
					@Justification,
					@Attachment,
					@Description,
					@EmpType,
					@GB,
					@MemberAdded,
					@GroupName,
                    @IsActive,
                    @CreatedBy,
					GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update CR Approver Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SREmail]
            SET
                [SRID] = @SRID,
                [SupportID] = @SupportID
                ,[Requesttype] =@Requesttype
				,[EmpID] = @EmpID
				,[EmpCategory] = @EmpCategory
				,[EmpName] =@EmpName
				,[Designation] = @Designation
				,[Department] =@Department
				,[Location]= @Location
				,[Intercom]= @Intercom
				,[MoblieNo] =@MoblieNo
				,[ReportManager] = @ReportManager
				,[HOD] = @HOD
				,[CommonEmailID] = @CommonEmailID
				,[PreEmailID] = @PreEmailID
				,[OutsideComm]=@OutsideComm
				,[MailAccess]= @MailAccess
				,[Justification] = @Justification
				,[Attachment] = @Attachment
				,[Description] = @Description
				,[EmpType] = @EmpType
				,[GB] = @GB
				,[MemberAdded] = @MemberAdded
				,[GroupName] = @GroupName
                ,[IsActive] = @IsActive
                ,[ModifiedBy] = @CreatedBy
                ,[ModifiedDt] = GETDATE()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
			[SupportID]=@SupportID,
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete CR Approver Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SREmail] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('SREmail Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRExternalDrive]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SRExternalDrive]
(
	@Flag [char](1),
	@SREDID  [int] NULL,
    @SRID [int] OUTPUT,
    @SupportID [int] NULL,
	@ReqType [nvarchar] (200) NULL,
	@ForSelf [nvarchar] (200) NULL,
	@Name [nvarchar] (200) NULL,
	@Designation [nvarchar] (200) NULL,
	@EmpCategory [nvarchar] (200) NULL,
	@Role [nvarchar] (200) NULL,
	@Department [nvarchar] (200) NULL,
	@SubDepartment [nvarchar] (200) NULL,
	@ReportingManager [nvarchar] (200) NULL,
	@HOD [nvarchar] (200) NULL,
	@AccessPath [nvarchar] (200) NULL,
	@AccessType [nvarchar](200) NULL,
	@AccessRequired [nvarchar](200) NULL,
	@OnwerEmail [nvarchar](200) NULL,
	@OnwerPlant [nvarchar](200) NULL,
	@EmpType [nvarchar](200) NULL,
	@Justification [nvarchar](max) NULL,
	@Description [nvarchar] (200) NULL,
	@IsActive [bit] NULL,
	---- Service Request


	@SRCode [nvarchar](200)  , 
	@SRSelectedfor [nvarchar](200) NULL,
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert CR Release Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRSelectedfor = @SRSelectedfor,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRExternalDrive] (
					 [SRID]
                    ,[SREDID]
					,[SupportID]
					,[ReqType]
					,[ForSelf]
					,[Name]
					,[Designation]
					,[EmpCategory]
					,[Role]
					,[Department]
					,[SubDepartment]
					,[PlantId]
					,[ReportingManager]
					,[HOD]
					,[AccessPath]
					,[AccessType]
					,[AccessRequired]
					,[OnwerEmail]
					,[OnwerPlant]
					,[EmpType]
					,[Justification]
					,[Attachment]
					,[Description]
                    ,[IsActive]
					,[CreatedBy]
					,[CreatedDt]
                )
				
                VALUES (
				
					 @SRID
                    ,@SupportID
					,@SREDID
                    ,@ReqType
					,@ForSelf
					,@Name
					,@Designation
					,@EmpCategory
					,@Role
					,@Department
					,@SubDepartment
					,@PlantId
					,@ReportingManager
					,@HOD
					,@AccessPath
					,@AccessType
					,@AccessRequired
					,@OnwerEmail
					,@OnwerPlant
					,@EmpType
					,@Justification
					,@Attachment
					,@Description
                    ,@IsActive
                    ,@CreatedBy
                    ,GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update CR Approver Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRExternalDrive]
            SET
                
				[ReqType] = @ReqType
				,[ForSelf]= @ForSelf
				,[Name] = @Name
				,[Designation]= @Description
				,[EmpCategory] = @EmpCategory
				,[Role]= @Role
				,[Department]=@Department
				,[SubDepartment]=@SubDepartment
				,[PlantId]=@PlantID
				,[ReportingManager]=@ReportingManager				
				,[HOD] = @HOD
				,[AccessPath] = @AccessPath
				,[AccessType]= @AccessType
				,[AccessRequired] =@AccessRequired
				,[OnwerEmail]=@OnwerEmail
				,[OnwerPlant]=@OnwerPlant
				,[EmpType] =@EmpType
				,[Justification]=@Justification
				,[Attachment]=@Attachment
				,[Description]=@Description
                ,[IsActive] = @IsActive
                ,[ModifiedBy] = @CreatedBy
                ,[ModifiedDt] = GETDATE()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
			[SupportID]=@SupportID,
								[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
			
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete CR Approver Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRExternalDrive] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRFTPAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [IT].[sp_SRFTPAccess]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRFTPAID [int],
    @SupportID [int] NULL,
	@ReqType [nvarchar](200) NULL,
	@AccessRequire [int] NULL,
	@AccessType [nvarchar](Max) NULL,
	@AccessPath [nvarchar] (200) NULL,
	@Description [nvarchar](200) NULL,
	@OwnerEmail [nvarchar](200) NULL,
	@OwnerPlant [nvarchar](200) NULL,
	@EmpType [nvarchar](200) NULL,
	@Justification [nvarchar](max) NULL,
    @IsActive [bit]  NULL,
    
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRSelectedfor [nvarchar](2000) NULL,
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert SRDomain Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRSelectedfor = @SRSelectedfor,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRFTPAccess] (
                    [SRID]
				  ,[SupportID]
				  ,[ReqType]
				  ,[AccessRequire]
				  ,[AccessType]
				  ,[AccessPath]
				  ,[Description]
				  ,[OwnerEmail]
				  ,[OwnerPlant]
				  ,[EmpType]
				  ,[Justification]
				  ,[Attachment]
				  ,[IsActive]
				  ,[CreatedBy]
				  ,[CreatedDt]
				  
                )
				
                VALUES (
					@SRID,
					@SupportID
					,@ReqType
					,@AccessRequire
					,@AccessType
					,@AccessPath
					,@Description
					,@OwnerEmail
					,@OwnerPlant
					,@EmpType
					,@Justification
					,@Attachment
					,@IsActive
                    ,@CreatedBy
                    ,GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRDomain Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRFTPAccess]
            SET
                   [SRID] = @SRID
				  ,[SupportID] = @SupportID
				  ,[ReqType]=@ReqType
				  ,[AccessRequire] =@AccessRequire
				  ,[AccessType]=@AccessType
				  ,[AccessPath]=@AccessPath
				  ,[Description] = @Description
				  ,[OwnerEmail]= @OwnerEmail
				  ,[OwnerPlant]=@OwnerPlant
				  ,[EmpType]=@EmpType
				  ,[Justification]=@Justification
				  ,[Attachment]=@Attachment
				  ,[IsActive]=@IsActive
				  ,[ModifiedBy]=@CreatedBy
				  ,[ModifiedDt]=GETDATE()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
			[SupportID]=@SupportID,
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRDomain Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRFTPAccess] WHERE SRID = @SRID
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('SRFTPAccess Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRResolution]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SRResolution](
	@Flag [char](1),
	@SRResolID [int] NULL,
	@SRID [int],
	@ResolRemarks [nvarchar](max) NULL,
	@UserRemarks [nvarchar](200) NULL,
	@ProposedResolDt [datetime] NULL,
	@ResolDt [datetime] NULL,
	@Description [nvarchar](200) NULL,
	@OnHoldReason [int] NULL,
	@Status [nvarchar] (200) NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert CR Release Fields
	BEGIN 
		BEGIN TRANSACTION

		
			INSERT INTO [IT].[SRResolution] (
			  [SRID]
			  ,[ResolRemarks]
			  ,[UserRemarks]
			  ,[ProposedResolDt]
			  ,[ResolDt]
			  ,[Description]
			  ,[OnHoldReason]
			  ,[CreatedBy]
			  ,[CreatedDt]
			  ,[ModifiedBy]
			  ,[ModifiedDt]
		 )
			VALUES (
				@SRID
				,@ResolRemarks
				,@UserRemarks
				,@ProposedResolDt
				,@ResolDt
				,@Description
				,@OnHoldReason
				,@CreatedBy
				,getDate()
				,@CreatedBy
				,getDate()
			)
		Begin
			Update [IT].ServiceRequest set
			Status = @Status,
			OnHoldReason = @OnHoldReason,
			ModifiedBy=@CreatedBy,
			ModifiedDt=getdate()
			Where SRID = @SRID
		END
		
	  COMMIT TRANSACTION
	
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[SRResolution] SET
			  [SRID] =@SRID
			  ,[ResolRemarks] = @ResolRemarks
			  ,[UserRemarks] = @UserRemarks
			  ,[ProposedResolDt] = @ProposedResolDt
			  ,[ResolDt] = @ResolDt
			  ,[Description] = @Description
			  ,[OnHoldReason] = @OnHoldReason
			  ,[CreatedBy] = @CreatedBy
			  ,[CreatedDt] = GETDATE()
			  ,[ModifiedBy] = @CreatedBy
			  ,[ModifiedDt] = GETDATE()
			WHERE SRID=@SRID
		
	  COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete SRResolution Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[SRResolution] WHERE SRResolID=@SRResolID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRRestorationAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SRRestorationAccess]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRRID [int],
    @SupportID [int] NULL,
	@RequestType [nvarchar](max) NULL,
	@OTS [nvarchar](200) NULL,
	@Descriptions [nvarchar](200) NULL,
	@Date [datetime] NULL,
	@StartDate [datetime] NULL,
	@EndDate [datetime] NULL,
	@ProvideDescription [nvarchar](250) NULL,
	@Restoration [datetime] NULL,
	@TransferingData [nvarchar](250) NULL,
    @IsActive [bit]  NULL,
    
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert SRDomain Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@SRSelectedfor = @SRSelectedfor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRRestorationAccess] (
					 [SRID]
					,[SupportID]
					,[RequestType]
					,[OTS]
					,[Descriptions]
					,[Date]
					,[StartDate]
					,[EndDate]
					,[ProvideDescription]
					,[TransferingData]
					,[Restoration]
					,[Attachment]
					,[IsActive]
					,[CreatedBy]
					,[CreatedDt]
                )
				
                VALUES (
					  @SRID
					  ,@SupportID
					  ,@RequestType
					  ,@OTS
					  ,@Descriptions
					  ,@Date
					  ,@StartDate
					  ,@EndDate
					  ,@ProvideDescription
					  ,@TransferingData
					  ,@Restoration
					  ,@Attachment
					  ,@IsActive
					  ,@CreatedBy
					  ,GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRDomain Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRRestorationAccess]
            SET
				   [SRID] = @SRID
				  ,[SupportID] = @SupportID
				  ,[OTS] =@OTS
				  ,[Descriptions] = @Descriptions
				  ,[Date] = @Date
				  ,[StartDate] = @StartDate
				  ,[EndDate] = @EndDate
				  ,[ProvideDescription] = @ProvideDescription
				  ,[TransferingData] =@TransferingData
				  ,[Restoration]=@Restoration
				  ,[Attachment]=@Attachment
				  ,[IsActive] = @IsActive
				  ,[ModifiedBy] =@CreatedBy
				  ,[ModifiedDt] = GETDATE()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
			[SupportID]=@SupportID,
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRDomain Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRRestorationAccess] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRServerAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [IT].[sp_SRServerAccess]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRServerID [int] NULL,
	@SupportID [int] NULL,
	@RequestType [nvarchar] (200) NULL,
	@HostName [nvarchar] (200) NULL,
	@IPAddress [nvarchar](200) NULL,
	@FileServerName [nvarchar](200) NULL,
	@FolderPath [nvarchar](200) NULL,
	@Justification [nvarchar](max) NULL, 
	@Description [nvarchar] (200) NULL,
	@IsActive [bit] NULL,
    
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert SRDomain Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@SRSelectedfor = @SRSelectedfor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRServerAccess] (
					 [SRID]
					,[SupportID]
					,[RequestType]
					,[IPAddress]
					,[HostName]
					,[FileServerName]
					,[FolderPath]
					,[Justification]
					,[Attachment]
					,[Description]
					,[IsActive]
					,[CreatedBy]
					,[CreatedDt]
                )
				
                VALUES (
					     @SRID
						,@SupportID
						,@RequestType
						,@IPAddress
						,@HostName
						,@FileServerName
						,@FolderPath
						,@Justification
						,@Attachment
						,@Description
						,@IsActive
						,@CreatedBy
						,GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRDomain Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRServerAccess]
            SET
				     [SRID] = @SRID
					,[SupportID] =@SupportID 
					,[RequestType] = @RequestType
					,[IPAddress]=@IPAddress
					,[HostName] =@HostName
					,[FileServerName] =@FileServerName
					,[FolderPath] = @FolderPath
					,[Justification] = @Justification
					,[Attachment] = @Attachment
					,[Description] = @Description
					,[IsActive] = @IsActive
					,[ModifiedBy] = @CreatedBy
					,[ModifiedDt] =getDate()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
			[SupportID]=@SupportID,
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRDomain Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRServerAccess] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRSoftware]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SRSoftware]
(
	@Flag [char](1),
	@SWID [int],
    @SRID [int] OUTPUT,
    @SupportID [int] NULL,
    @SoftwareType [nvarchar](200) NULL,
    @SoftwareName [nvarchar](200) NULL,
    @SoftwareVersionName [nvarchar](200) NULL,
    @VendorName [nvarchar](200) NULL,
    @InstType [nvarchar](200) NULL,
    @LicenceType [nvarchar](200) NULL,
    @Location [nvarchar](200) NULL,
    @Department [nvarchar](200) NULL,
    @NoOfUers [nvarchar](200) NULL,
    @NoOfLicence [nvarchar](200) NULL,
    @CostPerLicence [nvarchar](200) NULL,
    @TotalCost [int] NULL,
    @AMCAppilcable [bit] NULL,
    @CostForAMC [nvarchar](200) NULL,
    @ScopeOfAMC [nvarchar](200) NULL,
    @IsInstReq [int] NULL,
    @InstCharge [numeric](18, 0) NULL,
    @DtlsOfInst [nvarchar](max) NULL,
    @DtlsOfinstDt [datetime] NULL,
    @TypeOfDev [nvarchar](200) NULL,
    @DtlsOfDev [nvarchar](200) NULL,
    @IsInterfaceReq [bit] NULL,
    @InterfaceReq [nvarchar](200) NULL,
    @InterfaceWith [nvarchar](max) NULL,
    @IsGxpApp [bit] NULL,
    @NonFunReq [nvarchar](200) NULL,
    @DtlsOfReq [nvarchar](max) NULL,
    @WhereHosted [nvarchar](max) NULL,
    @TypeOfWeb [nvarchar](200) NULL,
    @UsageBY [nvarchar](max) NULL,
    @UserAccessFrom [nvarchar](200) NULL,
    @CurrVersion [nvarchar](200) NULL,
    @TareVersion [nvarchar](200) NULL,
    @Brds [nvarchar](max) NULL,
    @BusJustification [nvarchar](max) NULL,
	@Justification [nvarchar](200) NULL,
	@NoofUseruse [int] NULL,
    @IsActive [bit]  NULL,
    
	---- Service Request


	@SRCode [nvarchar](200)  ,
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert CR Release Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@SRSelectedfor = @SRSelectedfor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRSoftware] (
                    [SRID],
                    [SupportID],
                    [SoftwareType],
                    [SoftwareName],
                    [SoftwareVersionName],
                    [VendorName],
                    [InstType],
                    [LicenceType],
                    [Location],
                    [Department],
                    [NoOfUers],
                    [NoOfLicence],
                    [CostPerLicence],
                    [TotalCost],
                    [AMCAppilcable],
                    [CostForAMC],
                    [ScopeOfAMC],
                    [IsInstReq],
                    [InstCharge],
                    [DtlsOfInst],
                    [DtlsOfinstDt],
                    [TypeOfDev],
                    [DtlsOfDev],
                    [IsInterfaceReq],
                    [InterfaceReq],
                    [InterfaceWith],
                    [IsGxpApp],
                    [NonFunReq],
                    [DtlsOfReq],
                    [WhereHosted],
                    [TypeOfWeb],
                    [UsageBY],
                    [UserAccessFrom],
                    [CurrVersion],
                    [TareVersion],
                    [Brds],
                    [BusJustification],
					[Justification],
					[NoofUseruse],
                    [IsActive],
                    [CreatedBy],
                    [CreatedDt]
                )
				
                VALUES (
				
                    @SRID,
                    @SupportID,
                    @SoftwareType,
                    @SoftwareName,
                    @SoftwareVersionName,
                    @VendorName,
                    @InstType,
                    @LicenceType,
                    @Location,
                    @Department,
                    @NoOfUers,
                    @NoOfLicence,
                    @CostPerLicence,
                    @TotalCost,
                    @AMCAppilcable,
                    @CostForAMC,
                    @ScopeOfAMC,
                    @IsInstReq,
                    @InstCharge,
                    @DtlsOfInst,
                    @DtlsOfinstDt,
                    @TypeOfDev,
                    @DtlsOfDev,
                    @IsInterfaceReq,
                    @InterfaceReq,
                    @InterfaceWith,
                    @IsGxpApp,
                    @NonFunReq,
                    @DtlsOfReq,
                    @WhereHosted,
                    @TypeOfWeb,
                    @UsageBY,
                    @UserAccessFrom,
                    @CurrVersion,
                    @TareVersion,
                    @Brds,
                    @BusJustification,
					@Justification,
					@NoofUseruse,
                    @IsActive,
                    @CreatedBy,
					GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update CR Approver Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRSoftware]
            SET
                [SRID] = @SRID,
                [SupportID] = @SupportID,
                [SoftwareType] = @SoftwareType,
                [SoftwareName] = @SoftwareName,
                [SoftwareVersionName] = @SoftwareVersionName,
                [VendorName] = @VendorName,
                [InstType] = @InstType,
                [LicenceType] = @LicenceType,
                [Location] = @Location,
                [Department] = @Department,
                [NoOfUers] = @NoOfUers,
                [NoOfLicence] = @NoOfLicence,
                [CostPerLicence] = @CostPerLicence,
                [TotalCost] = @TotalCost,
                [AMCAppilcable] = @AMCAppilcable,
                [CostForAMC] = @CostForAMC,
                [ScopeOfAMC] = @ScopeOfAMC,
                [IsInstReq] = @IsInstReq,
                [InstCharge] = @InstCharge,
                [DtlsOfInst] = @DtlsOfInst,
                [DtlsOfinstDt] = @DtlsOfinstDt,
                [TypeOfDev] = @TypeOfDev,
                [DtlsOfDev] = @DtlsOfDev,
                [IsInterfaceReq] = @IsInterfaceReq,
                [InterfaceReq] = @InterfaceReq,
                [InterfaceWith] = @InterfaceWith,
                [IsGxpApp] = @IsGxpApp,
                [NonFunReq] = @NonFunReq,
                [DtlsOfReq] = @DtlsOfReq,
                [WhereHosted] = @WhereHosted,
                [TypeOfWeb] = @TypeOfWeb,
                [UsageBY] = @UsageBY,
                [UserAccessFrom] = @UserAccessFrom,
                [CurrVersion] = @CurrVersion,
                [TareVersion] = @TareVersion,
                [Brds] = @Brds,
                [BusJustification] = @BusJustification,
				[NoofUseruse] = @NoofUseruse,
                [IsActive] = @IsActive,
                [ModifiedBy] = @CreatedBy,
                [ModifiedDt] = GETDATE()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete CR Approver Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRSoftware] WHERE SRID = @SRID;

			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('SRSoftware Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRURLAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [IT].[sp_SRURLAccess]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRURLID  [int] NULL,
	@SupportID [int] NULL,
	@RequestType [nvarchar] (200) NULL,
	@HostName [nvarchar](200) NULL,
	@IPAddress [nvarchar](200) NULL,
	@URLRequired [nvarchar](200) NULL,
	@EmpType [nvarchar](200) NULL,
	@Justification [nvarchar](max) NULL, 
	@Description [nvarchar] (200) NULL,
	@IsActive [bit] NULL,
    
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert SRDomain Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@SRSelectedfor = @SRSelectedfor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRURLAccess] (
					 [SRID]
					,[SupportID]
					,[RequestType]
					,[HostName]
					,[IPAddress]
					,[URLRequired]
					,[EmpType]
					,[Justification]
					,[Attachment]
					,[Description]
					,[IsActive]
					,[CreatedBy]
					,[CreatedDt]
                )
				
                VALUES (
					     @SRID
						,@SupportID
						,@RequestType
						,@HostName
						,@IPAddress
						,@URLRequired
						,@EmpType
						,@Justification
						,@Attachment
						,@Description
						,@IsActive
						,@CreatedBy
						,GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRDomain Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRURLAccess]
            SET
				     [SRID] = @SRID
					,[SupportID] =@SupportID 
					,[RequestType] = @RequestType
					,[HostName]=@HostName
					,[IPAddress] =@IPAddress
					,[URLRequired] =@URLRequired
					,[EmpType] = @EmpType
					,[Justification] = @Justification
					,[Attachment] = @Attachment
					,[Description] = @Description
					,[IsActive] = @IsActive
					,[ModifiedBy] = @CreatedBy
					,[ModifiedDt] =getDate()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRDomain Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRURLAccess] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRUSBAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [IT].[sp_SRUSBAccess]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRUSBAID [int],
    @SupportID [int] NULL,
	@RequestType [nvarchar](max) NULL,
	@ADID [int] NULL,
	@AssestDetails [nvarchar](200) NULL,
	@Hostname [nvarchar](200) NULL,
	@DeviceType [nvarchar](200) NULL,
	@DurationFrom [datetime] NULL,
	@DurationTo [datetime] NULL,
	@AccessType [nvarchar](250) NULL,
	@IPAddress [nvarchar](250) NULL,
	@EmpType [nvarchar](250) NULL,
	@Justification [nvarchar](250) NULL,
	@Description [nvarchar](250) NULL,
    @IsActive [bit]  NULL,
    
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert SRDomain Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRSelectedfor = @SRSelectedfor,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRUSBAccess] (
					 [SRID]
					,[ADID]
					,[AssetDetails]
					,[HostName]
					,[DeviceType]
					,[DurationFrom]
					,[DurationTo]
					,[AccessType]
					,[IPAddress]
					,[EmpType]
					,[Justification]
					,[IsActive]
					,[CreatedBy]
					,[CreatedDt]
                )
				
                VALUES (
					  @SRID
					  ,@ADID
					  ,@AssestDetails
					  ,@HostName
					  ,@DeviceType
					  ,@DurationFrom
					  ,@DurationTo
					  ,@AccessType
					  ,@IPAddress
					  ,@EmpType
					  ,@Justification
					  ,@IsActive
					  ,@CreatedBy
					  ,GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRDomain Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRUSBAccess]
            SET
				   [SRID] = @SRID
				  ,[ADID] = @ADID
				  ,[AssetDetails] =@AssestDetails
				  ,[HostName] = @Hostname
				  ,[DeviceType] = @DeviceType
				  ,[DurationFrom] = @DurationFrom
				  ,[DurationTo] = @DurationTo
				  ,[AccessType] =@AccessType
				  ,[IPAddress]=@IPAddress
				  ,[EmpType]=@EmpType
				  ,[Justification]=@Justification
				  ,[IsActive] = @IsActive
				  ,[ModifiedBy] =@CreatedBy
				  ,[ModifiedDt] = getDate()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRDomain Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRUSBAccess] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRVirtual]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [IT].[sp_SRVirtual]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRVMID [int] NULL,
	@SupportID [int] NULL,
	@RequestType [nvarchar](200) NULL,
	@EmailID [nvarchar](200) NULL,
	@NoParticipants [nvarchar](200) NULL,
	@StartDt [datetime] NULL,
	@EndDt [datetime] NULL,
	@Location [int] NULL,
	@Department [nvarchar](200) NULL,
	@Justification [nvarchar](200) NULL,
	@Description [nvarchar](200) NULL,
	@IsActive [bit] NULL,
    
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRSelectedfor [nvarchar](200) NULL,
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;
        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);
        IF @Flag = 'I' -- Insert SRVirtual Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRSelectedfor = @SRSelectedfor,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
					select @err_msg='Insert failed'
					raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
					Return;
				End
            BEGIN
                INSERT INTO [IT].[SRVirtual] (
					  [SRID]
					  ,[SupportID]
					  ,[RequestType]
					  ,[EmailID]
					  ,[NoParticipants]
					  ,[StartDt]
					  ,[EndDt]
					  ,[Location]
					  ,[Department]
					  ,[Justification]
					  ,[Attachment]
					  ,[Description]
					  ,[IsActive]
					  ,[CreatedBy]
					  ,[CreatedDt]
				  )
				  VALUES (
					       @SRID
						  ,@SupportID
						  ,@RequestType
						  ,@EmailID
						  ,@NoParticipants
						  ,@StartDt
						  ,@EndDt
						  ,@Location
						  ,@Department
						  ,@Justification
						  ,@Attachment
						  ,@Description
						  ,@IsActive
						  ,@CreatedBy
						  ,GetDate()
						);
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRVirtual Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRVirtual]
            SET
				       [SRID] =@SRID
					  ,[SupportID] =@SupportID
					  ,[RequestType] = @RequestType
					  ,[EmailID] =@EmailID
					  ,[NoParticipants] =@NoParticipants
					  ,[StartDt] = @StartDt
					  ,[EndDt] = @EndDt
					  ,[Location] = @Location
					  ,[Department] = @Department
					  ,[Justification] =@Justification
					  ,[Attachment] = @Attachment
					  ,[Description] =@Description
					  ,[IsActive] = @IsActive
					  ,[ModifiedBy] = @CreatedBy
					  ,[ModifiedDt] = GETDATE()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn,
					[SupportID] = @SupportID

			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRVirtual Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRVirtual] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;

            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRVPNAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [IT].[sp_SRVPNAccess]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRVPNID [int] NULL,
	@SupportID [int] NULL,
	@RequestType [nvarchar] (200) NULL,
	@EmpPlant [nvarchar](200) NULL,
	@AccessPermission [nvarchar](200) NULL,
	@AccessList [nvarchar](200) NULL,
	@AccessType [nvarchar](200) NULL,
	@AccessFromDt [datetime] NULL,
	@AccessToDt [datetime]  NULL,
	@EmpType [nvarchar](200) NULL,
	@Justification [nvarchar](max) NULL, 
	@Description [nvarchar] (200) NULL,
	@IsActive [bit] NULL,
    
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@SRSelectedfor [nvarchar](200) NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert SRDomain Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@SRSelectedfor = @SRSelectedfor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRVPNAccess] (
					 [SRID]
					,[SupportID]
					,[RequestType]
					,[EmpPlant]
					,[AccessPermission]
					,[AccessList]
					,[AccessType]
					,[AccessFromDt]
					,[AccessToDt]
					,[EmpType]
					,[Justification]
					,[Attachment]
					,[Description]
					,[IsActive]
					,[CreatedBy]
					,[CreatedDt]
                )
				
                VALUES (
					     @SRID
						,@SupportID
						,@RequestType
						,@EmpPlant
						,@AccessPermission
						,@AccessList
						,@AccessType
						,@AccessFromDt
						,@AccessToDt
						,@EmpType
						,@Justification
						,@Attachment
						,@Description
						,@IsActive
						,@CreatedBy
						,GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRDomain Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRVPNAccess]
            SET
				     [SRID] = @SRID
					,[SupportID] =@SupportID 
					,[RequestType] = @RequestType
					,[EmpPlant]=@EmpPlant
					,[AccessPermission] =@AccessPermission
					,[AccessList] =@AccessList
					,[AccessType] = @AccessType
					,[AccessFromDt] =@AccessFromDt
					,[AccessToDt] = @AccessToDt
					,[EmpType] = @EmpType
					,[Justification] = @Justification
					,[Attachment] = @Attachment
					,[Description] = @Description
					,[IsActive] = @IsActive
					,[ModifiedBy] = @CreatedBy
					,[ModifiedDt] =getDate()
            WHERE SRID = @SRID;
						update [IT].ServiceRequest set
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn,
					[SupportID]=@SupportID
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRDomain Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRVPNAccess] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRWIFIAccess]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [IT].[sp_SRWIFIAccess]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRWIFIID [int] NULL,
	@SupportID [int] NULL,
	@RequestType [nvarchar] (200) NULL,
	@SpecifyPlant [nvarchar](200) NULL,
	@Location [nvarchar](200) NULL,
	@SpecifyOffice [nvarchar](200) NULL,
	@FromDate [datetime] NULL,
	@ToDate [datetime] NULL,
	@Justification [nvarchar](max) NULL, 
	@Description [nvarchar](200) NULL,
	@IsActive [bit] NULL,
    
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar](200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](200) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert SRDomain Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@SRSelectedfor = @SRSelectedfor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRWIFIAccess] (
					 [SRID]
					,[SupportID]
					,[RequestType]
					,[SpecifyPlant]
					,[Location]
					,[SpecifyOffice]
					,[FromDate]
					,[ToDate]
					,[Attachment]
					,[Justification]
					,[Description]
					,[IsActive]
					,[CreatedBy]
					,[CreatedDt]
                )
				
                VALUES (
					     @SRID
						,@SupportID
						,@RequestType
						,@SpecifyPlant
						,@Location
						,@SpecifyOffice
						,@FromDate
						,@ToDate
						,@Attachment
						
						,@Justification
						,@Description
						,@IsActive
						,@CreatedBy
						,GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRDomain Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRWIFIAccess]
            SET
				     [SRID] = @SRID
					,[SupportID] =@SupportID 
					,[RequestType] = @RequestType
					,[SpecifyPlant] =@SpecifyPlant
					,[Location] =@Location
					,[SpecifyOffice] = @SpecifyOffice
					,[FromDate] =@FromDate
					,[ToDate] = @ToDate
					,[Justification] = @Justification
					,[Attachment] = @Attachment
					,[Description] = @Description
					,[IsActive] = @IsActive
					,[ModifiedBy] = @CreatedBy
					,[ModifiedDt] =getDate()
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
			[SupportID]=@SupportID,
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRDomain Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRWIFIAccess] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;

            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SRWindowLogin]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [IT].[sp_SRWindowLogin]
(
	@Flag [char](1),
    @SRID [int] OUTPUT,
	@SRWLID [int],
    @SupportID [int] NULL,
	@RequestType [nvarchar](200) NULL,
	@EmpID [int] NULL,
	@Date [datetime] NULL,
	@Initials [nvarchar](200) NULL,
	@FirstName [nvarchar](200) NULL,
	@LastName [nvarchar](200) NULL,
	@Designation [nvarchar](max) NULL,
	@Plant [int] NULL,
	@PayGroup [nvarchar](200) NULL,
	@StaffCategory [nvarchar](200) NULL,
	@Department [nvarchar](200) NULL,
	@ReportingTO [nvarchar](200) NULL,
	@HOD [nvarchar](200) NULL,
	@Role [nvarchar](200) NULL,
	@UserType [nvarchar](200) NULL,
	@ChangeOUPath [nvarchar] (200) NULL,
	@Justification [nvarchar](200) NULL,
	@EIDIndividual [datetime] NULL,
	@UserID [nvarchar](200) NULL,
	@EmpType [nvarchar](200) NULL,
	@Description [nvarchar] (200) NULL,
    @IsActive [bit]  NULL,
    
	---- Service Request
	@SRCode [nvarchar](200)  , 
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@SRSelectedfor [nvarchar](100) NULL,
	@GuestEmployeeId [int] NULL,
	@GuestName [nvarchar](200) NULL,
	@GuestEmail [nvarchar](200) NULL,
	@GuestContactNo [nvarchar](20) NULL,
	@GRManagerEmpId [nvarchar](200) NULL,
    @Type [nvarchar] (200) NULL,
	@GuestCompany [nvarchar](500) NULL,
	@PlantID [int] NULL,
	@AssetID [int] NULL,
	@CategoryID [int] NULL,
	@CategoryTypID [int] NULL,
	@Priority [int] NULL,
	@Source [nvarchar](100) NULL,
	@Attachment [nvarchar](100) NULL,
	@Status [nchar](50) NULL,
	@AssignedTo [int] NULL,
	@AssignedBy [int] NULL,
	@AssignedOn [datetime] NULL,
	@Remarks [nvarchar](3000) NULL,
	@ProposedResolutionOn [datetime] NULL,
	@CreatedBy [int] NULL
	)
AS
BEGIN 
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE
            @PlantCode VARCHAR(6),
            @MaxCount VARCHAR(4),
            @Year VARCHAR(4),
            @err_num INT,
            @err_msg VARCHAR(500);

        IF @Flag = 'I' -- Insert SRDomain Fields
        BEGIN
            SELECT @PlantCode = Code FROM dbo.Plant_Master WHERE id = @PlantID;
            SELECT @MaxCount = COUNT(SRID) + 1 FROM [IT].[ServiceRequest];
            SELECT @Year = DATEPART(year, GETDATE());
            SELECT @SRCode = CONCAT(@PlantCode, '/SR/', @Year, '/', @MaxCount);

            BEGIN TRANSACTION;
			
				EXEC IT.sp_ServiceRequest
					@Flag = @Flag,
					@SRID = @SRID OUTPUT,
					@SupportID = @SupportID,
					@SRCode = @SRCode,
					@SRRaisedBy=@SRRaisedBy,
					@SRDate=@SRDate,
					@SRShotDesc=@SRShotDesc,
					@SRDesc=@SRDesc,
					@SRRaiseFor=@SRRaiseFor,
					@SRSelectedfor = @SRSelectedfor,
					@GuestCompany=@GuestCompany,
					@GuestEmployeeId=@GuestEmployeeId,
					@GuestName=@GuestName,
					@GuestEmail=@GuestEmail,
					@GuestContactNo=@GuestContactNo,
					@GuestReportingManagerEmployeeId=@GRManagerEmpId,
					@Type=@Type,
					@PlantID=@PlantID,
					@AssetID=@AssetID,
					@CategoryID=@CategoryID,
					@AssignedTo=@AssignedTo,
					@AssignedBy=@AssignedBy,
					@AssignedOn=@AssignedOn,
					@CategoryTypID=@CategoryTypID,
					@Priority=@Priority,
					@Source=@Source,
					@Attachment=@Attachment,
					@Status=@Status,
					@Remarks=@Remarks,
					@ProposedResolutionOn=@ProposedResolutionOn,
					@CreatedBy = @CreatedBy
				IF @SRID IS NULL
				BEGIN
					RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
					ROLLBACK TRANSACTION;
					RETURN;
				END
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				
                INSERT INTO [IT].[SRWindowLogin] (
                   [SRID]
				  ,[SupportID]
				  ,[RequestType]
				  ,[EmpID]
				  ,[Date]
				  ,[Initials]
				  ,[FirstName]
				  ,[LastName]
				  ,[Designation]
				  ,[PlantID]
				  ,[PayGroup]
				  ,[StaffCategory]
				  ,[Department]
				  ,[ReportingTO]
				  ,[HOD]
				  ,[Role]
				  ,[UserType]
				  ,[ChangeOUPath]
				  ,[Justification]
				  ,[EIDIndividual]
				  ,[UserID]
				  ,[EmpType]
				  ,[Attachment]
				  ,[Description]
				  ,[CreatedBy]
				  ,[CreatedOn]
				  
                )
				
                VALUES (
					@SRID
					,@SupportID
					,@RequestType
					,@EmpID
					,@Date
					,@Initials
					,@FirstName
					,@LastName
					,@Designation
					,@PlantID
					,@PayGroup
					,@StaffCategory
					,@Department
					,@ReportingTO
					,@HOD
					,@Role
					,@UserType
					,@ChangeOUPath
					,@Justification
					,@EIDIndividual
					,@UserID
					,@EmpType
					,@Attachment
					,@Description
					,@CreatedBy
					,GETDATE()
                );
            END

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'U' -- Update SRDomain Fields
        BEGIN
            BEGIN TRANSACTION;

            UPDATE [IT].[SRWindowLogin]
            SET
                [SRID] = @SRID
				,[SupportID] = @SupportID
				,[RequestType] =@RequestType
				,[EmpID] = @EmpID
				,[Date] = @Date
				,[Initials] = @Initials
				,[FirstName]= @FirstName
				,[LastName] = @LastName
				,[Designation] = @Designation
				,[PlantID] = @Plant
				,[PayGroup] = @PayGroup
				,[StaffCategory] =@StaffCategory
				,[Department] = @Department
				,[ReportingTO] = @ReportingTO
				,[HOD] = @HOD
				,[Role] =@Role
				,[UserType] = @UserType
				,[ChangeOUPath] =@ChangeOUPath
				,[Justification] =@Justification
				,[EIDIndividual] = @EIDIndividual
				,[UserID] = @UserID
				,[EmpType] =@EmpType
				,[Attachment] =@Attachment
				,[Description] =@Description
				,[ModifiedBy] = @CreatedBy
				,[ModifiedOn] =getDate()
				
            WHERE SRID = @SRID;
			update [IT].ServiceRequest set
			[SupportID]=@SupportID,
					[SRRaisedBy]=@SRRaisedBy,
					[SRDate]=@SRDate,
					[SRShotDesc]=@SRShotDesc,
					[SRDesc]=@SRDesc,
					[SRRaiseFor]=@SRRaiseFor,
					[SRSelectedfor]= @SRSelectedfor,
					[GuestCompany]=@GuestCompany,
					[GuestEmployeeId]=@GuestEmployeeId,
					[GuestName]=@GuestName,
					[GuestEmail]=@GuestEmail,
					[GuestContactNo]=@GuestContactNo,
					[GuestReportingManagerEmployeeId]=@GRManagerEmpId,
					[Type]=@Type,
					[PlantID]=@PlantID,
					[AssetID]=@AssetID,
					[CategoryID]=@CategoryID,
					[AssignedTo]=@AssignedTo,
					[AssignedBy]=@AssignedBy,
					[AssignedOn]=@AssignedOn,
					[CategoryTypID]=@CategoryTypID,
					[Priority]=@Priority,
					[Source]=@Source,
					[Attachment]=@Attachment,
					[Status]=@Status,
					[Remarks]=@Remarks,
					[ProposedResolutionOn]=@ProposedResolutionOn
			WHERE SRID = @SRID;
            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete SRDomain Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRWindowLogin] WHERE SRID = @SRID;
			DELETE FROM [IT].[ServiceRequest] WHERE SRID = @SRID;

            COMMIT TRANSACTION;
        END
        ELSE
            RETURN error_message();
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        BEGIN
            SELECT @err_num = ERROR_NUMBER();
            SELECT @err_msg = ERROR_MESSAGE();
        
            RAISERROR ('Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SupportTeam]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <23-Mar-2024,,>
-- Description:	<Create Support Team Member,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SupportTeam]
	@Flag Char(1),
	@SupportTeamID [int] NULL,
	@SupportTeamAssgnID [int] NULL,
	@Email [nvarchar](100) NULL,
	@First_Name [nvarchar](1000) NULL,
	@Middle_Name [nvarchar](100) NULL,
	@Last_Name [nvarchar](100) NULL,
	@Img_Url [nvarchar](200) NULL,
	@Designation [nvarchar](100) NULL,
	@Role  [nvarchar](100) NULL,
	@EmpID [int] NULL,
	@IsActive [bit] NULL,
	@DOL [datetime] NULL,
	@DOB [date] NULL,
	@IsAdmin bit=0,
	@isSuperAdmin bit=0,
	@IsApprover bit =0,
	@IsChangeAnalyst bit= 0,
	@IsSupportEngineer bit =0,
	@PlantID int NULL,
	@SupportID int NULL,
	@CategoryID int NULL,
	@ClassificationID int NULL,
	@CategoryTypID int Null,
	@ApproverstageCR Char(1) NULL,
	@ApproverstageR Char(1) NULL,
	@ApproverstageC Char(1) NULL,
	@Level int NULL,
	@Approverstage2CR Char(1) NULL,
	@Approverstage2R Char(1) NULL,
	@Approverstage2C Char(1) NULL,
	@Level2 int NULL,
	@Approverstage3CR Char(1) NULL,
	@Approverstage3R Char(1) NULL,
	@Approverstage3C Char(1) NULL,
	@Level3 int NULL,
	@CreatedBy [int] 
	
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @err_num int, @err_msg varchar(100), @count int
	DECLARE @Approver int, @pos int
	DECLARE @Approver1 int, @Approver2 int, @Approver3 int, @ApproverID int
	DECLARE @IsAdmin1 bit, @isSuperAdmin1 bit, @IsApprover1 bit, @IsChangeAnalyst1 bit,	@IsSupportEngineer1 bit
	
	IF(@Flag='D')
	BEGIN
		
			Select @count=count(ITCRApproverID) from IT.CRApprover where ApproverID=@EmpID
			If(@count>0)
			Begin
				select @err_num=4000
				select @err_msg='Approver has transactions associated'
		
				raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
				Return;
			End

			Select @count=count(ITCRID) from IT.ChangeRequest where CROwner=@EmpID 
			If(@count>0)
			Begin
				select @err_num=4000
				select @err_msg='User has transactions associated'
		
				raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
				Return;
			End

			Select @count=count(ITCRID) from IT.ChangeRequest where CRRequestedBy=@EmpID 
			If(@count>0)
			Begin
				select @err_num=4000
				select @err_msg='User has CR Request associated'
		
				raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
				Return;
			End

			Select @count=count(ITCRID) from IT.ChangeRequest where CRInitiatedFor=@EmpID 
			If(@count>0)
			Begin
				select @err_num=4000
				select @err_msg='User has CR Initiation associated'
		
				raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
				Return;
			End

			Select @count=count(ITCRID) from IT.CRExecutionPlan where AssignedTo=@EmpID
			If(@count>0)
			Begin
				select @err_num=4000
				select @err_msg='User has transactions associated'
		
				raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
				Return;
			End
			--Get SupportTeamAssignID
			IF @SupportTeamAssgnID=''
			Begin
				select @SupportTeamAssgnID=SupportTeamAssgnID from SupportTeamAssgn where PlantID=@PlantID and CategoryID=@CategoryID  and ClassificationID=@Classificationid
					and SupportTeamID=@SupportTeamID and SupportID=@SupportID
			End

			-- Block to check if users is Approver for leve1 1 and stage N
			

			select @count=count(appr1.ITApproverID), 
			@ApproverID=appr1.ITApproverID, @Approver1=appr1.Approver1, @Approver2=appr1.Approver2, @Approver3=appr1.Approver3,
			@pos=(select (case 
			when (appr.Approver1=@SupportTeamID) then 1
			when (appr.Approver2=@SupportTeamID) then 2
			when (appr.Approver3=@SupportTeamID) then 3
			End)
			from IT.Approver appr where (appr.Approver1=@SupportTeamID or appr.Approver2=@SupportTeamID or appr.Approver3=@SupportTeamID)
			and appr.PlantID=@PlantID and appr.CategoryID=@CategoryID and appr.ClassificationID=@Classificationid and appr.level=1 and appr.Approverstage='N' and appr.SupportID=@SupportID)
			from IT.Approver appr1 where (appr1.Approver1=@SupportTeamID or appr1.Approver2=@SupportTeamID or appr1.Approver3=@SupportTeamID)
			and appr1.PlantID=@PlantID and appr1.CategoryID=@CategoryID  and appr1.ClassificationID=@Classificationid and appr1.level=1 and appr1.Approverstage='N' and appr1.SupportID=@SupportID
			group by appr1.ITApproverID, appr1.Approver1, appr1.Approver2,appr1.Approver3

			if(@count>0)
			
				Begin
					if (@pos=1)
					Begin
						if(@Approver2 is NULL and @Approver3 is NULL)
						Begin
							Begin transaction
							Delete from IT.Approver where ITApproverID=@ApproverID
							commit transaction
						End
						Else
						Begin
							Update IT.Approver  set Approver1=@Approver2, Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
						End
					End
					Else if(@pos=2)
					Begin
						Update IT.Approver set Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
					
					End
					Else
					Begin
						Update IT.Approver  set Approver3=NULL where ITApproverID=@ApproverID
					End

				
			End

			-- Block to check if users is Approver for leve1 1 and stage R
			select @count=count(appr1.ITApproverID), 
			@ApproverID=appr1.ITApproverID, @Approver1=appr1.Approver1, @Approver2=appr1.Approver2, @Approver3=appr1.Approver3,
			@pos=(select (case 
			when (appr.Approver1=@SupportTeamID) then 1
			when (appr.Approver2=@SupportTeamID) then 2
			when (appr.Approver3=@SupportTeamID) then 3
			End)
			from IT.Approver appr where (appr.Approver1=@SupportTeamID or appr.Approver2=@SupportTeamID or appr.Approver3=@SupportTeamID)
			and appr.PlantID=@PlantID and appr.CategoryID=@CategoryID and appr.ClassificationID=@Classificationid and appr.level=1 and appr.Approverstage='R' and appr.SupportID=@SupportID)
			from IT.Approver appr1 where (appr1.Approver1=@SupportTeamID or appr1.Approver2=@SupportTeamID or appr1.Approver3=@SupportTeamID)
			and appr1.PlantID=@PlantID and appr1.CategoryID=@CategoryID  and appr1.ClassificationID=@Classificationid and appr1.level=1 and appr1.Approverstage='R' and appr1.SupportID=@SupportID
			group by appr1.ITApproverID, appr1.Approver1, appr1.Approver2,appr1.Approver3

			if(@count>0)
			
				Begin
					if (@pos=1)
					Begin
						if(@Approver2 is NULL and @Approver3 is NULL)
						Begin
							Begin transaction
							Delete from IT.Approver where ITApproverID=@ApproverID
							commit transaction
						End
						Else
						Begin
							Update IT.Approver  set Approver1=@Approver2, Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
						End
					
					End
					Else if(@pos=2)
					Begin
						Update IT.Approver set Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
					
					End
					Else
					Begin
						Update IT.Approver  set Approver3=NULL where ITApproverID=@ApproverID
					End

				
			End

			-- Block to check if users is Approver for leve1 1 and stage C
			select @count=count(appr1.ITApproverID), 
			@ApproverID=appr1.ITApproverID, @Approver1=appr1.Approver1, @Approver2=appr1.Approver2, @Approver3=appr1.Approver3,
			@pos=(select (case 
			when (appr.Approver1=@SupportTeamID) then 1
			when (appr.Approver2=@SupportTeamID) then 2
			when (appr.Approver3=@SupportTeamID) then 3
			End)
			from IT.Approver appr where (appr.Approver1=@SupportTeamID or appr.Approver2=@SupportTeamID or appr.Approver3=@SupportTeamID)
			and appr.PlantID=@PlantID and appr.CategoryID=@CategoryID and appr.ClassificationID=@Classificationid and appr.level=1 and appr.Approverstage='C' and appr.SupportID=@SupportID)
			from IT.Approver appr1 where (appr1.Approver1=@SupportTeamID or appr1.Approver2=@SupportTeamID or appr1.Approver3=@SupportTeamID)
			and appr1.PlantID=@PlantID and appr1.CategoryID=@CategoryID  and appr1.ClassificationID=@Classificationid and appr1.level=1 and appr1.Approverstage='C' and appr1.SupportID=@SupportID
			group by appr1.ITApproverID, appr1.Approver1, appr1.Approver2,appr1.Approver3

			if(@count>0)
			
				Begin
					if (@pos=1)
					Begin
						if(@Approver2 is NULL and @Approver3 is NULL)
						Begin
							Begin transaction
							Delete from IT.Approver where ITApproverID=@ApproverID
							commit transaction
						End
						Else
						Begin
							Update IT.Approver  set Approver1=@Approver2, Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
						End
					
					End
					Else if(@pos=2)
					Begin
						Update IT.Approver set Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
					End
					Else
					Begin
						Update IT.Approver  set Approver3=NULL where ITApproverID=@ApproverID
					End

				
			End

			-- Block to check if users is Approver for leve1 2 and stage N
			select @count=count(appr1.ITApproverID), 
			@ApproverID=appr1.ITApproverID, @Approver1=appr1.Approver1, @Approver2=appr1.Approver2, @Approver3=appr1.Approver3,
			@pos=(select (case 
			when (appr.Approver1=@SupportTeamID) then 1
			when (appr.Approver2=@SupportTeamID) then 2
			when (appr.Approver3=@SupportTeamID) then 3
			End)
			from IT.Approver appr where (appr.Approver1=@SupportTeamID or appr.Approver2=@SupportTeamID or appr.Approver3=@SupportTeamID)
			and appr.PlantID=@PlantID and appr.CategoryID=@CategoryID and appr.ClassificationID=@Classificationid and appr.level=2 and appr.Approverstage='N' and appr.SupportID=@SupportID)
			from IT.Approver appr1 where (appr1.Approver1=@SupportTeamID or appr1.Approver2=@SupportTeamID or appr1.Approver3=@SupportTeamID)
			and appr1.PlantID=@PlantID and appr1.CategoryID=@CategoryID  and appr1.ClassificationID=@Classificationid and appr1.level=2 and appr1.Approverstage='N' and appr1.SupportID=@SupportID
			group by appr1.ITApproverID, appr1.Approver1, appr1.Approver2,appr1.Approver3

			if(@count>0)
			
				Begin
					if (@pos=1)
					Begin
						if(@Approver2 is NULL and @Approver3 is NULL)
						Begin
							Begin transaction
							Delete from IT.Approver where ITApproverID=@ApproverID
							commit transaction
						End
						Else
						Begin
							Update IT.Approver  set Approver1=@Approver2, Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
						End
					End
					Else if(@pos=2)
					Begin
						Update IT.Approver set Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
					End
					Else
					Begin
						Update IT.Approver  set Approver3=NULL where ITApproverID=@ApproverID
					End

				End

				-- Block to check if users is Approver for leve1 2 and stage R
			select @count=count(appr1.ITApproverID), 
			@ApproverID=appr1.ITApproverID, @Approver1=appr1.Approver1, @Approver2=appr1.Approver2, @Approver3=appr1.Approver3,
			@pos=(select (case 
			when (appr.Approver1=@SupportTeamID) then 1
			when (appr.Approver2=@SupportTeamID) then 2
			when (appr.Approver3=@SupportTeamID) then 3
			End)
			from IT.Approver appr where (appr.Approver1=@SupportTeamID or appr.Approver2=@SupportTeamID or appr.Approver3=@SupportTeamID)
			and appr.PlantID=@PlantID and appr.CategoryID=@CategoryID and appr.ClassificationID=@Classificationid and appr.level=2 and appr.Approverstage='R' and appr.SupportID=@SupportID)
			from IT.Approver appr1 where (appr1.Approver1=@SupportTeamID or appr1.Approver2=@SupportTeamID or appr1.Approver3=@SupportTeamID)
			and appr1.PlantID=@PlantID and appr1.CategoryID=@CategoryID  and appr1.ClassificationID=@Classificationid and appr1.level=2 and appr1.Approverstage='R' and appr1.SupportID=@SupportID
			group by appr1.ITApproverID, appr1.Approver1, appr1.Approver2,appr1.Approver3

			if(@count>0)
			
				Begin
					if (@pos=1)
					Begin
						if(@Approver2 is NULL and @Approver3 is NULL)
						Begin
							Begin transaction
							Delete from IT.Approver where ITApproverID=@ApproverID
							commit transaction
						End
						Else
						Begin
							Update IT.Approver  set Approver1=@Approver2, Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
						End
					
					End
					Else if(@pos=2)
					Begin
						Update IT.Approver set Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
					
					End
					Else
					Begin
						Update IT.Approver  set Approver3=NULL where ITApproverID=@ApproverID
					End
									
			End
			-- Block to check if users is Approver for leve1 2 and stage C
			select @count=count(appr1.ITApproverID), 
			@ApproverID=appr1.ITApproverID, @Approver1=appr1.Approver1, @Approver2=appr1.Approver2, @Approver3=appr1.Approver3,
			@pos=(select (case 
			when (appr.Approver1=@SupportTeamID) then 1
			when (appr.Approver2=@SupportTeamID) then 2
			when (appr.Approver3=@SupportTeamID) then 3
			End)
			from IT.Approver appr where (appr.Approver1=@SupportTeamID or appr.Approver2=@SupportTeamID or appr.Approver3=@SupportTeamID)
			and appr.PlantID=@PlantID and appr.CategoryID=@CategoryID and appr.ClassificationID=@Classificationid and appr.level=2 and appr.Approverstage='C' and appr.SupportID=@SupportID)
			from IT.Approver appr1 where (appr1.Approver1=@SupportTeamID or appr1.Approver2=@SupportTeamID or appr1.Approver3=@SupportTeamID)
			and appr1.PlantID=@PlantID and appr1.CategoryID=@CategoryID  and appr1.ClassificationID=@Classificationid and appr1.level=2 and appr1.Approverstage='C' and appr1.SupportID=@SupportID
			group by appr1.ITApproverID, appr1.Approver1, appr1.Approver2,appr1.Approver3

			if(@count>0)
			
				Begin
					if (@pos=1)
					Begin
						if(@Approver2 is NULL and @Approver3 is NULL)
						Begin
							Begin transaction
							Delete from IT.Approver where ITApproverID=@ApproverID
							commit transaction
						End
						Else
						Begin
							Update IT.Approver  set Approver1=@Approver2, Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
						End
					
					End
					Else if(@pos=2)
					Begin
						Update IT.Approver set Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
					
					End
					Else
					Begin
						Update IT.Approver  set Approver3=NULL where ITApproverID=@ApproverID
					End
					
			
			End

				-- Block to check if users is Approver for leve1 3 and stage N
			select @count=count(appr1.ITApproverID), 
			@ApproverID=appr1.ITApproverID, @Approver1=appr1.Approver1, @Approver2=appr1.Approver2, @Approver3=appr1.Approver3,
			@pos=(select (case 
			when (appr.Approver1=@SupportTeamID) then 1
			when (appr.Approver2=@SupportTeamID) then 2
			when (appr.Approver3=@SupportTeamID) then 3
			End)
			from IT.Approver appr where (appr.Approver1=@SupportTeamID or appr.Approver2=@SupportTeamID or appr.Approver3=@SupportTeamID)
			and appr.PlantID=@PlantID and appr.CategoryID=@CategoryID and appr.ClassificationID=@Classificationid and appr.level=3 and appr.Approverstage='N' and appr.SupportID=@SupportID)
			from IT.Approver appr1 where (appr1.Approver1=@SupportTeamID or appr1.Approver2=@SupportTeamID or appr1.Approver3=@SupportTeamID)
			and appr1.PlantID=@PlantID and appr1.CategoryID=@CategoryID  and appr1.ClassificationID=@Classificationid and appr1.level=3 and appr1.Approverstage='N' and appr1.SupportID=@SupportID
			group by appr1.ITApproverID, appr1.Approver1, appr1.Approver2,appr1.Approver3

			if(@count>0)
			 	Begin
					if (@pos=1)
					Begin
						if(@Approver2 is NULL and @Approver3 is NULL)
						Begin
							Begin transaction
							Delete from IT.Approver where ITApproverID=@ApproverID
							commit transaction
						End
						Else
						Begin
							Update IT.Approver  set Approver1=@Approver2, Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
						End
					End
					Else if(@pos=2)
					Begin
						Update IT.Approver set Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
					
					End
					Else
					Begin
						Update IT.Approver  set Approver3=NULL where ITApproverID=@ApproverID
					End
				End
				-- Block to check if users is Approver for leve1 3 and stage R
			select @count=count(appr1.ITApproverID), 
			@ApproverID=appr1.ITApproverID, @Approver1=appr1.Approver1, @Approver2=appr1.Approver2, @Approver3=appr1.Approver3,
			@pos=(select (case 
			when (appr.Approver1=@SupportTeamID) then 1
			when (appr.Approver2=@SupportTeamID) then 2
			when (appr.Approver3=@SupportTeamID) then 3
			End)
			from IT.Approver appr where (appr.Approver1=@SupportTeamID or appr.Approver2=@SupportTeamID or appr.Approver3=@SupportTeamID)
			and appr.PlantID=@PlantID and appr.CategoryID=@CategoryID and appr.ClassificationID=@Classificationid and appr.level=3 and appr.Approverstage='R' and appr.SupportID=@SupportID)
			from IT.Approver appr1 where (appr1.Approver1=@SupportTeamID or appr1.Approver2=@SupportTeamID or appr1.Approver3=@SupportTeamID)
			and appr1.PlantID=@PlantID and appr1.CategoryID=@CategoryID  and appr1.ClassificationID=@Classificationid and appr1.level=3 and appr1.Approverstage='R' and appr1.SupportID=@SupportID
			group by appr1.ITApproverID, appr1.Approver1, appr1.Approver2,appr1.Approver3

			if(@count>0)
			
				Begin
					if (@pos=1)
					Begin
						if(@Approver2 is NULL and @Approver3 is NULL)
						Begin
							Begin transaction
							Delete from IT.Approver where ITApproverID=@ApproverID
							commit transaction
						End
						Else
						Begin
							Update IT.Approver  set Approver1=@Approver2, Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
						End
					
					End
					Else if(@pos=2)
					Begin
						Update IT.Approver set Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
					
					End
					Else
					Begin
						Update IT.Approver  set Approver3=NULL where ITApproverID=@ApproverID
					End

			End

				-- Block to check if users is Approver for leve1 3 and stage C
			select @count=count(appr1.ITApproverID), 
			@ApproverID=appr1.ITApproverID, @Approver1=appr1.Approver1, @Approver2=appr1.Approver2, @Approver3=appr1.Approver3,
			@pos=(select (case 
			when (appr.Approver1=@SupportTeamID) then 1
			when (appr.Approver2=@SupportTeamID) then 2
			when (appr.Approver3=@SupportTeamID) then 3
			End)
			from IT.Approver appr where (appr.Approver1=@SupportTeamID or appr.Approver2=@SupportTeamID or appr.Approver3=@SupportTeamID)
			and appr.PlantID=@PlantID and appr.CategoryID=@CategoryID and appr.ClassificationID=@Classificationid and appr.level=3 and appr.Approverstage='C' and appr.SupportID=@SupportID)
			from IT.Approver appr1 where (appr1.Approver1=@SupportTeamID or appr1.Approver2=@SupportTeamID or appr1.Approver3=@SupportTeamID)
			and appr1.PlantID=@PlantID and appr1.CategoryID=@CategoryID  and appr1.ClassificationID=@Classificationid and appr1.level=3 and appr1.Approverstage='C' and appr1.SupportID=@SupportID
			group by appr1.ITApproverID, appr1.Approver1, appr1.Approver2,appr1.Approver3

			if(@count>0)
			
				Begin
					if (@pos=1)
					Begin
						if(@Approver2 is NULL and @Approver3 is NULL)
						Begin
							Begin transaction
							Delete from IT.Approver where ITApproverID=@ApproverID
							commit transaction
						End
						Else
						Begin
							Update IT.Approver  set Approver1=@Approver2, Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
						End
					
					End
					Else if(@pos=2)
					Begin
						Update IT.Approver set Approver2=@Approver3, Approver3=NULL where ITApproverID=@ApproverID
					
					End
					Else
					Begin
						Update IT.Approver  set Approver3=NULL where ITApproverID=@ApproverID
					End
			End

			select @count=count(supportTeamID) from IT.SupportTeamAssgn where supportTeamID=@SupportTeamID
			If (@count>0)
			Begin
				BEGIN TRANSACTION
					Delete from IT.Approver where Approver1 is NULL and Approver2 is NULL and Approver3 is NULL

					Delete from IT.SupportTeamAssgn where SupportTeamAssgnID=@SupportTeamAssgnID

					select @count=count(supportTeamID) from IT.SupportTeamAssgn where supportTeamID=@SupportTeamID
					if (@count=0)
					Delete from IT.SupportTeam where supportTeamID=@SupportTeamID
				COMMIT TRANSACTION
			End
		
	END
	ELSE
	BEGIN
		SELECT @count=count(st.SupportTeamID), @SupportTeamID=st.SupportTeamID from IT.SupportTeam st 
		where st.EmpID=@EmpID group by st.SupportTeamID
	
		IF (@count>0)
		BEGIN
				
			SELECT @SupportTeamAssgnID=sta.SupportTeamAssgnID,
			@IsAdmin1=sta.IsAdmin, @isSuperAdmin1=sta.isSuperAdmin, @IsApprover1=sta.isApprover, @IsChangeAnalyst1=sta.isChangeAnalyst,
			@IsSupportEngineer1=sta.isSupportEngineer
			from IT.SupportTeam st 
			inner join IT.SupportTeamAssgn sta on sta.SupportTeamID=st.SupportTeamID and sta.SupportID=@SupportID and sta.PlantID=@PlantID and sta.CategoryID=@CategoryID and sta.ClassificationID=@ClassificationID
			where sta.SupportTeamID=@SupportTeamID
		
			if(@IsAdmin1=1) select @IsAdmin=@IsAdmin1
			if(@isSuperAdmin1=1) select @isSuperAdmin=@isSuperAdmin1
			if(@IsApprover1=1) select @IsApprover=@IsApprover1
			if(@IsChangeAnalyst1=1) select @IsChangeAnalyst=@IsChangeAnalyst1
			if(@IsSupportEngineer1=1) select @IsSupportEngineer=@IsSupportEngineer1
	
			BEGIN TRANSACTION
					--Update [IT].[SupportTeam] Set
					--	[Email]=@Email,
					--	[First_Name]=@First_Name,
					--	[Middle_Name]=@Middle_Name,
					--	[Last_Name]=@Last_Name,
					--	[Img_Url]=@Img_Url,
					--	[Designation]=@Designation,
					--	[Role]=@Role,
					--	[EmpID]=@EmpID,
					--	[IsActive]=@IsActive,
					--	[DOL]=@DOL,
					--	[DOB]=@DOB,
					--	[ModifiedBy]=@CreatedBy,
					--	[ModifiedDate]=getdate()
					--	where SupportteamID=@SupportteamID

				if (@SupportTeamAssgnID!='')
				BEGIN
					Update [IT].[SupportTeamAssgn] Set
						[SupportTeamID]=@SupportteamID,
						[SupportID]=@SupportID,
						[CategoryID]=@CategoryID,
						[ClassificationID]=@ClassificationID,
						CategoryTypID=@CategoryTypID,
						[PlantID]=@PlantID,
						[isAdmin]=@IsAdmin,
						[isSuperAdmin]=@isSuperAdmin,
						[isApprover]=@isApprover,
						[isChangeAnalyst]=@isChangeAnalyst,
						[isSupportEngineer]=@isSupportEngineer,
						[IsActive]=@IsActive,
						[ModifiedBy]=@CreatedBy,
						[ModifiedDate]=getdate()
						where SupportTeamAssgnID=@SupportTeamAssgnID
					--where SupportteamID=@SupportteamID
					--and PlantID=@PlantID and CategoryID=@CategoryID and ClassificationID=@ClassificationID
				END
				ELSE
				BEGIN
					INSERT INTO [IT].[SupportTeamAssgn] (
						[SupportTeamID],
						[SupportID],
						[CategoryID],
						[ClassificationID],
						[CategoryTypID],
						[PlantID],
						[isAdmin],
						[isSuperAdmin],
						[isApprover],
						[isChangeAnalyst],
						[isSupportEngineer],
						IsActive,
						[CreatedBy],
						[CreatedDate],
						[ModifiedBy],
						[ModifiedDate])
					VALUES (
						@SupportTeamID,
						@SupportID,
						@CategoryID,
						@ClassificationID,
						@CategoryTypID,
						@PlantID,
						@IsAdmin,
						@isSuperAdmin,
						@isApprover,
						@isChangeAnalyst,
						@isSupportEngineer,
						@IsActive,
						@CreatedBy,
						getdate(),
						@CreatedBy,
						getdate())
				END
				
			If (@SupportTeamID!='' and @IsApprover=1 )
					BEGIN
						if (@Level=1)
						BEGIN
							if (@ApproverstageCR = 'N')
							BEGIN
								EXEC IT.sp_AssignApprover
								@SupportTeamID=@SupportTeamID, 
								@PlantID=@PlantID,
								@SupportID=@SupportID,
								@CategoryID=@CategoryID,
								@ClassificationID=@ClassificationID,
								@Approverstage=@ApproverstageCR,
								@Level=@Level,
								@CreatedBy=@CreatedBy

							END

							if (@ApproverstageR = 'R')
							BEGIN
								EXEC IT.sp_AssignApprover 
								@SupportTeamID=@SupportTeamID, 
								@PlantID=@PlantID,
								@SupportID=@SupportID,
								@CategoryID=@CategoryID,
								@ClassificationID=@ClassificationID,
								@Approverstage=@ApproverstageR,
								@Level=@Level,
								@CreatedBy=@CreatedBy

							END

					if (@ApproverstageC = 'C')
					BEGIN
						EXEC IT.sp_AssignApprover 
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@ApproverstageC,
						@Level=@Level,
						@CreatedBy=@CreatedBy
					END

				END
			

						if (@Level2=2)
						BEGIN
						if (@Approverstage2CR = 'N')
						BEGIN
							EXEC IT.sp_AssignApprover
							@SupportTeamID=@SupportTeamID, 
							@PlantID=@PlantID,
							@SupportID=@SupportID,
							@CategoryID=@CategoryID,
							@ClassificationID=@ClassificationID,
							@Approverstage=@Approverstage2CR,
							@Level=@Level2,
							@CreatedBy=@CreatedBy

						END

							if (@Approverstage2R = 'R')
							BEGIN
								EXEC IT.sp_AssignApprover 
								@SupportTeamID=@SupportTeamID, 
								@PlantID=@PlantID,
								@SupportID=@SupportID,
								@CategoryID=@CategoryID,
								@ClassificationID=@ClassificationID,
								@Approverstage=@Approverstage2R,
								@Level=@Level2,
								@CreatedBy=@CreatedBy

							END

					if (@Approverstage2C = 'C')
					BEGIN
						EXEC IT.sp_AssignApprover 
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@Approverstage2C,
						@Level=@Level2,
						@CreatedBy=@CreatedBy

					END

				
			End

						if (@Level3=3)
						BEGIN
						if (@Approverstage3CR = 'N')
						BEGIN
							EXEC IT.sp_AssignApprover
							@SupportTeamID=@SupportTeamID, 
							@PlantID=@PlantID,
							@SupportID=@SupportID,
							@CategoryID=@CategoryID,
							@ClassificationID=@ClassificationID,
							@Approverstage=@Approverstage3CR,
							@Level=@Level3,
							@CreatedBy=@CreatedBy

						END

							if (@Approverstage3R = 'R')
							BEGIN
								EXEC IT.sp_AssignApprover 
								@SupportTeamID=@SupportTeamID, 
								@PlantID=@PlantID,
								@SupportID=@SupportID,
								@CategoryID=@CategoryID,
								@ClassificationID=@ClassificationID,
								@Approverstage=@Approverstage3R,
								@Level=@Level3,
								@CreatedBy=@CreatedBy

							END

					if (@Approverstage3C = 'C')
					BEGIN
						EXEC IT.sp_AssignApprover 
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@Approverstage3C,
						@Level=@Level3,
						@CreatedBy=@CreatedBy

					
					END

				END
			
			END
			COMMIT TRANSACTION
			
		END
		ELSE
		BEGIN

			IF @Flag = 'I' -- Insert Support Fields
			BEGIN 
			Declare @stcount int=0
		
			SELECT @stcount=count(st.SupportTeamID)
			from IT.SupportTeam st 
			inner join IT.SupportTeamAssgn sta on sta.SupportTeamID=st.SupportTeamID 
			and sta.PlantID=@PlantID and sta.CategoryID=@CategoryID and sta.ClassificationID=@ClassificationID
			where st.empid=@EmpID

				if (@stcount>0)
				Begin
					select @err_num=4000
						select @err_msg='User updated'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
				End
			
			select @stcount=count(empid) from IT.SupportTeam where EmpID=@EmpID
			if (@stcount=0)
			Begin
				BEGIN TRANSACTION
					INSERT INTO [IT].[SupportTeam](
						[Email],
						[First_Name],
						[Middle_Name],
						[Last_Name],
						[Img_Url],
						[Designation],
						[Role],
						[EmpID],
						[IsActive],
						[DOL],
						[DOB],
						[CreatedBy],
						[CreatedDate],
						[ModifiedBy],
						[ModifiedDate])
						Values(
						@Email,
						@First_Name,
						@Middle_Name,
						@Last_Name,
						@Img_Url,
						@Designation,
						@Role,
						@EmpID,
						@IsActive,
						@DOL,
						@DOB,
						@CreatedBy,
						getdate(),
						@CreatedBy,
						getdate())
				COMMIT TRANSACTION
			END
			
			Select @SupportTeamID = st.SupportTeamID  from IT.SupportTeam st where st.EmpID=@EmpID 
	
		   
			IF (@SupportTeamID is not NULL or @SupportTeamID!='')
			BEGIN
				BEGIN TRANSACTION
					INSERT INTO [IT].[SupportTeamAssgn] (
						[SupportTeamID],
						[SupportID],
						[CategoryID],
						[ClassificationID],
						[CategoryTypID],
						[PlantID],
						[isAdmin],
						[isSuperAdmin],
						[isApprover],
						[isChangeAnalyst],
						[isSupportEngineer],
						[IsActive],
						[CreatedBy],
						[CreatedDate],
						[ModifiedBy],
						[ModifiedDate])
					VALUES (
						@SupportTeamID,
						@SupportID,
						@CategoryID,
						@ClassificationID,
						@CategoryTypID,
						@PlantID,
						@IsAdmin,
						@isSuperAdmin,
						@isApprover,
						@isChangeAnalyst,
						@isSupportEngineer,
						@IsActive,
						@CreatedBy,
						getdate(),
						@CreatedBy,
						getdate())
				COMMIT TRANSACTION
			END

			If (@SupportTeamID!='' and @IsApprover=1 )
			BEGIN
				if(@Level=1)
				Begin
					if (@ApproverstageCR = 'N')
					BEGIN
						EXEC IT.sp_AssignApprover
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@ApproverstageCR,
						@Level=@Level,
						@CreatedBy=@CreatedBy

						IF (@@ERROR<>'')
						BEGIN
							RETURN @@ERROR
						END
					END

					if (@ApproverstageR = 'R')
					BEGIN
						EXEC IT.sp_AssignApprover 
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@ApproverstageR,
						@Level=@Level,
						@CreatedBy=@CreatedBy

						IF (@@ERROR<>'')
						BEGIN
							RETURN @@ERROR
						END
					END

					if (@ApproverstageC = 'C')
					BEGIN
						EXEC IT.sp_AssignApprover 
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@ApproverstageC,
						@Level=@Level,
						@CreatedBy=@CreatedBy

						IF (@@ERROR<>'')
						BEGIN
							RETURN @@ERROR
						END
					END
				END

				if(@Level2=2)
				Begin
					if (@Approverstage2CR = 'N')
					BEGIN
						EXEC IT.sp_AssignApprover
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@Approverstage2CR,
						@Level=@Level2,
						@CreatedBy=@CreatedBy

						IF (@@ERROR<>'')
						BEGIN
							RETURN @@ERROR
						END
					END

					if (@Approverstage2R = 'R')
					BEGIN
						EXEC IT.sp_AssignApprover 
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@Approverstage2R,
						@Level=@Level2,
						@CreatedBy=@CreatedBy

						IF (@@ERROR<>'')
						BEGIN
							RETURN @@ERROR
						END
					END

					if (@Approverstage2C = 'C')
					BEGIN
						EXEC IT.sp_AssignApprover 
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@Approverstage2C,
						@Level=@Level2,
						@CreatedBy=@CreatedBy

						IF (@@ERROR<>'')
						BEGIN
							RETURN @@ERROR
						END
					END
				END

				if(@Level3=3)
				Begin
					if (@Approverstage3CR = 'N')
					BEGIN
						EXEC IT.sp_AssignApprover
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@Approverstage3CR,
						@Level=@Level3,
						@CreatedBy=@CreatedBy

						IF (@@ERROR<>'')
						BEGIN
							RETURN @@ERROR
						END
					END

					if (@Approverstage3R = 'R')
					BEGIN
						EXEC IT.sp_AssignApprover 
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@Approverstage3R,
						@Level=@Level3,
						@CreatedBy=@CreatedBy

						IF (@@ERROR<>'')
						BEGIN
							RETURN @@ERROR
						END
					END

					if (@Approverstage3C = 'C')
					BEGIN
						EXEC IT.sp_AssignApprover 
						@SupportTeamID=@SupportTeamID, 
						@PlantID=@PlantID,
						@SupportID=@SupportID,
						@CategoryID=@CategoryID,
						@ClassificationID=@ClassificationID,
						@Approverstage=@Approverstage3C,
						@Level=@Level3,
						@CreatedBy=@CreatedBy

						IF (@@ERROR<>'')
						BEGIN
							RETURN @@ERROR
						END
					END
				END
			END
			END
		END
	END

END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_SysLandscape]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_SysLandscape](
	@Flag [char](1),
	@SysLandscapeID [int] NULL,
	@SupportID [int] NULL,
	@CategoryID [int] NULL,
	@ClassificationID [int] NULL,
	@SysLandscape [nvarchar](200) NULL,
	@PriorityNum [int] NULL,
	@IsActive [bit]=1,
	@CreatedBy [int] NULL,
	@CreatedDt [datetime] NULL,
	@ModifiedBy [int] NULL,
	@ModifiedDt [datetime] NULL
	
	)
AS
BEGIN 
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Flag = 'I' -- Insert Syslandscape Fields
	BEGIN 
		BEGIN TRANSACTION
			select @SysLandscapeID = max(SysLandscapeID)+1 from [IT].[SysLandscape]
		
			INSERT INTO [IT].[SysLandscape] (
				
					  [SupportID]
					  ,[CategoryID]
					  ,[ClassificationID]
					  ,[SysLandscape]
					  ,[PriorityNum]
					  ,[IsActive]
					  ,[CreatedBy]
					  ,[CreatedDt]
					  ,[ModifiedBy]
					  ,[ModifiedDt]
					 )
			VALUES   (
						
						@SupportID,
						@CategoryID,
						@ClassificationID,
						@SysLandscape,
						@PriorityNum,
						@IsActive,
						@CreatedBy,
						getdate(),
						@ModifiedBy,
						getdate()
			)
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='U' -- Update CR Approver Fieldss
	BEGIN
		BEGIN TRANSACTION
			UPDATE [IT].[SysLandscape] SET
					SupportID=@SupportID,
					CategoryID=@CategoryID,
					ClassificationID=@ClassificationID,
					SysLandscape=@SysLandscape,
					PriorityNum=@PriorityNum,
					IsActive=@IsActive,
					ModifiedBy=@ModifiedBy,
					ModifiedDt=getdate()
			WHERE SysLandscapeID=@SysLandscapeID
		COMMIT TRANSACTION
	END
	ELSE IF @Flag='D'   -- Delete CR Approver Field
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM [IT].[SysLandscape] WHERE SysLandscapeID=@SysLandscapeID
		COMMIT TRANSACTION
	END
	ELSE
		RETURN error_message()
END TRY
	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('SysLandscape Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
END
GO
/****** Object:  StoredProcedure [IT].[sp_UpdateIssueStatus]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [IT].[sp_UpdateIssueStatus]
    @IssueId INT,
    @Status NVARCHAR(max),
    @ModifiedBy NVARCHAR(50),
    @ResolutionRemarks NVARCHAR(MAX),
	@AssignedTo int ,
	@ReasonId int null
AS
BEGIN
    -- Start a transaction to ensure atomicity
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Update the issue record in the database
        UPDATE IssueList
        SET 
            Status = @Status,
            ModifiedBy = @ModifiedBy,
            ResolutionRemarks = @ResolutionRemarks,
            ModifiedDt = GETDATE(),
			ResolutionDt = CASE 
                                WHEN @Status = 'Resolved' THEN GETDATE()
                                ELSE ResolutionDt
                              END,
            AssignedTo = CASE 
                            WHEN @Status = 'Open' THEN @AssignedTo
                            ELSE AssignedTo
                        END,
            AssignedBy = CASE 
                            WHEN @Status = 'Open' THEN @ModifiedBy
                            ELSE AssignedBy
                        END,
			ReasonID = CASE 
                            WHEN @Status = 'On Hold' THEN @ReasonId
                            ELSE ReasonID
                        END
        WHERE IssueId = @IssueId;

        COMMIT TRANSACTION;
        
        SELECT 'Success' AS Message;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Return the error message
        SELECT 
            'Error' AS Status,
            @ErrorNumber AS ErrorNumber,
            @ErrorMessage AS ErrorMessage,
            @ErrorSeverity AS ErrorSeverity,
            @ErrorState AS ErrorState;
    END CATCH;
END


GO
/****** Object:  StoredProcedure [IT].[sp_ViewChangeRequest]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [IT].[sp_ViewChangeRequest](
	@Flag Char,
	@ITCRID int=NULL,
	@SupportID int NULL,
	@ClassifcationID int NULL,
	@CategoryID int NULL,
	@CROwner int NULL,
	@CRDate datetime NULL,
	@CRRequestedBy int NULL,
	@CRInitiatedFor int NULL,
	@Status nchar(10) NULL,
	@ReferenceID [int] NULL,
	@ReferenceTyp [nvarchar](50) NULL,
	@CategoryTypeID [int] NULL,
	@NatureOfChange varchar(50)= NULL,
	@PriorityType varchar(50)= NULL,
	@PlantID int = NULL,
	@GXPClassification bit= NULL,
	@ChangeControlNo varchar(50)= NULL,
	@ChangeControlDt date= NULL,
	@ChangeControlAttach bit= NULL,
	@ChangeDesc varchar(2000)= NULL,
	@ReasonForChange varchar(2000)= NULL,
	@AlternateConsidetation varchar(2000)= NULL,
	@ImpactNotDoing varchar(2000)= NULL,
	@TriggeredBy varchar(2000)= NULL,
	@Benefits varchar(2000)= NULL,
	@EstimatedCost numeric= NULL,
	@EstimatedCostCurr varchar(3)= NULL,
	@EstimatedEffort int= NULL,
	@EstimatedEffortUnit varchar(50)= NULL,
	@EstimatedDateCompletion date= NULL,
	@RollbackPlan varchar(2000)= NULL,
	@BackoutPlan varchar(2000)= NULL,
	@DownTimeRequired bit= NULL,
	@DownTimeFromDate datetime= NULL,
	@DownTimeToDate datetime= NULL,
	@isSubmitted bit = NULL,
	@isApproved bit = NULL,
	@isImplemented bit = NULL,
	@isReleased bit = NULL,
	@CreatedBy int NULL
)
AS
set nocount on;

BEGIN TRY
-- INSERT FIELDS
	IF @Flag ='V' 
	BEGIN
		BEGIN transaction
			select CR.ITCRID, CR.CRCode, Emp.First_Name CROwner, CR.ChangeDesc, Cat.CategoryName, Class.ClassificationName, 
		CR.CRDate,CR.[Status], CR.EstimatedCost, CR.EstimatedCostCurr, CR.EstimatedDateCompletion, CR.ApprovedBy 
		from IT.ChangeRequest as CR
		inner join  IT.Category Cat on cat.ITCategoryID=cr.CategoryID
		inner join IT.Classification Class on Class.ITClassificationID=cr.ClassifcationID
		inner join dbo.Employee_Master Emp on Emp.Employee_ID=CR.CROwner
		inner join IT.CategoryTyp CTyp on CTyp.CategoryTypeID=CR.CategoryTypeID 
		where 1=1 
			Commit Transaction
		END
	ELSE
		RETURN error_message()
		
END TRY	
BEGIN CATCH
		ROLLBACK TRANSACTION
		BEGIN
			DECLARE @err_num int, @err_msg varchar(100)
			select @err_num=ERROR_NUMBER()
			select @err_msg=ERROR_MESSAGE()
		
			raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg);
		END
END CATCH
GO
/****** Object:  StoredProcedure [IT].[SRassignTo]    Script Date: 2024-11-29 10:06:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [IT].[SRassignTo]
    @SRID INT,
    @Status NVARCHAR(50),
    @AssignedBy NVARCHAR(100),
    @AssignedTo NVARCHAR(100),
    @ModifiedBy NVARCHAR(100)
AS
BEGIN
    -- Check if the record exists
    IF EXISTS (SELECT 1 FROM [MicroLabs_Dev].[IT].[ServiceRequest] WHERE [SRID] = @SRID)
    BEGIN
        -- Update the fields in the ServiceRequest table
        UPDATE [MicroLabs_Dev].[IT].[ServiceRequest]
        SET 
            [Status] = @Status,
            [AssignedBy] = @AssignedBy,
            [AssignedTo] = @AssignedTo,
            [AssignedOn] = GETDATE(),
            [ModifiedBy] = @ModifiedBy,
            [ModifiedDt] = GETDATE()
        WHERE [SRID] = @SRID;

        SELECT 'ServiceRequest updated successfully.' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'Error: ServiceRequest with the given SRID does not exist.' AS Message;
    END
END;
GO
