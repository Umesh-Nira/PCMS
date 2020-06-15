CREATE PROC SpGetEmailIdForUserId 
	(@UserID INT) 
AS
BEGIN
	SELECT EmailId as EmailAddress FROM [dbo].[User_LoginDetails]
	WHERE [User_LoginDetails].UserId = @UserID
END