CREATE PROCEDURE [dbo].[SpGetUserBookingDetails] --122
	(
	@PublicUserId int
	)
	AS
BEGIN
			SELECT 
			pcb.BookingId,  
			pcb.BookingDateTime AS BookingDate,
			um.FirstName + ' ' + um.LastName  AS BookedUser,
			scs.ServiceName AS Service,
			uad.Location,			
			pcb.FromDateTime AS FromDateTime,
			pcb.ToDateTime AS ToDateTime,
			cast(pcb.FromDateTime as date) AS Start,
			cast(pcb.ToDateTime as date) AS EndDate ,
			ppi.InvoicePath AS InvoicePath,
			ppi.InvoiceNo AS InvoiceNo
			FROM
			[dbo].[PublicUser_Caretaker_Booking]pcb
			INNER JOIN	[dbo].[UserDetails_Master]um			ON 	um.UserId=pcb.CaretakerUserId
			INNER JOIN [dbo].[Settings_CaretakerServices]scs	ON 	scs.ServiceId=pcb.ServiceId
			INNER JOIN [dbo].[User_AddressDetails]uad			ON 	uad.UserId=pcb.PublicUserId
			LEFT JOIN [dbo].[PublicUser_PaymentInvoice] ppi    ON 	ppi.BookingId = pcb.BookingId
			WHERE pcb.PublicUserId = @PublicUserId
	END



--	[SpGetUserBookingDetails] 122
