
CREATE PROCEDURE [dbo].[SpGetAdminProfile] 
	(@UserRegnId INT = 0)
AS
BEGIN
	IF @UserRegnId = 0
	SET @UserRegnId = NULL

		SELECT U.UserId AS UserRegnId,
			       U.FirstName,
				   U.LastName,
				   U.ProfilePicPath,
		           Gender AS GenderId,
                   DOB,
				   UL.EmailId as EmailAddress,
                   UA.Location,
				   UA.HouseName,
				   UA.Phone1 AS PrimaryPhoneNo,
				   UA.Phone2 AS SecondaryPhoneNo,
				   UA.Phone2,
				   UA.Zipcode,
                   UA.CityId,
                   S.StateId ,
                   CN.CountryId,
				   CN.CountryName AS Country,
				   S.StateName AS State,
				   C.CityName AS City
			FROM [dbo].UserDetails_Master U
			
			INNER JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = U.UserId
			INNER JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = U.UserId
            LEFT JOIN [dbo].[Settings_City] C ON C.CityId = UA.CityId
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			where U.UserId = @UserRegnId
	
END