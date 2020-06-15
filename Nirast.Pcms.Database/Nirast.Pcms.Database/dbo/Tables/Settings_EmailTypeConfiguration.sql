CREATE TABLE [dbo].[Settings_EmailTypeConfiguration] (
    [ConfigId]    INT            IDENTITY (1, 1) NOT NULL,
    [EmailTypeId] INT            NOT NULL,
    [FromEmail]   NVARCHAR (50)  NULL,
    [Password]    NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_Settings_EmailTypeConfiguration] PRIMARY KEY CLUSTERED ([ConfigId] ASC)
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Settings_EmailTypeConfiguration]
    ON [dbo].[Settings_EmailTypeConfiguration]([EmailTypeId] ASC);

