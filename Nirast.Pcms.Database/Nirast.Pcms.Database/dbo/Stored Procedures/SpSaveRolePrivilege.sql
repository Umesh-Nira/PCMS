CREATE PROC [dbo].[SpSaveRolePrivilege]
	(@RoleId INT,
	@RolePrivileges AS [dbo].[SaveRolePrivilegesDataType] Readonly)
AS
BEGIN
	DELETE FROM Role_Privileges 
	WHERE RoleId = @RoleId

	INSERT INTO Role_Privileges(
										RoleId,
										ModuleId,
										AllowView,
										AllowEdit,
										AllowDelete
									)
									SELECT 
										RoleId,
										ModuleId,
										AllowView,
										AllowEdit,
										AllowDelete
									FROM @RolePrivileges
END