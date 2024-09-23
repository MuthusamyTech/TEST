 join ResolveEmp in _context.Employees on issuseHis.ResolvedBy equals ResolveEmp.EmployeeNo into resEmp
                from ResolveEmp in resEmp.DefaultIfEmpty()




                ResolveBy = ResolveEmp != null ? ResolveEmp.FirstName + " " + ResolveEmp.LastName : null, // Handle null ResolveEmp
<mat-paginator [length]="totalItems"
                  [pageSize]="pageSize"
                  [pageIndex]="pageIndex"
                  [pageSizeOptions]="[10,25,50,100]"
                  (page)="onPageChange($event)"
                  aria-label="Select page" style="margin-right:34%">
    </mat-paginator>
