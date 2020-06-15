/*
--------------------------------------------------------------------------------------
< Select Caretakers For Search >

Author				: Sethu
Created Date		: 

Last Updated BY		: NOWFAL S R
Last Updated Date	: 06-AUGUST-2018
Updation			: Fetching data respect to email and login name
-----------------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpSelectAllUserDetails]
(
	@Flag varchar(50),
	@Value varchar(50)
)
AS
BEGIN

	IF @Flag='*'
		BEGIN
			SELECT U.UserId AS UserRegnId,
			       U.FirstName,
				   U.LastName,
				   U.ProfilePicPath,
		           Gender AS GenderId,
                   DOB ,
                   Location,
                   UA.CityId,
                   S.StateId ,
                   CN.CountryId,
                   UA.Zipcode,
                   U.UserTypeId,
                   UA.Phone1 AS PrimaryPhoneNo,
                   UA.Phone2 AS SecondaryPhoneNo,
                   UL.EmailId as EmailAddress,
                   UL.Password,
				   CN.CountryName AS Country,
				   S.StateName AS State,
				   C.CityName AS City,
				   UA.HouseName,
				   U.UserStatus,
				   U.IsVerified AS UserVerified
			FROM [dbo].[UserDetails_Master] U
			INNER JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = U.UserId
            LEFT JOIN [dbo].[Settings_City] C ON C.CityId = UA.CityId
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			INNER JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = U.UserId
			WHERE U.UserStatus != 3
			ORDER BY FirstName 
		END

	ELSE IF @Flag='UserRegnId'
		BEGIN
			SELECT U.UserId AS UserRegnId,
			       U.FirstName,
				   U.LastName,
				   U.ProfilePicPath,
		           Gender AS GenderId,
                   DOB ,
                   Location,
                   UA.CityId,
                   S.StateId ,
                   CN.CountryId,
                   UA.Zipcode,
                   U.UserTypeId,
                   UA.Phone1 AS PrimaryPhoneNo,
                   UA.Phone2 AS SecondaryPhoneNo,
                   UL.EmailId as EmailAddress,
                   UL.Password,
				   CN.CountryName AS Country,
				   S.StateName AS State,
				   C.CityName AS City,
				   UA.HouseName,
				   U.UserStatus,
				   U.IsVerified AS UserVerified
			FROM [dbo].[UserDetails_Master] U
			INNER JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = U.UserId
            LEFT JOIN [dbo].[Settings_City] C ON C.CityId = UA.CityId
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			INNER JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = U.UserId
			WHERE U.UserId = @Value
			AND U.UserStatus != 3
			ORDER BY FirstName
		END

	ELSE IF @Flag='FirstName'
		BEGIN
			SELECT U.UserId AS UserRegnId,
			       U.FirstName,
				   U.LastName,
				   U.ProfilePicPath,
		           Gender AS GenderId,
                   DOB ,
                   Location,
                   UA.CityId,
                   S.StateId ,
                   CN.CountryId,
                   UA.Zipcode,
                   U.UserTypeId,
                   UA.Phone1 AS PrimaryPhoneNo,
                   UA.Phone2 AS SecondaryPhoneNo,
                   UL.EmailId as EmailAddress,
                   UL.Password,
				   CN.CountryName AS Country,
				   S.StateName AS State,
				   C.CityName AS City,
				   UA.HouseName,
				   U.UserStatus,
				   U.IsVerified AS UserVerified
			FROM [dbo].[UserDetails_Master] U
			INNER JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = U.UserId
            LEFT JOIN [dbo].[Settings_City] C ON C.CityId = UA.CityId
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			INNER JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = U.UserId
			WHERE U.FirstName like '%'+@Value+'%'
			 AND U.UserStatus != 3
			ORDER BY FirstName
		END

	ELSE IF @Flag='Email'
		BEGIN
			SELECT U.UserId AS UserRegnId,
			       U.FirstName,
				   U.LastName,
				   U.ProfilePicPath,
		           Gender AS GenderId,
                   DOB ,
                   Location,
                   UA.CityId,
                   S.StateId ,
                   CN.CountryId,
                   UA.Zipcode,
                   U.UserTypeId,
                   UA.Phone1 AS PrimaryPhoneNo,
                   UA.Phone2 AS SecondaryPhoneNo,
                   UL.EmailId as EmailAddress,
                   UL.Password,
				   CN.CountryName AS Country,
				   S.StateName AS State,
				   C.CityName AS City,
				   UA.HouseName,
				   U.UserStatus,
				   U.IsVerified AS UserVerified
			FROM [dbo].[UserDetails_Master] U
			INNER JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = U.UserId
            LEFT JOIN [dbo].[Settings_City] C ON C.CityId = UA.CityId
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			INNER JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = U.UserId
			WHERE UL.EmailId=@Value
			AND U.UserStatus != 3
			ORDER BY U.FirstName
		END

	ELSE IF @Flag='UserType'
	BEGIN
			SELECT U.UserId AS UserRegnId,
			       U.FirstName,
				   U.LastName,
				   U.ProfilePicPath,
		           Gender AS GenderId,
                   DOB ,
                   Location,
                   UA.CityId,
                   S.StateId ,
                   CN.CountryId,
                   UA.Zipcode,
                   U.UserTypeId,
                   UA.Phone1 AS PrimaryPhoneNo,
                   UA.Phone2 AS SecondaryPhoneNo,
                   UL.EmailId as EmailAddress,
                   UL.Password,
				   CN.CountryName AS Country,
				   S.StateName AS State,
				   C.CityName AS City,
				   UA.HouseName,
				   U.UserStatus,
				   U.IsVerified AS UserVerified
			FROM [dbo].[UserDetails_Master] U
			INNER JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = U.UserId
            LEFT JOIN [dbo].[Settings_City] C ON C.CityId = UA.CityId
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			LEFT JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = U.UserId
			WHERE [UserTypeId] = @Value
			AND U.UserStatus != 3
			ORDER BY FirstName
		END
END