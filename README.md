 Declare @Approver1 int, @Approver2 int, @Approver3 int,@ITApproverID int
  Select @ITApproverID=ITApproverID, @Approver1=Approver1, @Approver2=Approver2, @Approver3=Approver3 from [IT].[Approver]
		where SupportID=1 and CategoryID=1 
		and ClassificationID=1 and PlantID=5
		and Approverstage='N' and Level=1
