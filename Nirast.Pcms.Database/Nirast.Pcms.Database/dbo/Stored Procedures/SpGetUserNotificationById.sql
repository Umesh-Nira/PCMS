
CREATE PROCEDURE [dbo].[SpGetUserNotificationById] 
(
@BookingId int
)
AS
BEGIN
		SELECT    
		convert(varchar, pcb.BookingDateTime, 6) AS 'BookingDate',
		um.FirstName + ' ' + um.LastName  AS 'Caretaker',
		CR.FirstName + ' ' + CR.LastName AS 'CareRecipient',
	    CR.Location,
		CR.HouseName,
		CR.Phone1,
		pcb.FromDateTime,
		pcb.ToDateTime,
		scs.ServiceName AS 'Service',
		PBQ.Answer1,
		PBQ.Answer2,
		PBQ.Answer3,
		PBQ.Answer4,
		PBQ.Answer5,
		PBQ.Answer6,
		pcb.Status

		FROM
	    [dbo].[PublicUser_Caretaker_Booking]pcb
		INNER JOIN	[dbo].[UserDetails_Master]um  ON 	um.UserId=pcb.CaretakerUserId
		INNER JOIN [dbo].[User_AddressDetails]uad ON 	uad.UserId=pcb.CaretakerUserId
		INNER JOIN [dbo].[Settings_CaretakerServices]scs ON 	scs.ServiceId=pcb.ServiceId
		INNER JOIN [dbo].[PublicUser_CareRecipientDetails] CR ON CR.BookingId = pcb.BookingId
		INNER JOIN [dbo].[PublicUser_Booking_Questionnaire] PBQ ON PBQ.BookingId = CR.BookingId
		WHERE pcb.BookingId = @BookingId
END
