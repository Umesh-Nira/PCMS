CREATE PROCEDURE [dbo].[SpGetSchedulingDetailsById]
(
@SchedulingId int
)
AS
BEGIN
		SELECT    
		format(cs.StartDateTime,'dd/MM/yyyy') AS BookingDate,
		 cm.ClientName AS Client,
		 udm.FirstName + '' + udm.LastName AS Caretaker,
		 cs.StartDateTime AS StartDate,
		 cs.EndDateTime AS EndDate,
		 ws.WorkShiftName AS WorkMode,
		 ts.TimeShiftName AS TimeShift
		
		FROM [dbo].[Client_Scheduling] cs
		INNER JOIN	[dbo].[Client_Master]cm	ON 	cm.ClientId = cs.ClientId
		INNER JOIN	[dbo].[Settings_WorkShift] ws	ON 	ws.WorkShiftId = cs.WorkShiftId
		INNER JOIN	[dbo].[Settings_TimeShift] ts	ON 	ts.TimeShiftId = cs.TimeShiftId
		INNER JOIN  [dbo].[UserDetails_Master] udm ON udm.UserId = cs.CaretakerUserId
		
		WHERE cs.SchedulingId=@SchedulingId

END