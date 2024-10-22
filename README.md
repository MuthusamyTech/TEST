ALTER TABLE [IT].[Checklist]  WITH CHECK ADD  CONSTRAINT [FK_Checklist_Support] FOREIGN KEY([SupportID])
REFERENCES [IT].[Support] ([SupportID])
GO
