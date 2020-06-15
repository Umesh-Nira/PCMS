CREATE TABLE [dbo].[Settings_CompanyProfile] (
    [CompanyId]    INT             IDENTITY (1, 1) NOT NULL,
    [CompanyName]  NVARCHAR (100)  NULL,
    [TagLine]      NVARCHAR (200)  NULL,
    [AddressLine]  NVARCHAR (250)  NULL,
    [CityId]       INT             NULL,
    [ZipCode]      NVARCHAR (10)   NULL,
    [PhoneNo1]     NVARCHAR (25)   NULL,
    [PhoneNo2]     NVARCHAR (25)   NULL,
    [EmailAddress] NVARCHAR (100)  NULL,
    [Website]      NVARCHAR (100)  NULL,
    [Logo]         VARBINARY (MAX) NULL,
    [Description1] NVARCHAR (500)  NULL,
    [Description2] NVARCHAR (500)  NULL,
    [Description3] NVARCHAR (500)  NULL
);

