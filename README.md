 join ResolveEmp in _context.Employees on issuseHis.ResolvedBy equals ResolveEmp.EmployeeNo into resEmp
                from ResolveEmp in resEmp.DefaultIfEmpty()




                ResolveBy = ResolveEmp != null ? ResolveEmp.FirstName + " " + ResolveEmp.LastName : null, // Handle null ResolveEmp
