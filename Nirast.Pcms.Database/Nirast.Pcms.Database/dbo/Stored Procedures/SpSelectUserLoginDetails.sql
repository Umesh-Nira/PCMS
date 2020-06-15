
CREATE PROCEDURE [dbo].[SpSelectUserLoginDetails]
(
@userid int
)

AS
BEGIN
	select EmailId as EmailAddress,Password from User_LoginDetails where UserId=@userid
END