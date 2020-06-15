CREATE TABLE [dbo].[Caretaker_Qualification](
	[CaretakerQualificationId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[QualificationId] [int] NOT NULL,
 CONSTRAINT [PK_Caretaker_Qualification] PRIMARY KEY CLUSTERED 
(
	[CaretakerQualificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Caretaker_Qualification]  WITH CHECK ADD  CONSTRAINT [FK_Caretaker_Qualification_Settings_Qualifications] FOREIGN KEY([QualificationId])
REFERENCES [dbo].[Settings_Qualifications] ([QualificationId])
GO

ALTER TABLE [dbo].[Caretaker_Qualification] CHECK CONSTRAINT [FK_Caretaker_Qualification_Settings_Qualifications]
GO

ALTER TABLE [dbo].[Caretaker_Qualification]  WITH CHECK ADD  CONSTRAINT [FK_Caretaker_Qualification_UserDetails_Master] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserDetails_Master] ([UserId])
GO

ALTER TABLE [dbo].[Caretaker_Qualification] CHECK CONSTRAINT [FK_Caretaker_Qualification_UserDetails_Master]
GO
