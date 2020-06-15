CREATE TABLE [dbo].[Client_Caretaker_Mapping](
	[MappingId] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[CaretakerUserId] [int] NOT NULL,
	[Rate] [float] NULL,
 [ShiftId] INT NOT NULL DEFAULT 0, 
    CONSTRAINT [PK_Client_Caretaker_Mapping] PRIMARY KEY CLUSTERED 
(
	[MappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Client_Caretaker_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Client_Caretaker_Mapping_Client_Master] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client_Master] ([ClientId])
GO

ALTER TABLE [dbo].[Client_Caretaker_Mapping] CHECK CONSTRAINT [FK_Client_Caretaker_Mapping_Client_Master]
GO

ALTER TABLE [dbo].[Client_Caretaker_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Client_Caretaker_Mapping_UserDetails_Master] FOREIGN KEY([CaretakerUserId])
REFERENCES [dbo].[UserDetails_Master] ([UserId])
GO

ALTER TABLE [dbo].[Client_Caretaker_Mapping] CHECK CONSTRAINT [FK_Client_Caretaker_Mapping_UserDetails_Master]
GO
