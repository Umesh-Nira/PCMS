CREATE PROCEDURE [dbo].[SpUpdateUserProfilePic] 
	(@Id int,
	@ProfilePicPath nvarchar(MAX))
AS
 BEGIN
        UPDATE [dbo].[UserDetails_Master]
        SET 
            ProfilePicPath = @ProfilePicPath
        WHERE UserId = @Id
 END