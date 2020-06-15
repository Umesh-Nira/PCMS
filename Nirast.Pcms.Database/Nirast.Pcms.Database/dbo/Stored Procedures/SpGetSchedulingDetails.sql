CREATE PROCEDURE [dbo].[SpGetSchedulingDetails]--2
(
@CaretakerId int
)
AS
BEGIN
		SELECT    
		format(cs.StartDateTime,'dd/MM/yyyy') as BookingDate,
		 cm.ClientName,
		 ws.WorkShiftName AS 'WorkMode',
		 ts.TimeShiftName AS 'TimeShift',
		 isnull(cs.Description,'') as Description
		
		FROM [dbo].[Client_Scheduling] cs
		INNER JOIN	[dbo].[Client_Master]cm	ON 	cm.ClientId=cs.ClientId
		INNER JOIN	[dbo].[Settings_WorkShift] ws	ON 	ws.WorkShiftId=cs.WorkShiftId
		INNER JOIN	[dbo].[Settings_TimeShift] ts	ON 	ts.TimeShiftId=cs.TimeShiftId
		WHERE cs.CaretakerUserId=@CaretakerId

END