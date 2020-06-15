CREATE PROC SpSelectCurrPassword(@EmailId NVARCHAR(50))AS
BEGIN
	SELECT (FirstName + ' ' + LastName) As LoginName, Password FROM User_LoginDetails ld
	INNER JOIN UserDetails_Master um on ld.UserId = um.UserId WHERE EmailId = @EmailId
END