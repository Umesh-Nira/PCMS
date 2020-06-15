CREATE PROC SpRejectCaretakerApplication(@UserRegnId INT) AS
BEGIN
	UPDATE  [dbo].[Caretaker_Details] 
	SET [CaretakerStatus] = 3 
	WHERE UserId = @UserRegnId

	UPDATE [dbo].[UserDetails_Master] 
	SET UserStatus = 2 
	WHERE [UserId] = @UserRegnId
END