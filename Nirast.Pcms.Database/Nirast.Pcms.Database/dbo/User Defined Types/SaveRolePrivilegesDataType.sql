CREATE TYPE [dbo].[SaveRolePrivilegesDataType] AS TABLE (
    [PrivilegeId] INT NOT NULL,
    [RoleId]      INT NOT NULL,
    [ModuleId]    INT NOT NULL,
    [AllowView]   BIT DEFAULT ((0)) NULL,
    [AllowEdit]   BIT DEFAULT ((0)) NULL,
    [AllowDelete] BIT DEFAULT ((0)) NULL);