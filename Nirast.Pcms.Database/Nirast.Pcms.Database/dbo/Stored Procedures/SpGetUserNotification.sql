CREATE PROCEDURE [dbo].[SpGetUserNotification] 
(
@PublicUserId int
)
AS
BEGIN
		SELECT 
			pcb.BookingId,  
			pcb.BookingDateTime, 
			pcb.FromDateTime,
			pcb.ToDateTime,
			um.FirstName + ' ' + um.LastName  AS 'Caretaker',
			pcr.Location,
			pay.InvoiceNo
		FROM
	    [dbo].[PublicUser_Caretaker_Booking]pcb
			INNER JOIN	[dbo].[UserDetails_Master]um  ON 	um.UserId=pcb.CaretakerUserId
			INNER JOIN [dbo].[PublicUser_CareRecipientDetails] pcr ON pcr.BookingId = pcb.BookingId
			LEFT JOIN [dbo].[PublicUser_PaymentInvoice]pay ON pay.BookingId = pcb.BookingId
		WHERE pcb.Status IN (1,5) AND  GETUTCDATE() < pcb.ToDateTime AND pcb.PublicUserId = @PublicUserId

END