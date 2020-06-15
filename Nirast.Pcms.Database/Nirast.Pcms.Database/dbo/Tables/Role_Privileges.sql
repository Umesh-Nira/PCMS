CREATE TABLE [dbo].[Role_Privileges](
	[PrivilegeId] [int] IDENTITY(1,1) NOT NULL,
	[ModuleId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[AllowView] [bit] NOT NULL,
	[AllowEdit] [bit] NOT NULL,
	[AllowDelete] [bit] NOT NULL,
 CONSTRAINT [PK_PCMS_RolePrivileges_Id] PRIMARY KEY CLUSTERED 
(
	[PrivilegeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Role_Privileges]  WITH CHECK ADD  CONSTRAINT [FK_Role_Privileges_Settings_Module] FOREIGN KEY([ModuleId])
REFERENCES [dbo].[Settings_Module] ([ModuleId])
GO

ALTER TABLE [dbo].[Role_Privileges] CHECK CONSTRAINT [FK_Role_Privileges_Settings_Module]
GO
