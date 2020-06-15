
CREATE PROCEDURE [dbo].[SpGetUpcomingNotification]
(

	@CaretakerId int
)
AS
BEGIN
			Select TOP 1 * from 
			(SELECT 
			    pcb.BookingId AS AppointmentId,
				pcb.BookingDateTime AS date,
				pcb.FromDateTime AS AppointmentDate,
				um.FirstName + ' ' + um.LastName  AS 'User',
				uad.Location,
				'1'AS Type,
				convert(varchar, pcb.FromDateTime, 8) AS AppointmentTime
			FROM
			[dbo].[PublicUser_Caretaker_Booking]pcb
				INNER JOIN	[dbo].[UserDetails_Master]um  ON 	um.UserId=pcb.PublicUserId
				INNER JOIN [dbo].[User_AddressDetails]uad ON 	uad.UserId=pcb.PublicUserId
			WHERE cast(pcb.FromDateTime as DATE) = cast (GETDATE() as DATE) 
				AND cast(pcb.FromDateTime as time) > cast (GETDATE() as time) 
				AND pcb.IsConfirmed = 'FALSE'
				AND pcb.Status = 2
				AND pcb.CaretakerUserId = @CaretakerId
			UNION
			SELECT 
			    cs.SchedulingId AS AppointmentId,
				cs.StartDateTime AS date,
				cs.StartDateTime AS AppointmentDate,
				cm.ClientName AS 'User',
				cad.Location,
				'2' AS Type,
				convert(varchar,cs.StartDateTime, 8) AS AppointmentTime
			FROM [dbo].[Client_Scheduling]cs
				INNER JOIN	[dbo].[Client_Master]cm	ON 	cm.ClientId=cs.ClientId
				INNER JOIN	[dbo].[Client_AddressDetails]cad	ON 	cad.ClientId=cs.ClientId
			WHERE cast (cs.StartDateTime as DATE)= cast (GETDATE() as DATE) 
				AND cast(cs.StartDateTime as time) > cast (GETDATE() as time)
				AND cs.IsConfirmed = 'FALSE'
				AND cs.CaretakerUserId = @CaretakerId)t
		ORDER BY t.date
END