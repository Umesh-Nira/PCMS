CREATE TABLE [dbo].[PublicUser_CareRecipientDetails](
	[CareRecipientDetailId] [int] IDENTITY(1,1) NOT NULL,
	[BookingId] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[HouseName] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[CityId] [int] NULL,
	[Zipcode] [nvarchar](10) NULL,
	[Phone1] [nvarchar](20) NULL,
	[Phone2] [nvarchar](50) NULL,
	[EmailId] [nvarchar](100) NULL,
	[Purpose] [nvarchar](max) NULL,
 CONSTRAINT [PK_PublicUser_CareRecipientDetails] PRIMARY KEY CLUSTERED 
(
	[CareRecipientDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[PublicUser_CareRecipientDetails]  WITH CHECK ADD  CONSTRAINT [FK_PublicUser_CareRecipientDetails_PublicUser_Caretaker_Booking] FOREIGN KEY([BookingId])
REFERENCES [dbo].[PublicUser_Caretaker_Booking] ([BookingId])
GO

ALTER TABLE [dbo].[PublicUser_CareRecipientDetails] CHECK CONSTRAINT [FK_PublicUser_CareRecipientDetails_PublicUser_Caretaker_Booking]
GO

ALTER TABLE [dbo].[PublicUser_CareRecipientDetails]  WITH CHECK ADD  CONSTRAINT [FK_PublicUser_CareRecipientDetails_Settings_City] FOREIGN KEY([CityId])
REFERENCES [dbo].[Settings_City] ([CityId])
GO

ALTER TABLE [dbo].[PublicUser_CareRecipientDetails] CHECK CONSTRAINT [FK_PublicUser_CareRecipientDetails_Settings_City]
GO


