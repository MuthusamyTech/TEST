using IT_Portal.Application.Contracts.Persistence;
using IT_Portal.Application.Features;
using IT_Portal.Persistence.DatabaseContext;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IT_Portal.Persistence.Repositories
{
    public class SupportRespository:ISupportMaster
    {
        private readonly MicroLabsDevContext _context;

        public SupportRespository( MicroLabsDevContext context) {
            this._context = context;
        }

        public Task<CommonRsult> PostSupport(SupportMaster supp)
        {
            using (var context = _context)
            {
                var SupportMaster = new SupportMaster
                {
                    SupportId =1,
                    SupportName ="Muthu",
                    ParentId=supp.ParentId,
                    RPM = supp.RPM,
                    HOD = supp.HOD,
                    Image = supp.Image,
                    URL = supp.URL,
                    IsActive = supp.IsActive,
                    IsVisible = supp.IsVisible,
                    CreatedBy = supp.CreatedBy,
                    CreatedDt = supp.CreatedDt,
                    ModifiedBy = supp.ModifiedBy
                    ModifiedDt = supp.ModifiedDt,
                   
                };
                context.Supports.Add(SupportMaster);
                context.SaveChanges();
            }
           
        }
    }
}
