
CREATE PROCEDURE [dbo].[SpCheckEmailExists] (@EmailId nvarchar(100)) AS
BEGIN
		SELECT UDM.UserStatus			
		FROM [dbo].[User_LoginDetails] ULD INNER JOIN
		UserDetails_Master UDM on ULD.UserId = UDM.UserId
		WHERE EmailId = @EmailId 
 END