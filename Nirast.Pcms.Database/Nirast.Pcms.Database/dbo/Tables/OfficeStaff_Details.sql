CREATE TABLE [dbo].[OfficeStaff_Details] (
    [StaffId]         INT IDENTITY (1, 1) NOT NULL,
    [DesignationId]   INT NOT NULL,
    [UserId]          INT NOT NULL,
    [RoleId]          INT NOT NULL,
    [QualificationId] INT NULL,
    CONSTRAINT [PK_OfficeStaff_Details] PRIMARY KEY CLUSTERED ([StaffId] ASC),
    CONSTRAINT [FK_OfficeStaff_Details_Settings_Designations] FOREIGN KEY ([DesignationId]) REFERENCES [dbo].[Settings_Designations] ([DesignationId]),
    CONSTRAINT [FK_OfficeStaff_Details_Settings_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Settings_Role] ([RoleId]),
    CONSTRAINT [FK_OfficeStaff_Details_UserDetails_Master] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserDetails_Master] ([UserId])
);



GO


GO


GO


GO


GO


GO


GO
