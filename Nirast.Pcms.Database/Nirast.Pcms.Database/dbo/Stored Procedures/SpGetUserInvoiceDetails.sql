CREATE PROCEDURE [dbo].[SpGetUserInvoiceDetails]
	(@InvoiceNumber int)
AS
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
		SELECT    ucd.FirstName, 
                  ucd.LastName, 
			      ucd.HouseName as Address,
				  ucd.Location,
			      CN.CountryName AS Country,
			      S.StateName AS State,
				  upi.TaxAmount,
			      C.CityName AS City,
			      upi.InvoiceNo as InvoiceNumber,
			      upi.BookingId,
			      ucd.Phone1 as PrimaryPhoneNo,
			      upi.InvoiceDate as Date,
			      upi.Amount,
				  upi.TotalAmount,
			      upi.PayStatus AS PaidStatus,
			      ub.PublicUserId AS UserId,
			      UL.EmailId AS EmailId,
				  @Currency as Currency,
					@CurrencySymbol as CurrencySymbol,
					usr.FirstName as UserName,
					ub.BookingDateTime as BookingDate

		FROM [dbo].[PublicUser_PaymentInvoice] upi 
			INNER JOIN dbo.PublicUser_Caretaker_Booking ub ON upi.BookingId = ub.BookingId 
			INNER JOIN dbo.UserDetails_Master usr ON usr.UserId=ub.PublicUserId
			INNER JOIN dbo.PublicUser_CareRecipientDetails ucd ON ub.BookingId = ucd.BookingId
			LEFT JOIN [dbo].[Settings_City] C ON ucd.CityId = C.CityId
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId

			INNER JOIN [dbo].[User_LoginDetails] UL ON UL.UserId = usr.UserId
			INNER JOIN [dbo].[User_AddressDetails] Uad ON Uad.UserId = usr.UserId
			LEFT JOIN [dbo].[Settings_City] CU ON Uad.CityId = CU.CityId
			LEFT JOIN [dbo].[Settings_State] SU ON SU.StateId = CU.StateId
			LEFT JOIN [dbo].[Settings_Country] CNU ON CNU.CountryId = SU.CountryId
		 WHERE upi.InvoiceNo=@InvoiceNumber
END