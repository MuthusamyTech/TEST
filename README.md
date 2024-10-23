DECLARE @Approver1 INT, @Approver2 INT, @Approver3 INT, @ITApproverID INT;

SELECT 
    @ITApproverID = ITApproverID, 
    @Approver1 = Approver1, 
    @Approver2 = Approver2, 
    @Approver3 = Approver3
FROM [IT].[Approver]
WHERE 
    SupportID = 1 
    AND CategoryID = 1 
    AND ClassificationID = 1 
    AND PlantID = 5
    AND Approverstage = 'N' 
    AND Level = 1;
