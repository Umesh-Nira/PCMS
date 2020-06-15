CREATE TYPE [dbo].[CaretakerQualificationOthersDataType] AS TABLE(
	[QualificationId] [int] NULL,
	[QualificationName] [nvarchar](100) NULL,
	[CareTakerUserId] [int] NOT NULL
)
GO
