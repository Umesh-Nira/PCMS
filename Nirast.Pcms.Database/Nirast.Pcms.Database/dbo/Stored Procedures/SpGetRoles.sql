CREATE PROCEDURE [dbo].[SpGetRoles]
	(@RoleId int)
AS
BEGIN

	IF @RoleId = 0
		SET @RoleId = NULL
		
			SELECT RoleId,
			       RoleName
			FROM [dbo].[Settings_Role]
			where RoleId = ISNULL(@RoleId,RoleId)
END
