CREATE TABLE [dbo].[Client_AddressDetails](
	[AddressId] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[BuildingName] [nvarchar](500) NULL,
	[Location] [nvarchar](50) NULL,
	[CityId] [int] NULL,
	[Zipcode] [nvarchar](10) NULL,
	[Phone1] [nvarchar](500) NULL,
	[Phone2] [nvarchar](500) NULL,
 CONSTRAINT [PK_Client_AddressDetails] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Client_AddressDetails]  WITH CHECK ADD  CONSTRAINT [FK_Client_AddressDetails_Client_Master] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client_Master] ([ClientId])
GO

ALTER TABLE [dbo].[Client_AddressDetails] CHECK CONSTRAINT [FK_Client_AddressDetails_Client_Master]
GO

ALTER TABLE [dbo].[Client_AddressDetails]  WITH CHECK ADD  CONSTRAINT [FK_Client_AddressDetails_Settings_City] FOREIGN KEY([CityId])
REFERENCES [dbo].[Settings_City] ([CityId])
GO

ALTER TABLE [dbo].[Client_AddressDetails] CHECK CONSTRAINT [FK_Client_AddressDetails_Settings_City]
GO
