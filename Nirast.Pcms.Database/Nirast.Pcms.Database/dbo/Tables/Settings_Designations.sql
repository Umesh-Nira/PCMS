CREATE TABLE [dbo].[Settings_Designations] (
    [DesignationId]   INT           IDENTITY (1, 1) NOT NULL,
    [DesignationName] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Settings_Designations] PRIMARY KEY CLUSTERED ([DesignationId] ASC),
    CONSTRAINT [Designation_Unique] UNIQUE NONCLUSTERED ([DesignationName] ASC)
);



GO

