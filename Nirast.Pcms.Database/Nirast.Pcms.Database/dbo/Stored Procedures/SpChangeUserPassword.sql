CREATE PROC SpChangeUserPassword
(
	@EmailId NVARCHAR(100),
	@Password NVARCHAR(MAX)
) AS 
BEGIN
	UPDATE User_LoginDetails
	SET Password = @Password
	WHERE EmailId = @EmailId
END