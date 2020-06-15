/*
-----------------------------------------------------------------------------------
< Retrieve Caretaker Details >

Author				: NOWFAL S R
Created Date		: 04-JULY-2018

Last Updated BY		: NOWFAL S R
Last Updated Date	: 04-JULY-2018
Updation			: Added caretakerDocumentDetails selection

Last Updated BY		: NOWFAL S R
Last Updated Date	: 01-AUGUST-2018
Updation			: retrieve Category, service, qualification, designation, orientation etc from corresponding tables instead of retrieving from MultiPurposeDetails table 

Last Updated BY		: 
Last Updated Date	: 
Updation			: 
-----------------------------------------------------------------------------------
*/
--SpSelectCountryDetails 0
CREATE PROCEDURE [dbo].[SpSelectCaretakerDetails](@CaretakerUserId INT = 0) AS
BEGIN

DECLARE @Currency VARCHAR(100)
	DECLARE @CurrencySymbol VARCHAR(10)

	IF EXISTS (SELECT 1 from [Settings_Country] WHERE IsDefault = 1)
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where IsDefault = 1
	END
	ELSE
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where [CountryId] = 1
	END


IF @CaretakerUserId = 0
		 BEGIN
				SELECT CD.[UserId],
						[FirstName] AS FirstName,
						[LastName] AS LastName,
						[ProfilePicPath] AS ProfilePicPath,
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
						UL.[Password],
						[CaretakerDetailId],
						CAT.[TypeId] AS CategoryId,
						CAT.TypeName AS [CategoryName],
						[ProfileId] AS CaretakerProfileId,
						[TotalExperience],
						[KeySkills],
						[AboutMe],
						[CaretakerStatus] AS AccountStatus,
						[IsPrivate],
						CD.ConsentForm,
						CD.SSID,
						CD.ConsentDocPath,
						@Currency as Currency,
						@CurrencySymbol as CurrencySymbol

				  FROM Caretaker_Details CD 
					INNER JOIN [dbo].[UserDetails_Master] UD ON CD.UserId=UD.UserId
					INNER JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = UD.UserId
					LEFT JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = UD.UserId
					LEFT JOIN [dbo].[Settings_City] C ON UA.CityId = C.CityId 
					LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
					LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
					LEFT JOIN [dbo].[Settings_CaretakerType] CAT ON CAT.[TypeId]=CD.CaretakerTypeId
		 END
		ELSE
		 BEGIN
				SELECT CD.[UserId],
						[FirstName] AS FirstName,
						[LastName] AS LastName,
						[ProfilePicPath] AS ProfilePicPath,
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
						UL.[Password],
						[CaretakerDetailId],
						CAT.[TypeId] AS CategoryId,
						CAT.TypeName AS [CategoryName],
						[ProfileId] AS CaretakerProfileId,
						[TotalExperience],
						[KeySkills],
						[AboutMe],
						[CaretakerStatus] AS AccountStatus,
						[IsPrivate],
						CD.ConsentForm,
						CD.SSID,
						CD.ConsentDocPath,
						@Currency as Currency,
						@CurrencySymbol as CurrencySymbol
				  FROM Caretaker_Details CD 
					INNER JOIN [dbo].[UserDetails_Master] UD ON CD.UserId=UD.UserId
					INNER JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = UD.UserId
					LEFT JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = UD.UserId
					LEFT JOIN [dbo].[Settings_City] C ON UA.CityId = C.CityId 
					LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
					LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
					LEFT JOIN [dbo].[Settings_CaretakerType] CAT ON CAT.[TypeId]=CD.CaretakerTypeId
				  WHERE CD.UserId = @CaretakerUserId

					--****************************[Caretaker_Experience]**********************************************************
					SELECT 
						  FromDate AS DateFrom,
						  ToDate AS DateTo,
						  CompanyName AS [Company]
					FROM [dbo].[Caretaker_Experience] CE
					WHERE CE.UserId = @CaretakerUserId

					--****************************[Caretaker_Qualification]******************************************************
				   SELECT [CaretakerQualificationId],
						   [UserId],
						   CQ.[QualificationId],
						   QL.QualificationName AS [QualificationName]
					FROM [dbo].[Caretaker_Qualification] CQ 
						INNER JOIN [dbo].[Settings_Qualifications] QL ON QL.[QualificationId] = CQ.QualificationId
					WHERE CQ.UserId = @CaretakerUserId 
					UNION 
					SELECT [OtherQualificationId] AS CareTakerQualificationId,
						   [UserId],
						   999 AS QualificationId,
						   QO.QualificationName AS [QualificationName]
					FROM [dbo].[Caretaker_Qualifications_Others] QO
					WHERE UserId=@CaretakerUserId 

					--****************************[Caretaker_PublicUser_Service]*************************************************
			DECLARE @payRiseId int
			DECLARE @payRiseDate datetime
			DECLARE @maxDate datetime

			SELECT  @maxDate=MAX([Payrisedate]) FROM [Caretaker_Booking_Payrise] WHERE Payrisedate<=(SELECT GETDATE()) AND  [CaretakerId] =@CaretakerUserId	
			IF @maxDate IS NULL
			begin
			SELECT TOP 1 @payRiseId=[PayriseId],@payRiseDate = [Payrisedate] FROM [Caretaker_Booking_Payrise] WHERE Payrisedate IS NULL  AND  [CaretakerId] =@CaretakerUserId	
			END
			ELSE
			begin
			SELECT top 1 @payRiseId=[PayriseId],@payRiseDate = [Payrisedate] FROM [Caretaker_Booking_Payrise] WHERE Payrisedate = @maxDate  AND  [CaretakerId] =@CaretakerUserId			
			END

			SELECT
			r.BookingRateId AS PayRiseId,
			Isnull([PayingRate],0) AS PayingRate,
			Isnull([DisplayRate],0) AS DisplayRate,
			s.ServiceId,
			s.ServiceName,
			CaretakerId=@CaretakerUserId,
			EffectiveFROM=@payRiseDate
			FROM [dbo].Settings_CaretakerServices s
			INNER JOIN [dbo].[Caretaker_Booking_Rates]r on s.ServiceId = r.ServiceId AND CaretakerId =@CaretakerUserId		AND BookingPayRiseId = @payRiseId where PayingRate!=0 and DisplayRate!=0
	

					--****************************[Caretaker_Documents]*********************************************************
					SELECT DocumentId as CaretakerDocumentId,
							DocumentType as DocumentTypeId,
							DocumentName,
							ContentType,
							DocumentContent,
							UserId,
							[IsSendThroughFax],
							[DocumentPath]
					FROM  [dbo].[Caretaker_Documents]
					WHERE UserId=@CaretakerUserId

		 END
END