CREATE PROC [dbo].[SpGetEmailIdOfClientByClientId]--2
	(@ClientId int)
AS
BEGIN
	SELECT  isnull(L.EmailId,'') as EmailAddress 
	FROM [dbo].[Client_Master] uld
	LEFT JOIN [dbo].[User_LoginDetails] L ON L.UserId = uld.UserId
	WHERE uld.ClientId = @ClientId
END