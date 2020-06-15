CREATE TABLE [dbo].[Settings_Qualifications] (
    [QualificationId]   INT          IDENTITY (1, 1) NOT NULL,
    [QualificationName] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Settings_Qualifications] PRIMARY KEY CLUSTERED ([QualificationId] ASC),
    CONSTRAINT [Qualification_Unique] UNIQUE NONCLUSTERED ([QualificationName] ASC)
);



GO

