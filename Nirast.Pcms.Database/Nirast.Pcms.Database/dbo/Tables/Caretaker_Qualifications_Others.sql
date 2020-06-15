CREATE TABLE [dbo].[Caretaker_Qualifications_Others](
	[OtherQualificationId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[QualificationName] [varchar](50) NULL,
 CONSTRAINT [PK_Caretaker_Qualifications_Others] PRIMARY KEY CLUSTERED 
(
	[OtherQualificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
