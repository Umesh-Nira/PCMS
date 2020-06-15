CREATE PROC [dbo].[SpGetAppointmentDetails] 
	(
	@Id INT,
	@Type INT
	) 
AS
BEGIN

if @Type = 1
BEGIN
    SELECT       
				convert(varchar, pcb.BookingDateTime, 6) AS AppointmentDate,
				convert(varchar, pcb.BookingDateTime, 8) AS AppointmentTime,
					udm.FirstName + ' ' + udm.LastName  AS CareTaker,
					um.FirstName + ' ' + um.LastName  AS [User],
					(SELECT TOP 1 EmailId as EmailAddress 
						FROM [dbo].[User_LoginDetails] uld
						inner join [dbo].[UserDetails_Master] udm on udm.UserId=uld.UserId
						WHERE udm.UserTypeId = 4)AS AdminEmail
	FROM
			[dbo].[PublicUser_Caretaker_Booking]pcb
				INNER JOIN [dbo].[UserDetails_Master]udm ON udm.UserId=pcb.CaretakerUserId
				INNER JOIN [dbo].[UserDetails_Master]um ON um.UserId=pcb.PublicUserId
			WHERE pcb.[BookingId] = @Id
	END
	ELSE IF @Type = 2
	BEGIN
    SELECT       
				convert(varchar, cs.StartDateTime, 6) AS AppointmentDate,
				convert(varchar, cs.StartDateTime, 8) AS AppointmentTime,
					udm.FirstName + ' ' + udm.LastName  AS 'CareTaker',
					cm.ClientName  AS 'User',
					(SELECT TOP 1 EmailId as EmailAddress 
						FROM [dbo].[User_LoginDetails] uld
						inner join [dbo].[UserDetails_Master] udm on udm.UserId=uld.UserId
						WHERE udm.UserTypeId = 4)AS AdminEmail
	FROM [dbo].[Client_Scheduling]cs
			
				INNER JOIN [dbo].[UserDetails_Master]udm ON udm.UserId=cs.CaretakerUserId
				INNER JOIN	[dbo].[Client_Master]cm	ON 	cm.ClientId=cs.ClientId
			WHERE cs.SchedulingId = @Id
	END
  END