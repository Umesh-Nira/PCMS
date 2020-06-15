CREATE PROCEDURE [dbo].[SpGetAdminSchedulingList]

AS
BEGIN
		SELECT    
		cs.SchedulingId,
		format(cs.StartDateTime,'dd/MM/yyyy') AS BookingDate,
		 cm.ClientName AS Client,
		 udm.FirstName + '' + udm.LastName AS Caretaker,
		 ws.WorkShiftName AS WorkMode,
		 ts.TimeShiftName AS TimeShift
		
		FROM [dbo].[Client_Scheduling] cs
		INNER JOIN	[dbo].[Client_Master]cm	ON 	cm.ClientId=cs.ClientId
		INNER JOIN	[dbo].[UserDetails_Master]udm	ON 	udm.UserId=cs.CaretakerUserId
		INNER JOIN	[dbo].[Settings_WorkShift] ws	ON 	ws.WorkShiftId=cs.WorkShiftId
		INNER JOIN	[dbo].[Settings_TimeShift] ts	ON 	ts.TimeShiftId=cs.TimeShiftId
			ORDER BY  cs.StartDateTime DESC
END