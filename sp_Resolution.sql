USE [MicroLabs_Dev]
GO
/****** Object:  StoredProcedure [IT].[sp_SRResolution]    Script Date: 2025-02-13 10:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [IT].[sp_SRResolution](
	@Flag [char](1),
	@SRResolID [int] NULL,
	@SRID [int],
	@SupportID [int],
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
		    IF EXISTS (SELECT * FROM [IT].[SRResolution] WHERE SRID = @SRID)
				 UPDATE [IT].[SRResolution]
					SET
						ResolRemarks = @ResolRemarks,
						UserRemarks = @UserRemarks,
						ProposedResolDt = @ProposedResolDt,
						ResolDt = @ResolDt,
						Description = @Description,
						OnHoldReason = @OnHoldReason,
						ModifiedBy = @CreatedBy,
						ModifiedDt = GETDATE(),
						status = @Status
					WHERE SRID = @SRID
			ELSE
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
					,[status]
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
					,@Status
				)
		Begin
			Update [IT].ServiceRequest set
			Status = @Status,
			OnHoldReason = @OnHoldReason,
			ModifiedBy=@CreatedBy,
			ModifiedDt=getdate()
			Where SRID = @SRID
		END
		If @SupportID = 41 and @Status ='Resolved'
		BEGIN
			INSERT INTO IT.EmailGroup(
				EmailGroupName,
				CreatedBy,
				CreatedDt
			)
			select 
				GroupName,
				@CreatedBy,
				Getdate()
			FROM [IT].[SREmail] Where SRID = @SRID
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
			  ,[ModifiedBy] = @CreatedBy
			  ,[ModifiedDt] = GETDATE()
			  ,[status] = @Status
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
