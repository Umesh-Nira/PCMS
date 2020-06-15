CREATE PROCEDURE [dbo].[SpDeleteRoles]
	(@RoleId int)
AS
BEGIN
	
		DELETE [dbo].[Settings_Role]
		WHERE  RoleId = @RoleId
END
