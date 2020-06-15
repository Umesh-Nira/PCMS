CREATE TABLE [dbo].[Client_OneToOne_Details](
	[OneToOneDetailId] [int] IDENTITY(1,1) NOT NULL,
	[SchedulingId] [int] NOT NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Client_OneToOne_Details] PRIMARY KEY CLUSTERED 
(
	[OneToOneDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Client_OneToOne_Details]  WITH CHECK ADD  CONSTRAINT [FK_Client_OneToOne_Details_Client_Scheduling] FOREIGN KEY([SchedulingId])
REFERENCES [dbo].[Client_Scheduling] ([SchedulingId])
GO

ALTER TABLE [dbo].[Client_OneToOne_Details] CHECK CONSTRAINT [FK_Client_OneToOne_Details_Client_Scheduling]
GO