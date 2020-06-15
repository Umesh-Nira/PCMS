CREATE PROC SpChangeUserStatus
	(@UserRegnId INT, @Status SMALLINT) 
AS
BEGIN
		UPDATE [dbo].[UserDetails_Master]
		SET UserStatus = @Status 
		WHERE UserId = @UserRegnId	
END