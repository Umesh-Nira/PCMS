
CREATE PROCEDURE [dbo].[SpGetAdminNotification] 
AS
BEGIN
		SELECT 
			pcb.BookingId,   
			ld.EmailId,
			pcb.BookingDateTime,
			um.FirstName + ' ' + um.LastName  AS BookedUser,
			uad.Location,
			udm.FirstName + ' ' + udm.LastName as Caretaker,
			ud.Location as CaretakerLocation,
			pcd.Purpose,
			pcb.FromDateTime,
			pcb.ToDateTime
		FROM
	    [dbo].[PublicUser_Caretaker_Booking]pcb
			INNER JOIN	[dbo].[UserDetails_Master]um   ON 	um.UserId=pcb.PublicUserId
			INNER JOIN	[dbo].[UserDetails_Master]udm  ON 	udm.UserId=pcb.CaretakerUserId
			INNER JOIN	[dbo].[User_LoginDetails]ld  ON 	ld.UserId=pcb.PublicUserId
			LEFT JOIN [dbo].[User_AddressDetails]uad  ON 	uad.UserId=pcb.PublicUserId
			LEFT JOIN [dbo].[User_AddressDetails]ud   ON 	ud.UserId=pcb.CaretakerUserId
			left join [dbo].[PublicUser_CareRecipientDetails] pcd on pcd.BookingId=pcb.BookingId
 		WHERE pcb.BookingId NOT IN(SELECT BookingId from [dbo].[PublicUser_PaymentInvoice])
		and pcb.Status <> 4 and  pcb.Status <> 3
		ORDER BY  pcb.BookingDateTime DESC
END