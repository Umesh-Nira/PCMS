CREATE TABLE [dbo].[User_AddressDetails] (
    [AddressId] INT           IDENTITY (1, 1) NOT NULL,
    [UserId]    INT           NOT NULL,
    [HouseName] NVARCHAR (50) NULL,
    [Location]  NVARCHAR (50) NULL,
    [CityId]    INT           NULL,
    [Zipcode]   NVARCHAR (10) NULL,
    [Phone1] [nvarchar](500) NULL,
	[Phone2] [nvarchar](500) NULL,
    CONSTRAINT [PK_User_AddressDetails] PRIMARY KEY CLUSTERED ([AddressId] ASC),
    CONSTRAINT [FK_User_AddressDetails_UserDetails_Master] FOREIGN KEY ([CityId]) REFERENCES [dbo].[Settings_City] ([CityId])
);



GO


GO


GO
