CREATE PROCEDURE [dbo].[SpSelectScheduleDetails] --12,null,null


	(@ScheduleId INT = 0,
	@StartDate datetime,
	@EndDate datetime) 
AS
BEGIN

		IF(@ScheduleId = 0)
			SET @ScheduleId = NULL
		
		SELECT 
				CS.SchedulingId as Id,
				CS.ClientId,
				CL.ClientName,
				ctd.CaretakerTypeId as CaretakerType,
				CS.WorkShiftId as workmode,
				ISNULL(CS.TimeShiftId,0) as worktime,

				cast(CS.StartDateTime as date) AS Start,
				cast(CS.EndDateTime as date) AS 'End',

				FORMAT(CS.StartDateTime,'hh:mm tt')AS FromTime,
				FORMAT(CS.EndDateTime,'hh:mm tt')AS EndTime,
				
				isnull(CS.Description,'') as Description,
				CS.CaretakerUserId as CareTaker,
				UD.FirstName + ' ' + ud.LastName as	CareTakerName,
				ct.TypeName as CareTakerTypeName,
				ws.WorkShiftName as WorkModeName,
				ts.TimeShiftName as WorkTimeName,
				cso.Description as ContactPerson,
				CAST(ts.TimeShiftId AS VARCHAR) + '|' + CAST(ts.WorkingHours AS VARCHAR)+ '|' + FORMAT(ts.ShiftStartTime,'hh:mm tt') as WorkTimeDetails,
				Cast(ws.WorkShiftId as varchar) + '|'  + 
				cast((select case when ws.ShowResidentName =1 
				then 'true' 
				else 'false'
				end as worl) as varchar)as WorkShifDetails,
				CT.[Color] as ThemeColor 
		FROM Client_Scheduling cs
		INNER JOIN [dbo].[Caretaker_Details] ctd on ctd.UserId = cs.CaretakerUserId
		INNER JOIN [dbo].[UserDetails_Master] ud on ud.UserId = cs.CaretakerUserId
		INNER JOIN [dbo].[Settings_CaretakerType] ct on  ct.TypeId = ctd.CaretakerTypeId
		INNER JOIN [dbo].[Client_Master] cl ON cl.ClientId = CS.ClientId
		LEFT JOIN [dbo].[Settings_WorkShift] ws on ws.WorkShiftId =cs.WorkShiftId
		LEFT JOIN [dbo].[Settings_TimeShift] ts on ts.TimeShiftId =cs.TimeShiftId
		LEFT JOIN [dbo].[Client_OneToOne_Details] cso on cso.SchedulingId = cs.SchedulingId
		WHERE cs.SchedulingId = ISNULL(@ScheduleId,cs.SchedulingId) and cl.ClientStatus=1 and ([StartDateTime] between @StartDate and @EndDate) and ([EndDateTime] between @StartDate and @EndDate)
END