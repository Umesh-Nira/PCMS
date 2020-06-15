CREATE TABLE [dbo].[Settings_Role] (
    [RoleId]   INT           IDENTITY (1, 1) NOT NULL,
    [RoleName] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Settings_Role] PRIMARY KEY CLUSTERED ([RoleId] ASC),
    CONSTRAINT [Role_Unique] UNIQUE NONCLUSTERED ([RoleName] ASC)
);



GO