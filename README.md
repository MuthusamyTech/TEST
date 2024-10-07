                var a = from m in IssueResolutionvalue
                            join employee in _context.Employees on m.Raisedbyid.ToString() equals employee.EmployeeNo

                        join RaisedByEmp in _context.Employees on m.Raisedbyid.ToString() equals RaisedByEmp.EmployeeNo
                        join IssuerisedEmp in _context.Employees on m.Issuerisedforid.ToString() equals IssuerisedEmp.EmployeeNo
                        /*join UpdateEmp in _context.Employees on m.ModifiedBy.ToString() equals UpdateEmp.EmployeeNo
                        */
                        join ResolveEmp in _context.Employees on m.ResolvedBy.ToString() equals ResolveEmp.EmployeeNo

                        join payGroup in _context.PaygroupMasters on employee.PaygroupId equals payGroup.Paygroup
                        join category in _context.EmpCategoryMasters on employee.EmployeeCategoryid equals category.Staffcat
                        
                        select new
                        {
                            IssueId = m.IssueId,
                            IssueCode = m.IssueCode,
                            RaisedById = m.Raisedbyid,
                            RaisedByEmp = RaisedByEmp.FirstName + " " + RaisedByEmp.LastName,
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
/*                            UpdateBy = UpdateEmp.FirstName + ' ' + UpdateEmp.LastName,
*/                            UpdateDt = m.ModifiedDt,
/*                            ResolveBy = ResolveEmp.FirstName + ' ' + ResolveEmp.LastName,
*/                            ResolveById = m.ResolvedBy,
                            ResolveDt = m.ResolvedOn,
                            ResolveRemarks = m.ResolveRemarks,
                            ClosedBY = m.ClosedBy,
                            ClosedRemark = m.ClosedRemark,
                            ClosedDate = m.ClosedDate,
                            CategoryId = m.CategoryId,
                            CategoryName = m.CategoryName,
                            CategoryTypId = m.CategoryTypId,
                            CategoryType = m.CategoryType,
                            PriorityId = m.Priorityid,
                            PriorityName = m.PriorityName,
                            Status = m.Status,
                            AssignedById = m.Assignedbyid,
                            AssignedBy = m.AssignedBy,
                            /*AssignedOn = m.ass,*/
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
                    
