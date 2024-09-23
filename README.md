     public async Task<CommonRsult> GetIssueReport(EcrFilterRequest filterRquest)
{
    var result = new CommonRsult();
    try
    {
        var totalCount = await _context.VwIssueLists.CountAsync();
        var a = from m in _context.VwIssueLists
                join employee in _context.Employees on m.Raisedbyid.ToString() equals employee.EmployeeNo
                        //
                        join RaisedByEmp in _context.Employees on m.Raisedbyid.ToString() equals RaisedByEmp.EmployeeNo
                        join IssuerisedEmp in _context.Employees on m.Issuerisedforid.ToString() equals IssuerisedEmp.EmployeeNo
                        join UpdateEmp in _context.Employees on m.ModifiedBy.ToString() equals UpdateEmp.EmployeeNo
                        join issuseHis in _context.VwIssueListHistories on m.IssueId equals issuseHis.IssueId
                        join ResolveEmp in _context.Employees on issuseHis.ResolvedBy equals ResolveEmp.EmployeeNo
                //join ClosedBy in _context.Employees on m.ClosedBY.ToString() equals ClosedBy.EmployeeNo

                //
                join payGroup in _context.PaygroupMasters on employee.PaygroupId equals payGroup.Paygroup into pg
                        from payGroup in pg.DefaultIfEmpty() // Left join to handle cases where there might not be a match
                        join category in _context.EmpCategoryMasters on employee.EmployeeCategoryid equals category.Staffcat into cat
                        from category in cat.DefaultIfEmpty() // Left join for the same reason
                        select new
                        {
                            IssueId = m.IssueId,
                            IssueCode = m.IssueCode,
                            RaisedById = m.Raisedbyid,
                            RaisedByEmp = RaisedByEmp.FirstName +" "+ RaisedByEmp.LastName,
                            IssueDate = m.IssueDate,
                            IssueShotDesc = m.IssueShotDesc,
                            IssueDesc = m.IssueDesc,
                            IssuerisedForId = m.Issuerisedforid,
                            Issuerisedfor = IssuerisedEmp.FirstName + " " + IssuerisedEmp.LastName,
                            IssueForGuest = m.IssueForGuest,
                            Type = m.Type,
                            PlantId = m.PlantId,
                            PlantName = m.Plantname,
                            Paygroup = payGroup.ShortDesc,
                            empcategory = category.Catltxt,
                            AssignedToId = m.AssignedToid,
                            AssignedTo = m.AssignedTo,
                            UpdateBy = UpdateEmp.FirstName + ' ' + UpdateEmp.LastName,
                            UpdateDt = m.ModifiedDt,
                            ResolveBy = ResolveEmp.FirstName + ' ' + ResolveEmp.LastName,
                            ResolveDt = issuseHis.ResolvedOn,
                            ResolveRemarks = issuseHis.ResolveRemarks,
                            ClosedBY = issuseHis.ClosedBY,
                            ClosedRemark = issuseHis.ClosedRemark,
                            ClosedDate = issuseHis.ClosedDate,
                            CategoryId = m.CategoryId,
                            CategoryName = m.CategoryName, // Get category name from the category table category.Catltxt
                            CategoryTypId = m.CategoryTypId,
                            CategoryType = m.CategoryType,
                            PriorityId = m.Priorityid,
                            PriorityName = m.PriorityName,
                            Status = m.Status,
                            AssignedById = m.Assignedbyid,
                            AssignedBy = m.AssignedBy,
                            AssignedOn = m.AssignedOn,
                            Remarks = m.Remarks,
                            CreatedBy = m.CreatedBy,
                            CreatedDt = m.CreatedDt,
                            ModifiedBy = m.ModifiedBy,
                            ModifiedDt = m.ModifiedDt,
                            SlaStatus = m.Slastatus,
                         /*   SlaTime = m.SlaTime,
                            SlaUnit = m.Slaunit,*/
                            RaisedByFirstName = employee.FirstName,
                            
                        };


        var paginatedResult = await a
            .Skip((filterRquest.pageNumber - 1) * filterRquest.pageSize)
            .Take(filterRquest.pageSize)
            .ToListAsync();

        result.Data = paginatedResult;
        result.Count = totalCount;
        return result;
    }
    catch (Exception ex)
    {
        result.Message = ex.Message;
        return result;
    }

}
