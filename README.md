var Data = await _context.VwIssueListHistories.ToListAsync();
var value = Data.Where(Data.status = "Resolved")
return Ok(Data);
