/*
--------------------------------------------------------------------------------------
< Select Caretakers For Search >

Author				: 
Created Date		: 


Last Updated BY		: NOWFAL S R
Last Updated Date	: 20-AUGUST-2018
Updation			: Designation from designation table
-----------------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpGetOfficeStaffDetails] 
	(@UserRegnId INT = 0)
AS
BEGIN
	IF @UserRegnId = 0
	SET @UserRegnId = NULL

		SELECT U.UserId AS UserRegnId,
			       U.FirstName,
				   U.LastName,
				   U.ProfilePic,
		           Gender AS GenderId,
                   DOB,
				   UL.EmailId as EmailAddress,
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
				   R.RoleName,
				   Q.QualificationName,
				   O.QualificationId
			FROM [dbo].[OfficeStaff_Details] O
			INNER JOIN [dbo].UserDetails_Master U ON O.UserId = U.UserId
			INNER JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = U.UserId
			INNER JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = U.UserId
            LEFT JOIN [dbo].[Settings_City] C ON C.CityId = UA.CityId
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			LEFT JOIN [dbo].[Settings_Designations] D ON D.DesignationId = O.DesignationId
			LEFT JOIN [dbo].[Settings_Role] R ON R.RoleId = O.RoleId
			LEFT JOIN [dbo].[Settings_Qualifications]  Q ON Q.QualificationId=O.QualificationId
		WHERE
			U.UserStatus <> 3
			AND U.UserId = ISNULL(@UserRegnId,U.UserId)
END