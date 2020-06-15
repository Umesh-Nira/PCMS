CREATE PROCEDURE [dbo].[SpGetCaretakerBookingDetails] --72,'01-MAY-2019','04-MAY-2019'
	(
	@CaretakerId int,
	@StartDate datetime,
	@EndDate datetime
	)
	AS
BEGIN
			SELECT 
			pcb.BookingId,  
			pcb.BookingDateTime AS BookingDate,
			um.FirstName + ' ' + um.LastName  AS BookedUser,
			scs.ServiceName AS Service,
			uad.Location,			
			pcb.FromDateTime,
			pcb.ToDateTime,
			crd.[FirstName]+' '+crd.[LastName] AS CareRecipient,
			cast(pcb.FromDateTime as date) AS Start,
			cast(pcb.ToDateTime as date) AS EndDate
			FROM
			[dbo].[PublicUser_Caretaker_Booking]pcb
			INNER JOIN	[dbo].[UserDetails_Master]um	     ON 	um.UserId=pcb.PublicUserId
			INNER JOIN  [dbo].[PublicUser_CareRecipientDetails]crd ON crd.[BookingId]=pcb.BookingId
			INNER JOIN [dbo].[Settings_CaretakerServices]scs ON 	scs.ServiceId=pcb.ServiceId
			INNER JOIN [dbo].[User_AddressDetails]uad        ON 	uad.UserId=pcb.PublicUserId
			WHERE pcb.CaretakerUserId = @CaretakerId and (pcb.FromDateTime between @StartDate and @EndDate) and (pcb.ToDateTime between @StartDate and @EndDate)
	END