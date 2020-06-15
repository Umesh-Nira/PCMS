CREATE PROCEDURE [dbo].spGetAllUserDetails
AS
BEGIN
	
			SELECT [UserId] as UserRegnId,[ProfilePic] as ProfilePicByte,ut.[UserTypeId] as UserTypeId,ut.[UserType] as UserTypeName
			FROM [dbo].[UserDetails_Master]um
			INNER JOIN [dbo].[Settings_UserTypes]ut on ut.[UserTypeId]=um.UserTypeId
END