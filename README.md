USE [MicroLabs_Dev]
GO
/****** Object:  StoredProcedure [IT].[sp_SRSoftware]    Script Date: 2024-09-24 10:26:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Yavanthi Shivakumar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER     PROCEDURE [IT].[sp_SRSoftware]
(
	@Flag [char](1),
	@SWID [int],
    @SRID [int],
    @SupportID [int] NULL,
    @SoftwareType [nvarchar](20) NULL,
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
    @IsInstReq [bit] NULL,
    @InstCharge [numeric](18, 0) NULL,
    @DtlsOfInst [nvarchar](max) NULL,
    @DtlsOfinstDt [datetime] NULL,
    @TypeOfDev [nvarchar](200) NULL,
    @DtlsOfDev [nvarchar](200) NULL,
    @IsInterfaceReq [bit] NULL,
    @InterfaceReq [nvarchar](200) NULL,
    @InterfaceWith [nvarchar](max) NULL,
    @IsGxpApp [bit] NULL,
    @NonFunReq [bit] NULL,
    @DtlsOfReq [nvarchar](max) NULL,
    @WhereHosted [nvarchar](max) NULL,
    @TypeOfWeb [nvarchar](200) NULL,
    @UsageBY [nvarchar](max) NULL,
    @UserAccessFrom [nvarchar](200) NULL,
    @CurrVersion [nvarchar](200) NULL,
    @TareVersion [nvarchar](200) NULL,
    @Brds [nvarchar](max) NULL,
    @BusJustification [nvarchar](max) NULL,
    @IsActive [bit]  NULL,
    
	---- Service Request


	@SRCode [nvarchar](200)  , 
	@SRSelectedfor [nvarchar](50) NULL,
	@SRRaisedBy [int]  NULL,
	@SRDate [datetime]  NULL,
	@SRShotDesc [nvarchar](200) NULL,
	@SRDesc [nvarchar](2000) NULL,
	@SRRaiseFor [int] NULL,
	@GuestEmployeeId [nvarchar](500) NULL,
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
	@CreatedBy [int] NULL,
    @CreatedDt [datetime] NULL,
    @ModifiedBy [int] NULL,
    @ModifiedDt [datetime] NULL
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
					@SRID = @SRID,
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
					@GuestReportingManagerEmployeeId=@GuestReportingManagerEmployeeId,
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
				 SELECT @SRID = SCOPE_IDENTITY();
				if (@@ERROR >0)
				Begin
					select @err_num=4000
						select @err_msg='Insert failed'
		
						raiserror ('Update :%d: %s',16,1,@err_num,@err_msg);
						Return;
			   End
            BEGIN
				select @SRID =  SRID FROM [IT].[ServiceRequest];
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
                    [IsActive],
                    [CreatedBy],
                    [CreatedDt],
                    [ModifiedBy],
                    [ModifiedDt]
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
                    @IsActive,
                    @CreatedBy,
                    @CreatedDt,
                    @ModifiedBy,
                    @ModifiedDt
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
                [IsActive] = @IsActive,
                [CreatedBy] = @CreatedBy,
                [CreatedDt] = @CreatedDt,
                [ModifiedBy] = @ModifiedBy,
                [ModifiedDt] = GETDATE()
            WHERE SWID = @SWID;

            COMMIT TRANSACTION;
        END
        ELSE IF @Flag = 'D' -- Delete CR Approver Field
        BEGIN
            BEGIN TRANSACTION;

            DELETE FROM [IT].[SRSoftware] WHERE SWID = @SWID;

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
        
            RAISERROR ('IssueList Transaction Error :%d: %s', 16, 1, @err_num, @err_msg);
        END
    END CATCH
END


error 				select @SRID =  SRID FROM [IT].[ServiceRequest];
