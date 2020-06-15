CREATE PROC SpGetViewPrivilegeAccess
(
	@RoleId INT,
	@ModuleId INT
) AS
BEGIN
	SELECT 
		AllowView,
		AllowEdit,
		AllowDelete
	FROM Role_Privileges
	WHERE RoleId = @RoleId AND ModuleId = @ModuleId
END