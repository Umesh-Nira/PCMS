CREATE PROCEDURE [dbo].[SpGetBookingDetailsById]
(
@BookingId int
)
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



		SELECT    
		format(pcb.BookingDateTime,'dd/MM/yyyy') AS BookingDate,
		um.FirstName + ' ' + um.LastName  AS BookedUser,
		udm.FirstName + ' ' +udm.LastName AS Caretaker,
	    uad.Location,
		pcb.FromDateTime,
		pcb.ToDateTime,
		scs.ServiceName AS Service,
		pcb.Status,
		@Currency as Currency,
		@CurrencySymbol as CurrencySymbol,
		ppi.TotalAmount AS Amount
		FROM
	    [dbo].[PublicUser_Caretaker_Booking]pcb
			INNER JOIN	[dbo].[UserDetails_Master]um         ON 	um.UserId=pcb.PublicUserId
			INNER JOIN [dbo].[User_AddressDetails]uad        ON 	uad.UserId=pcb.PublicUserId
			LEFT JOIN [dbo].[Settings_City] C ON  C.CityId = uad.CityId
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			INNER JOIN [dbo].[Settings_CaretakerServices]scs ON 	scs.ServiceId=pcb.ServiceId
			INNER JOIN [dbo].[UserDetails_Master]udm         ON 	udm.UserId=pcb.CaretakerUserId
			LEFT JOIN [dbo].[PublicUser_PaymentInvoice]ppi   ON 	ppi.BookingId=pcb.BookingId
		WHERE pcb.BookingId = @BookingId

END