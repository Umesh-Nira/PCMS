
CREATE PROCEDURE [dbo].[SpGetAllOfficeStaffDetails]
AS
BEGIN
SELECT U.UserId AS UserRegnId,
			       U.FirstName,
				   U.LastName,
				   U.ProfilePic,
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
				   CN.CountryName AS Country,
				   S.StateName AS State,
				   C.CityName AS City,
				   UA.HouseName,
				   U.UserStatus,
				   U.IsVerified AS UserVerified,
				   O.DesignationId,
				    D.DesignationName AS Designation,
				   O.RoleId,
				   R.RoleName
			FROM [dbo].[UserDetails_Master] U
			INNER JOIN [dbo].[OfficeStaff_Details] O ON O.UserId = U.UserId
			INNER JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = U.UserId
            LEFT JOIN [dbo].[Settings_City] C ON C.CityId = UA.CityId
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			LEFT JOIN [dbo].[Settings_Designations] D ON D.DesignationId = O.DesignationId
			INNER JOIN [dbo].[Settings_Role] R ON R.RoleId = O.RoleId
			AND U.UserStatus != 3
			ORDER BY FirstName

END