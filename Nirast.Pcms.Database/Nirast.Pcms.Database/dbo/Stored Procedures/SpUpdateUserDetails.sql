--[SpSelectClientInvoiceDetails] null,null,null,null,null,null,1
CREATE PROCEDURE [dbo].[SpUpdateUserDetails] 
(
	@UserId int,
	@UserTypeId int,
	@FilePath nvarchar(MAX)
)
AS
BEGIN
	Update [dbo].[UserDetails_Master]
	SET [ProfilePicPath]=@FilePath,[ProfilePic]=null
	where [UserId]=@UserId and [UserTypeId]=@UserTypeId
	
END