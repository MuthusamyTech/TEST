ALTER TRIGGER [IT].[TR_SRSoftwareHistory]
ON [IT].[SRSoftware]
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Handle INSERT and UPDATE
    INSERT INTO [IT].[SRSoftwareHistory]
    (
      [SRID], [SupportID], [SoftwareType], [SoftwareName], [SoftwareVersionName], 
      [VendorName], [InstType], [LicenceType], [Location], [Department], [NoOfUers], 
      [NoOfLicence], [CostPerLicence], [TotalCost], [AMCAppilcable], [CostForAMC], 
      [ScopeOfAMC], [IsInstReq], [InstCharge], [DtlsOfInst], [DtlsOfinstDt], [TypeOfDev], 
      [DtlsOfDev], [IsInterfaceReq], [InterfaceReq], [InterfaceWith], [IsGxpApp], 
      [NonFunReq], [DtlsOfReq], [WhereHosted], [TypeOfWeb], [UsageBY], [UserAccessFrom], 
      [CurrVersion], [TareVersion], [Brds], [BusJustification], [Justification], [IsActive], 
      [CreatedBy], [CreatedDt], [ModifiedBy], [ModifiedDt]
    )
    SELECT
      SR.SRID, SR.SupportID, SR.SoftwareType, SR.SoftwareName, SR.SoftwareVersionName, 
      SR.VendorName, SR.InstType, SR.LicenceType, SR.Location, SR.Department, SR.NoOfUers, 
      SR.NoOfLicence, SR.CostPerLicence, SR.TotalCost, SR.AMCAppilcable, SR.CostForAMC, 
      SR.ScopeOfAMC, SR.IsInstReq, SR.InstCharge, SR.DtlsOfInst, SR.DtlsOfinstDt, SR.TypeOfDev, 
      SR.DtlsOfDev, SR.IsInterfaceReq, SR.InterfaceReq, SR.InterfaceWith, SR.IsGxpApp, 
      SR.NonFunReq, SR.DtlsOfReq, SR.WhereHosted, SR.TypeOfWeb, SR.UsageBY, SR.UserAccessFrom, 
      SR.CurrVersion, SR.TareVersion, SR.Brds, SR.BusJustification, SR.Justification, SR.IsActive, 
      SR.CreatedBy, SR.CreatedDt, SR.ModifiedBy, SR.ModifiedDt
    FROM INSERTED SR;

    -- Handle DELETE
    INSERT INTO [IT].[SRSoftwareHistory]
    (
      [SRID], [SupportID], [SoftwareType], [SoftwareName], [SoftwareVersionName], 
      [VendorName], [InstType], [LicenceType], [Location], [Department], [NoOfUers], 
      [NoOfLicence], [CostPerLicence], [TotalCost], [AMCAppilcable], [CostForAMC], 
      [ScopeOfAMC], [IsInstReq], [InstCharge], [DtlsOfInst], [DtlsOfinstDt], [TypeOfDev], 
      [DtlsOfDev], [IsInterfaceReq], [InterfaceReq], [InterfaceWith], [IsGxpApp], 
      [NonFunReq], [DtlsOfReq], [WhereHosted], [TypeOfWeb], [UsageBY], [UserAccessFrom], 
      [CurrVersion], [TareVersion], [Brds], [BusJustification], [Justification], [IsActive], 
      [CreatedBy], [CreatedDt], [ModifiedBy], [ModifiedDt]
    )
    SELECT
      SR.SRID, SR.SupportID, SR.SoftwareType, SR.SoftwareName, SR.SoftwareVersionName, 
      SR.VendorName, SR.InstType, SR.LicenceType, SR.Location, SR.Department, SR.NoOfUers, 
      SR.NoOfLicence, SR.CostPerLicence, SR.TotalCost, SR.AMCAppilcable, SR.CostForAMC, 
      SR.ScopeOfAMC, SR.IsInstReq, SR.InstCharge, SR.DtlsOfInst, SR.DtlsOfinstDt, SR.TypeOfDev, 
      SR.DtlsOfDev, SR.IsInterfaceReq, SR.InterfaceReq, SR.InterfaceWith, SR.IsGxpApp, 
      SR.NonFunReq, SR.DtlsOfReq, SR.WhereHosted, SR.TypeOfWeb, SR.UsageBY, SR.UserAccessFrom, 
      SR.CurrVersion, SR.TareVersion, SR.Brds, SR.BusJustification, SR.Justification, SR.IsActive, 
      SR.CreatedBy, SR.CreatedDt, SR.ModifiedBy, SR.ModifiedDt
    FROM DELETED SR;

    PRINT('Save Successfully');
END
