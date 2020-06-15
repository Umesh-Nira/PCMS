
CREATE PROC [dbo].[SpUpdateUserEmail] 
	(
	 @UserRegnId INT,
	 @EmailId nvarchar(50)
	 ) 
AS
BEGIN
		UPDATE [dbo].[UserDetails_Master]
		SET IsVerified = 'False'
		 
		WHERE UserId = @UserRegnId	

			UPDATE [dbo].[User_LoginDetails]
		SET EmailId = @EmailId
		 
		WHERE UserId = @UserRegnId	
END