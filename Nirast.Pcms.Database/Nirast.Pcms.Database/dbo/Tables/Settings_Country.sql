﻿CREATE TABLE [dbo].[Settings_Country](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CountryCode] [nvarchar](10) NOT NULL,
	[CountryName] [nvarchar](50) NOT NULL,
	[PhoneCode] [nvarchar](10) NULL,
	[Currency] [nvarchar](10) NULL,
	[Symbol] [nvarchar](50) NULL,
	[IsDefault] [bit] NULL,
 CONSTRAINT [PK_Settings_Country] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Country_Unique] UNIQUE NONCLUSTERED 
(
	[CountryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [countryCode_unique] UNIQUE NONCLUSTERED 
(
	[CountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



GO

