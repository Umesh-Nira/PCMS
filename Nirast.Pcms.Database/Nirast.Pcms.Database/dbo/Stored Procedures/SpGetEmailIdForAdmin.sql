CREATE PROC [dbo].[SpGetEmailIdForAdmin] --5
	(@UserTypeID int)
AS
BEGIN
	SELECT  EmailId as EmailAddress 
	FROM [dbo].[User_LoginDetails] uld
	inner join [dbo].[UserDetails_Master] udm on udm.UserId=uld.UserId
	WHERE udm.UserTypeId = @UserTypeID and udm.UserStatus <> 3
END