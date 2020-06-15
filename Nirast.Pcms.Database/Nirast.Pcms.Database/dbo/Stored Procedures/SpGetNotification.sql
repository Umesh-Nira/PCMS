
CREATE PROCEDURE [dbo].[SpGetNotification] 
(
@CaretakerId int
)
AS
BEGIN
		SELECT 
		pcb.BookingId,   
		pcb.FromDateTime,
		pcb.BookingDateTime as BookingDate,
		um.FirstName + ' ' + um.LastName  AS 'BookedUser',
	    uad.Location
		FROM
	    [dbo].[PublicUser_Caretaker_Booking]pcb
		INNER JOIN	[dbo].[UserDetails_Master]um  ON 	um.UserId=pcb.PublicUserId
		INNER JOIN [dbo].[User_AddressDetails]uad ON 	uad.UserId=pcb.PublicUserId
		WHERE pcb.Status = 1 AND pcb.CaretakerUserId = @CaretakerId

END