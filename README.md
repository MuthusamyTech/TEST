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
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @err_num int, @err_msg varchar(100)
	Declare @Approver1 int, @Approver2 int, @Approver3 int,@Fill int,@ITApproverID int
	Select @Fill=0 , @ITApproverID=0


	
		Select @ITApproverID=ITApproverID, @Approver1=Approver1, @Approver2=Approver2, @Approver3=Approver3 from [IT].[Approver]
		where SupportID=@SupportID and CategoryID=@CategoryID 
		and ClassificationID=@ClassificationID and PlantID=@PlantID
		and Approverstage=@Approverstage and Level=@Level

		IF ((@Approver1!='' or @Approver1 is not null) 
		and (@Approver2!='' or @Approver2 is not null)  
		and (@Approver3!='' or @Approver3 is not null) )
			BEGIN
				select @err_num=4000
				select @err_msg='Max Approvers are already assigned for this group'
		
				raiserror ('Transaction Error :%d: %s',16,1,@err_num,@err_msg)
				Return
			END 
		
			ELSE IF (@Approver1=@SupportTeamID)
			BEGIN
			
				select @err_num=4000
				select @err_msg='Approver 1 is already assigned for level '+ CAST(@Level as varchar(5))
		
				raiserror ('Transaction Error :%d: %s',16,1,@err_num, @err_msg);
				Return
			END
			ELSE IF (@Approver2=@SupportTeamID) 
			BEGIN
			
				select @err_num=4000
				select @err_msg='Approver 2 is already assigned for level '+ CAST(@Level as varchar(5))
		
				raiserror ('Transaction Error :%d: %s',16,1,@err_num, @err_msg);
				Return
			END
			ELSE IF (@Approver3=@SupportTeamID) 
			BEGIN
			
				select @err_num=4000
				select @err_msg='Approver 3 is already assigned for level '+ CAST(@Level as varchar(5))
		
				raiserror ('Transaction Error :%d: %s',16,1,@err_num, @err_msg);
				Return
			END
		ELSE
		BEGIN
			if (@Approver3='' or @Approver3 is NULL) 
			BEGIN
				select @Approver1=@supportteamID
				Select @Fill=1
			END
			if (@Approver2='' or @Approver2 is NULL and @Fill=0) 
			BEGIN
				select @Approver2=@supportteamID
				Select @Fill=1
			END
			if (@Approver3='' or @Approver3 is NULL and @Fill=0) 
			BEGIN
				select @Approver3=@supportteamID
				Select @Fill=1
			END
				    
			--select @Approver1, @Approver2, @Approver3, @Level, @Approverstage

			IF (@ITApproverID!=0)
			BEGIN
				BEGIN TRANSACTION
				UPDATE  [IT].[Approver] SET
					[Approver1]=@Approver1,
					[Approver2]=@Approver2,
					[Approver3]=@Approver3,
					[ModifiedBy]=@CreatedBy,
					[ModifiedDt]=getdate()
					where ITApproverID=@ITApproverID

					--IF (@@ERROR<>'')
					--BEGIN
					--	ROLLBACK TRANSACTION
					--	RETURN error_message()
					--END
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
						getdate(),
						@CreatedBy,
						getdate())

				--IF (@@ERROR<>'')
				--BEGIN
				--	ROLLBACK TRANSACTION
				--	RETURN error_message()
				--END
				COMMIT TRANSACTION
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
