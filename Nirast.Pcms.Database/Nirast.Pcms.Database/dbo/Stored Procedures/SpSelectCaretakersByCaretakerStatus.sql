CREATE PROC [dbo].[SpSelectCaretakersByCaretakerStatus] 
	(@CaretakerStatus INT = 0)
AS
BEGIN
		IF(@CaretakerStatus = 0)
			SET @CaretakerStatus = NULL

		SELECT CD.[UserId],
						[FirstName] AS FirstName,
						[LastName] AS LastName,
						[ProfilePic] AS ProfilePic,
						Gender AS GenderId,
						[DOB],
						HouseName,
						[Location],
						S.CountryId AS CountryId,
						CN.CountryName AS [Country],
						C.StateId AS [StateId],
						S.StateName AS [State],
						UA.CityId AS [CityId],
						C.CityName AS City,
						[ZipCode],
						[UserTypeId],
						UA.[Phone1] AS PrimaryPhoneNo,
						UA.[Phone2] AS SecondaryPhoneNo,
						UL.[EmailId] AS EmailAddress,
						[CaretakerDetailId],
						CAT.[TypeId] AS CategoryId,
						CAT.TypeName AS [CategoryName],
						[ProfileId] AS CaretakerProfileId,
						[TotalExperience],
						[KeySkills],
						[AboutMe],
						[CaretakerStatus] AS AccountStatus,
						[IsPrivate],
						UD.UserStatus,
						UD.IsVerified AS UserVerified
				  FROM Caretaker_Details CD 
					INNER JOIN [dbo].[UserDetails_Master] UD ON CD.UserId=UD.UserId
					INNER JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = UD.UserId
					LEFT JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = UD.UserId
					LEFT JOIN [dbo].[Settings_City] C ON UA.CityId = C.CityId 
					LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
					LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
					LEFT JOIN [dbo].[Settings_CaretakerType] CAT ON CAT.[TypeId]=CD.CaretakerTypeId
					WHERE CD.CaretakerStatus = ISNULL(@CaretakerStatus,CD.CaretakerStatus) 
					AND UD.UserStatus <> 3
					--AND UD.UserStatus =1
END