CREATE TABLE [dbo].[Settings_EmailConfiguration] (
    [ConfigId]   INT            IDENTITY (1, 1) NOT NULL,
    [MailHost]   NVARCHAR (MAX) NULL,
    [MailPort]   INT            NULL,
    [SSL]        BIT            NULL,
    [IsDefault]  BIT            CONSTRAINT [pd_IsDefault] DEFAULT ((0)) NULL,
    [ConfigName] NVARCHAR (50)  NULL,
    CONSTRAINT [PK_dbo.Settings_EmailConfiguration] PRIMARY KEY CLUSTERED ([ConfigId] ASC)
);


