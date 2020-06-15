/*
-----------------------------------------------------------------------------------
< Save Caretaker Multiple Details >

Author				: NOWFAL S R
Created Date		: 02-JULY-2018

Last Updated BY		: NOWFAL S R
Last Updated Date	: 09-JULY-2018
Updation			: Passed @CaretakerUserId for deleting old details

Last Updated BY		: NOWFAL S R
Last Updated Date	: 17-JULY-2018
Updation			: New parameter @CaretakerDocuments for saving multiple caretaker documents

Last Updated BY		: NOWFAL S R
Last Updated Date	: 01-AUGUST-2018
Updation			: Upload caretaker documents while registration only.
-----------------------------------------------------------------------------------
Drop PROCEDURE [dbo].[spSaveCaretakerMultipleDetails]
*/
CREATE PROCEDURE [dbo].[spSaveCaretakerMultipleDetails]
(
	@CaretakerUserId INT,
	@CaretakerExperience AS [dbo].[CaretakerExperienceDataType] Readonly,
	@CaretakerQualifications AS [dbo].[CaretakerQualificationDataType] Readonly,
	@CaretakerServices AS [dbo].[CaretakerPayRiseRates] Readonly,
	@CaretakerDocuments AS [dbo].[CaretakerDocumentDataType] Readonly,
	@CaretakerQualificationOthers AS [dbo].[CaretakerQualificationOthersDataType] Readonly,
	@Payrisedate Datetime
)
AS
BEGIN

	DELETE FROM [dbo].[Caretaker_Experience] WHERE UserId=@CaretakerUserId
	DELETE FROM [dbo].[Caretaker_Qualification] WHERE UserId=@CaretakerUserId
	DELETE FROM [dbo].[Caretaker_PublicUser_Service] WHERE UserId=@CaretakerUserId
	--DELETE FROM CaretakerDocuments WHERE CareTakerUserId=@CaretakerUserId
	DELETE FROM [dbo].[Caretaker_Qualifications_Others] WHERE UserId=@CaretakerUserId
	
	INSERT INTO [Caretaker_Experience]
											(
												UserId,
												FromDate,
												ToDate,
												CompanyName
											)
											SELECT CareTakerUserId,
													DateFrom, 
													DateTo,
													Company
											 FROM @CaretakerExperience

		INSERT INTO [Caretaker_Qualification]
											(
												UserId,
												QualificationId
											)
											SELECT CareTakerUserId,
													QualificationId
											 FROM @CaretakerQualifications
											 WHERE [QualificationId] <>999

       INSERT INTO [Caretaker_Qualifications_Others]
											(
												UserId,
												QualificationName
									
											)
											SELECT CareTakerUserId,
													QualificationName
											 FROM @CaretakerQualificationOthers
											 WHERE [QualificationId] =999
											 END
											 BEGIN

	DECLARE @PayriseId_OUT int
	DECLARE @payriseId int

	select @payriseId=PayriseId from [dbo].[Caretaker_Booking_Payrise] where Payrisedate=@Payrisedate AND CaretakerId=@CaretakerUserId 
	IF (@payriseId>0)
	BEGIN
	DELETE FROM [Caretaker_Booking_Rates] where BookingPayRiseId=@payriseId

	INSERT INTO [Caretaker_Booking_Rates]
				(
				[CaretakerId],
				[PayingRate],
				[DisplayRate],
				[ServiceId],	
				[BookingPayRiseId]
				)
				SELECT  
						@CaretakerUserId,
						PayingRate,
						DisplayRate,
						ServiceId,
						@payriseId
				FROM @CaretakerServices
				END
	
				ELSE
		BEGIN
		INSERT INTO [dbo].[Caretaker_Booking_Payrise]
		([Payrisedate],
		 [CaretakerId]
		)
	values (@Payrisedate,@CaretakerUserId )
	SET @PayriseId_OUT=SCOPE_IDENTITY()
	
	
	 
	 INSERT INTO [Caretaker_Booking_Rates]
				(
				[CaretakerId],
				[PayingRate],
				[DisplayRate],
				[ServiceId],	
				[BookingPayRiseId]
				)
				SELECT  
						@CaretakerUserId,
						PayingRate,
						DisplayRate,
						ServiceId,
						@PayriseId_OUT
				FROM @CaretakerServices

				
	END

			INSERT INTO Caretaker_Documents(
											DocumentType,
											DocumentName,
											ContentType,
											DocumentContent,
											DocumentPath,
											UserId
										)
										SELECT DocumentTypeId,
											DocumentName,
											ContentType,
											DocumentContent,
											DocumentPath,
											CareTakerUserId
											
										FROM @CaretakerDocuments
		
END