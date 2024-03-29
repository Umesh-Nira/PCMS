﻿CREATE PROCEDURE [dbo].[SpInsertUpdateAdminDetails]  (
	@Id int = 0,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@ProfilePicPath nvarchar(MAX) = NULL,
	@ProfilePic image = null,
	@Location nvarchar(50),
	@CityId int,
	@Housename nvarchar(50),
	@ZipCode nvarchar(10),
	@UserTypeId int,
	@PrimaryPhoneNo nvarchar(20),
	@SecondaryPhoneNo nvarchar(20),
	@EmailAddress nvarchar(50),
	@Password nvarchar(MAX),
	
	@UserStatus int,
	@UserID_OUT INT OUT)
AS
BEGIN
      --========================================================================= USER INSERTION START =============================================================
			  IF @Id = 0
			  BEGIN
				  IF EXISTS (select EmailId from User_LoginDetails where EmailId = @EmailAddress)
				  BEGIN
					SET @UserID_OUT = -1
				  END
				  ELSE
				  BEGIN
					
					INSERT INTO [dbo].[UserDetails_Master]
							(
								FirstName,
								LastName,
								ProfilePicPath,
							
								UserTypeId,
							
								UserStatus
							)
							VALUES
							  (
								@FirstName ,
								@LastName ,
								@ProfilePicPath,
							
								@UserTypeId,
							
								@UserStatus		
							  )
					SET @UserID_OUT=SCOPE_IDENTITY()				 
					INSERT INTO [dbo].[User_LoginDetails]
							(
								[EmailId],
								[Password],
								[UserId]
							)
							VALUES
							(
								@EmailAddress,
								@Password,
								@UserID_OUT
							)
					INSERT INTO [dbo].[User_AddressDetails]
							(
								[UserId],
								[HouseName],
								[Location],
								[CityId],
								[Zipcode],
								[Phone1],
								[Phone2]
							)
							VALUES
							(
								@UserID_OUT,
								@Housename,
								@Location,
								@CityId,
								@ZipCode,
								@PrimaryPhoneNo,
								@SecondaryPhoneNo
							)
					END
			  END
			  --=========================================================================USER INSERTION END===============================================================

			  --=========================================================================USER UPDATE START================================================================

			  ELSE
			  BEGIN
			   IF EXISTS (select EmailId from User_LoginDetails where EmailId = @EmailAddress and UserId <> @Id)
				  BEGIN
					SET @UserID_OUT = -1
				  END
				  ELSE
				  BEGIN
						UPDATE [UserDetails_Master]
						SET FirstName = @FirstName,
							LastName = @LastName,
							ProfilePicPath = @ProfilePicPath
							
						WHERE UserId = @Id

						UPDATE User_LoginDetails
						SET EmailId = @EmailAddress
						WHERE UserId = @Id

						UPDATE [User_AddressDetails]
						SET [HouseName] = @Housename,
							[Location] = @Location,
							[CityId] = @CityId,
							[Zipcode] = @ZipCode,
							[Phone1] = @PrimaryPhoneNo,
							[Phone2] = @SecondaryPhoneNo
						WHERE UserId = @Id

						SET @UserID_OUT = @Id
				END
			  END
      --=====================================
END


select * from UserDetails_Master

update UserDetails_Master
set ProfilePic = NULL
