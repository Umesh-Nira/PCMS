CREATE TYPE [dbo].[CaretakerServiceDataType] AS TABLE(
	[ServiceId] [int] NOT NULL,
	[PayingRate] [numeric](18, 2) NULL DEFAULT ((0)),
	[DisplayRate] [numeric](18, 2) NULL DEFAULT ((0)),
	[CareTakerUserId] [int] NOT NULL
)
GO
