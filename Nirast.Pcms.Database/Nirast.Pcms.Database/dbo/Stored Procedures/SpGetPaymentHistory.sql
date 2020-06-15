CREATE PROCEDURE [dbo].[SpGetPaymentHistory]
(
@PublicUserId int
)
AS
BEGIN
		SELECT    
		format(pcb.BookingDateTime,'dd/MM/yyyy') AS BookingDate,
		scs.ServiceName AS [Service],
	    (um.FirstName + ' ' + um.LastName) AS Caretaker,
		format(	ppt.TransactionDateTime,'dd/MM/yyyy')  AS PaymentDate,
		ppt.Amount AS PaymentAmount,
		CN.Symbol,
		ppt.Status AS PaymentStatus,
		pcb.Status AS BookingStatus
		FROM
	    [dbo].[PublicUser_Caretaker_Booking]pcb
		INNER JOIN	[dbo].[Settings_CaretakerServices]scs ON scs.ServiceId = pcb.ServiceId
		INNER JOIN	[dbo].[Caretaker_Details]cd   ON cd.UserId = pcb.CaretakerUserId
		INNER JOIN	[dbo].[UserDetails_Master]um   ON 	um.UserId=pcb.CaretakerUserId
		INNER JOIN [dbo].[User_AddressDetails]uad  ON 	uad.UserId=pcb.CaretakerUserId
		LEFT JOIN [dbo].[Settings_City] C ON  C.CityId = uad.CityId
		LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
		LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
		INNER JOIN	[dbo].[Settings_CaretakerType]sct ON sct.TypeId = cd.CaretakerTypeId
		INNER JOIN	[dbo].[PublicUser_PaymentInvoice]ppi ON ppi.BookingId=pcb.BookingId
		INNER JOIN	[dbo].[PublicUser_PaymentTransaction]ppt ON ppt.InvoiceNo=ppi.InvoiceNo
		
		WHERE pcb.PublicUserId = @PublicUserId
END