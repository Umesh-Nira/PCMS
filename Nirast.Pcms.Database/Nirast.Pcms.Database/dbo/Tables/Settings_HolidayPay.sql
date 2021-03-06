﻿CREATE TABLE [dbo].[Settings_HolidayPay](
	[HolidayPayId] [int] IDENTITY(1,1) NOT NULL,
	[HolidayPayValue] [float] NOT NULL,
 CONSTRAINT [PK_Settings_HolidayPay] PRIMARY KEY CLUSTERED 
(
	[HolidayPayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO