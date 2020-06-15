CREATE PROC [dbo].[SpSelectPrivileges] 
(@RoleId INT) 
AS
BEGIN
	IF(SELECT Count(RoleId) from Role_Privileges WHERE RoleId = @RoleId) > 0
		BEGIN
			SELECT	Settings_Module.ModuleId, 
					Settings_Module.ModuleName, 
					R.PrivilegeId, 
					R.AllowView, 
					R.AllowEdit, 
					R.AllowDelete
			FROM	Role_Privileges R
			INNER JOIN	Settings_Module ON R.ModuleId = Settings_Module.ModuleId
			WHERE	RoleId = @RoleId
		END
	ELSE
		BEGIN
			SELECT	Settings_Module.ModuleId, 
					Settings_Module.ModuleName, 
					R.PrivilegeId, 
					R.AllowView, 
					R.AllowEdit, 
					R.AllowDelete
			FROM	Role_Privileges R
			RIGHT JOIN	Settings_Module ON R.ModuleId = Settings_Module.ModuleId AND RoleId = @RoleId
		END
END