CREATE TABLE [dbo].[Caretaker_PublicUser_Service](
	[CaretakerServiceId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ServiceId] [int] NOT NULL,
	[PayingRate] [numeric](18, 2) NULL,
	[DisplayRate] [numeric](18, 2) NULL,
 CONSTRAINT [PK_Caretaker_PublicUser_Service] PRIMARY KEY CLUSTERED 
(
	[CaretakerServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Caretaker_PublicUser_Service]  WITH CHECK ADD  CONSTRAINT [FK_Caretaker_PublicUser_Service_Settings_CaretakerServices] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Settings_CaretakerServices] ([ServiceId])
GO

ALTER TABLE [dbo].[Caretaker_PublicUser_Service] CHECK CONSTRAINT [FK_Caretaker_PublicUser_Service_Settings_CaretakerServices]
GO

ALTER TABLE [dbo].[Caretaker_PublicUser_Service]  WITH CHECK ADD  CONSTRAINT [FK_Caretaker_PublicUser_Service_UserDetails_Master] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserDetails_Master] ([UserId])
GO

ALTER TABLE [dbo].[Caretaker_PublicUser_Service] CHECK CONSTRAINT [FK_Caretaker_PublicUser_Service_UserDetails_Master]
GO
