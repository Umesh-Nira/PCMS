CREATE TABLE [dbo].[Settings_CaretakerType] (
    [TypeId]   INT           IDENTITY (1, 1) NOT NULL,
    [TypeName] NVARCHAR (30) NOT NULL,
    [Color]    NVARCHAR (20) NULL,
    CONSTRAINT [PK_Settings_CaretakerType] PRIMARY KEY CLUSTERED ([TypeId] ASC),
    CONSTRAINT [CaretakerType_Unique] UNIQUE NONCLUSTERED ([TypeName] ASC)
);



