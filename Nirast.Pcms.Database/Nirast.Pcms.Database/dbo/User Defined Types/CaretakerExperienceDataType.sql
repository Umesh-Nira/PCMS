CREATE TYPE [dbo].[CaretakerExperienceDataType] AS TABLE(
	[DateFrom] [datetime] NOT NULL,
	[DateTo] [datetime] NOT NULL,
	[Company] [nvarchar](100) NOT NULL,
	[CareTakerUserId] [int] NOT NULL
)
GO