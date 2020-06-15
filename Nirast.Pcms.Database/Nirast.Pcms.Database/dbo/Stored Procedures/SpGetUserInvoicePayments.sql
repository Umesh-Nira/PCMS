CREATE PROCEDURE [dbo].[SpGetUserInvoicePayments]
	(@UserId int)	
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


	SELECT upi.Amount,
			upi.InvoiceDate as Date,
			upi.InvoiceNo as InvoiceNumber,
			upi.PayStatus as PaidStatus,
			upi.TaxAmount,
			upi.TotalAmount
	FROM [dbo].[PublicUser_PaymentInvoice] upi
		INNER JOIN [dbo].[PublicUser_Caretaker_Booking] ucb ON ucb.BookingId = upi.BookingId
	WHERE ucb.PublicUserId = @UserId

	 SELECT upt.Description,
			upt.Method,
			upt.TransactionDateTime as Date,
			upt.InvoiceNo as InvoiceNumber,
			upt.Status,
			upt.TransactionId,
			upt.TransactionNo as TransactionNumber,
			upt.Amount,
			@Currency as Currency,
			@CurrencySymbol as CurrencySymbol,
			upt.Message
	 FROM   [dbo].PublicUser_PaymentTransaction upt
	 INNER JOIN  [dbo].[PublicUser_PaymentInvoice] upi ON upi.InvoiceNo = upt.InvoiceNo
	 INNER JOIN [dbo].[PublicUser_Caretaker_Booking] ucb ON ucb.BookingId = upi.BookingId
	 INNER JOIN [dbo].[UserDetails_Master] U ON U.UserId = ucb.PublicUserId
	 LEFT JOIN [dbo].[User_AddressDetails] UA ON UA.UserId = U.UserId
	 LEFT JOIN [dbo].[Settings_City] C ON UA.CityId = C.CityId 
	 LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
	 LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
	  WHERE ucb.PublicUserId = @UserId 
	  AND upt.Status = 'true'
END