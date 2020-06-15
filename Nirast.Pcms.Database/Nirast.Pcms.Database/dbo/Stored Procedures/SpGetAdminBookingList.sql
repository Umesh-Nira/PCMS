CREATE PROCEDURE [dbo].[SpGetAdminBookingList] 

AS
BEGIN
		SELECT 
		pcb.BookingId,   
	    pcb.BookingDateTime AS BookingDate,
		um.FirstName + ' ' + um.LastName  AS BookedUser,
	    uad.Location as UserLocation,
		udm.FirstName + ' ' + udm.LastName as Caretaker,
		ud.Location as CaretakerLocation
	
		FROM
	    [dbo].[PublicUser_Caretaker_Booking]pcb
		INNER JOIN	[dbo].[UserDetails_Master]um   ON 	um.UserId=pcb.PublicUserId
		INNER JOIN	[dbo].[UserDetails_Master]udm  ON 	udm.UserId=pcb.CaretakerUserId
		LEFT JOIN [dbo].[User_AddressDetails]uad  ON 	uad.UserId=pcb.PublicUserId
		LEFT JOIN [dbo].[User_AddressDetails]ud   ON 	ud.UserId=pcb.CaretakerUserId

		WHERE  GETUTCDATE() < pcb.ToDateTime
			 AND pcb.Status =2
		
		ORDER BY  pcb.BookingDateTime DESC
END