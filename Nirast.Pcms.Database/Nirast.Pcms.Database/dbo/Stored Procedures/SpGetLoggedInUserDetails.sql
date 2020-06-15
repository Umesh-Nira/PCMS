CREATE PROC [dbo].[SpGetLoggedInUserDetails]
	(@UserId INT)
AS
BEGIN
	SELECT U.UserId,
		U.FirstName, 
		U.ProfilePicPath, 
		U.LastName,
		U.IsVerified,
		U.UserStatus,
		UT.UserType, 
		UL.EmailId as EmailAddress, 
		UL.Password,
		OD.RoleId,
		UA.Location
	FROM [dbo].[UserDetails_Master] U
	INNER JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = U.UserId
	INNER JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = U.UserId
	INNER JOIN [dbo].[Settings_UserTypes] UT on UT.UserTypeId = U.UserTypeId
	LEFT JOIN [dbo].[OfficeStaff_Details] od ON OD.UserId = U.UserId
	WHERE U.UserId = @UserId 
	AND U.IsVerified = 'True'
	AND U.UserStatus = 1
END