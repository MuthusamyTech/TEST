ALTER PROCEDURE [IT].[sp_AssignApprover]
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
