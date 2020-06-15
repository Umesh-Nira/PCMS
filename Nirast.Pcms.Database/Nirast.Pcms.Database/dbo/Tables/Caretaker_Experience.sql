CREATE TABLE [dbo].[Caretaker_Experience](
	[ExperienceId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CompanyName] [nvarchar](100) NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
 CONSTRAINT [PK_Caretaker_Experience] PRIMARY KEY CLUSTERED 
(
	[ExperienceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Caretaker_Experience]  WITH CHECK ADD  CONSTRAINT [FK_Caretaker_Experience_UserDetails_Master] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserDetails_Master] ([UserId])
GO

ALTER TABLE [dbo].[Caretaker_Experience] CHECK CONSTRAINT [FK_Caretaker_Experience_UserDetails_Master]
GO


