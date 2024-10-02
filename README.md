[HttpGet("GetSupportValue")]
public IActionResult GetSupport()
{
    var data = _context.Supports.ToListAsync();
    return Ok(data);
}
