using IT_Portal.Application.Contracts.Persistence.SR;
using IT_Portal.Application.Features;
using IT_Portal.Application.Features.SR;
using IT_Portal.Persistence.DatabaseContext;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IT_Portal.Persistence.Repositories.SR
{
    public class SRFTPAccessRespository : ISRFTPAccess
    {
        private readonly MicroLabsDevContext _context;

        public SRFTPAccessRespository(MicroLabsDevContext context)
        {
            this._context = context;
        }

        public async Task<CommonRsult> PostFTPAccess(SRFTPAccess sRFTPAccess)
        {
            CommonRsult result = new CommonRsult();
            try
            {
                DataTable dt = new DataTable();
                var con = (SqlConnection)_context.Database.GetDbConnection();
                using (var cmd = new SqlCommand("IT.sp_SRFTPAccess", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Flag", sRFTPAccess.Flag);
                    cmd.Parameters.AddWithValue("@SRID", sRFTPAccess.SRID);
                    cmd.Parameters.AddWithValue("@SRFTPAID", sRFTPAccess.SRFTPAID);
                    cmd.Parameters.AddWithValue("@SupportID", sRFTPAccess.SupportID);
                    cmd.Parameters.AddWithValue("@ReqType", sRFTPAccess.ReqType);
                    cmd.Parameters.AddWithValue("@AccessRequire", sRFTPAccess.AccessRequire);
                    cmd.Parameters.AddWithValue("@AccessType", sRFTPAccess.AccessType);
                    cmd.Parameters.AddWithValue("@AccessPath", sRFTPAccess.AccessPath);
                    cmd.Parameters.AddWithValue("@Description", sRFTPAccess.Description);
                    cmd.Parameters.AddWithValue("@OwnerEmail", sRFTPAccess.OwnerEmail);
                    cmd.Parameters.AddWithValue("@OwnerPlant", sRFTPAccess.OwnerPlant);
                    cmd.Parameters.AddWithValue("@EmpType", sRFTPAccess.EmpType);
                    cmd.Parameters.AddWithValue("@Justification", sRFTPAccess.Justification);
                    cmd.Parameters.AddWithValue("@IsActive", sRFTPAccess.IsActive);

                    cmd.Parameters.AddWithValue("@SRCode", sRFTPAccess.SRVariable.SRCode);
                    cmd.Parameters.AddWithValue("@SRSelectedfor", sRFTPAccess.SRVariable.SRSelectedfor);
                    cmd.Parameters.AddWithValue("@SRRaisedBy", sRFTPAccess.SRVariable.SRRaisedBy);
                    cmd.Parameters.AddWithValue("@SRDate", sRFTPAccess.SRVariable.SRDate);
                    cmd.Parameters.AddWithValue("@SRShotDesc", sRFTPAccess.SRVariable.SRShotDesc);
                    cmd.Parameters.AddWithValue("@SRDesc", sRFTPAccess.SRVariable.SRDesc);
                    cmd.Parameters.AddWithValue("@SRRaiseFor", sRFTPAccess.SRVariable.SRRaiseFor);
                    cmd.Parameters.AddWithValue("@GuestEmployeeId", sRFTPAccess.SRVariable.GuestEmployeeId);
                    cmd.Parameters.AddWithValue("@GuestName", sRFTPAccess.SRVariable.GuestName);
                    cmd.Parameters.AddWithValue("@GuestEmail", sRFTPAccess.SRVariable.GuestEmail);
                    cmd.Parameters.AddWithValue("@GuestContactNo", sRFTPAccess.SRVariable.GuestContactNo);
                    cmd.Parameters.AddWithValue("@GRManagerEmpId", sRFTPAccess.SRVariable.GRManagerEmpId);
                    cmd.Parameters.AddWithValue("@Type", sRFTPAccess.SRVariable.Type);
                    cmd.Parameters.AddWithValue("@GuestCompany", sRFTPAccess.SRVariable.GuestCompany);
                    cmd.Parameters.AddWithValue("@PlantID", sRFTPAccess.SRVariable.PlantID);
                    cmd.Parameters.AddWithValue("@AssetID", sRFTPAccess.SRVariable.AssetID);
                    cmd.Parameters.AddWithValue("@CategoryID", sRFTPAccess.SRVariable.CategoryID);
                    cmd.Parameters.AddWithValue("@CategoryTypID", sRFTPAccess.SRVariable.CategoryTypID);
                    cmd.Parameters.AddWithValue("@Priority", sRFTPAccess.SRVariable.Priority);
                    cmd.Parameters.AddWithValue("@Source", sRFTPAccess.SRVariable.Source);
                    cmd.Parameters.AddWithValue("@Attachment", sRFTPAccess.SRVariable.Attachment);
                    cmd.Parameters.AddWithValue("@Status", sRFTPAccess.SRVariable.Status);
                    cmd.Parameters.AddWithValue("@AssignedTo", sRFTPAccess.SRVariable.AssignedTo);
                    cmd.Parameters.AddWithValue("@AssignedBy", sRFTPAccess.SRVariable.AssignedBy);
                    cmd.Parameters.AddWithValue("@AssignedOn", sRFTPAccess.SRVariable.AssignedOn);
                    cmd.Parameters.AddWithValue("@Remarks", sRFTPAccess.SRVariable.Remarks);
                    cmd.Parameters.AddWithValue("@ProposedResolutionOn", sRFTPAccess.SRVariable.ProposedResolutionOn);
                    cmd.Parameters.AddWithValue("@CreatedBy", sRFTPAccess.SRVariable.CreatedBy);



                    using (var da = new SqlDataAdapter(cmd))
                    {
                        await Task.Run(() => da.Fill(dt));
                        result.Type = "S";
                        result.Message = "Insert Successfully";

                    }
                }
            }

            catch (Exception ex)
            {
                result.Type = "E";
                result.Message = ex.Message;
            }
            return result;
        }
    }
}



above my Resposity and below by error:
{
  "type": "E",
  "message": "IssueList Transaction Error :8152: String or binary data would be truncated.",
  "data": null,
  "count": 0
}
