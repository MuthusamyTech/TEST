 join issuse in _context.IssueListHistories on m.IssueId equals issuse.IssueId into issueHistories
                from issuse in issueHistories.DefaultIfEmpty()
