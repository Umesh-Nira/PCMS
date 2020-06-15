CREATE TABLE [dbo].[Client_ShiftDetails](
	[ClientShiftId] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[ShiftId] [int] NOT NULL,
 CONSTRAINT [PK_Client_ShiftDetails] PRIMARY KEY CLUSTERED 
(
	[ClientShiftId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Client_ShiftDetails]  WITH CHECK ADD  CONSTRAINT [FK_Client_ShiftDetails_Client_Master] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client_Master] ([ClientId])
GO

ALTER TABLE [dbo].[Client_ShiftDetails] CHECK CONSTRAINT [FK_Client_ShiftDetails_Client_Master]
GO

ALTER TABLE [dbo].[Client_ShiftDetails]  WITH CHECK ADD  CONSTRAINT [FK_Client_ShiftDetails_Settings_WorkShift] FOREIGN KEY([ShiftId])
REFERENCES [dbo].[Settings_TimeShift] ([TimeShiftId])
GO

ALTER TABLE [dbo].[Client_ShiftDetails] CHECK CONSTRAINT [FK_Client_ShiftDetails_Settings_WorkShift]
GO