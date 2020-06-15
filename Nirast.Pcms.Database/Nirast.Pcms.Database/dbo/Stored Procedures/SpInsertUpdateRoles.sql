CREATE PROCEDURE [dbo].[SpInsertUpdateRoles]
	(@RoleId int = 0,
     @RoleName varchar(50))
AS
BEGIN
	     IF @RoleId=0
		 BEGIN
			 INSERT INTO [dbo].[Settings_Role]
			 (
						 RoleName
			 )
			 VALUES
			 (
						 @RoleName
			 )
		 END
		 ELSE
         BEGIN
			 UPDATE [dbo].[Settings_Role]
				SET RoleName = @RoleName           
				WHERE RoleId=@RoleId
      END
END

