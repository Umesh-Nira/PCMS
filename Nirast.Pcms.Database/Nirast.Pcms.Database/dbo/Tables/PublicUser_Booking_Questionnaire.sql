CREATE TABLE [dbo].[PublicUser_Booking_Questionnaire](
	[BookingQuestionnaireId] [int] IDENTITY(1,1) NOT NULL,
	[BookingId] [int] NOT NULL,
	[Answer1] [nvarchar](500) NULL,
	[Answer2] [nvarchar](500) NULL,
	[Answer3] [nvarchar](500) NULL,
	[Answer4] [nvarchar](500) NULL,
	[Answer5] [nvarchar](500) NULL,
	[Answer6] [nvarchar](500) NULL,
 CONSTRAINT [PK_PublicUser_Booking_Questionnaire] PRIMARY KEY CLUSTERED 
(
	[BookingQuestionnaireId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[PublicUser_Booking_Questionnaire]  WITH CHECK ADD  CONSTRAINT [FK_PublicUser_Booking_Questionnaire_PublicUser_Caretaker_Booking] FOREIGN KEY([BookingId])
REFERENCES [dbo].[PublicUser_Caretaker_Booking] ([BookingId])
GO

ALTER TABLE [dbo].[PublicUser_Booking_Questionnaire] CHECK CONSTRAINT [FK_PublicUser_Booking_Questionnaire_PublicUser_Caretaker_Booking]
GO
