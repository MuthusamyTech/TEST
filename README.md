using IT_Portal.Application.Contracts.Persistence;
using IT_Portal.Application.Features;
using IT_Portal.Persistence.DatabaseContext;
using System;
using System.Threading.Tasks;

namespace IT_Portal.Persistence.Repositories
{
    public class SupportRepository : ISupportMaster
    {
        private readonly MicroLabsDevContext _context;

        public SupportRepository(MicroLabsDevContext context)
        {
            _context = context;
        }

        public async Task<CommonResult> PostSupport(SupportMaster supp)
        {
            try
            {
                var supportMaster = new SupportMaster
                {
                    SupportId = 1, // You should probably generate this dynamically (e.g., an auto-increment ID)
                    SupportName = "Muthu",
                    ParentId = supp.ParentId,
                    RPM = supp.RPM,
                    HOD = supp.HOD,
                    Image = supp.Image,
                    URL = supp.URL,
                    IsActive = supp.IsActive,
                    IsVisible = supp.IsVisible,
                    CreatedBy = supp.CreatedBy,
                    CreatedDt = supp.CreatedDt,
                    ModifiedBy = supp.ModifiedBy,
                    ModifiedDt = supp.ModifiedDt
                };

                _context.Supports.Add(supportMaster);
                await _context.SaveChangesAsync();

                return new CommonResult
                {
                    Success = true,
                    Message = "Support record added successfully."
                };
            }
            catch (Exception ex)
            {
                // You can log the exception here if needed

                return new CommonResult
                {
                    Success = false,
                    Message = $"Error: {ex.Message}"
                };
            }
        }
    }
}
