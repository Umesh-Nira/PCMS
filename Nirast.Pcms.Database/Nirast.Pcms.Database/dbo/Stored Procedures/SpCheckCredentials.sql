CREATE PROC SpCheckCredentials
	(@EmailId NVARCHAR(50)) 
AS
BEGIN
	SELECT UL.UserId,
			UL.Password,
			UDA.UserStatus,
			UDA.IsVerified
	FROM [dbo].[User_LoginDetails] UL
	INNER JOIN [dbo].[UserDetails_Master] UDA ON UDA.UserId = UL.UserId
	WHERE UL.EmailId = @EmailId
END