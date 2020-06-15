--spSelectCaretakerScheduleList 1005, null, null, null,'12/11/2018  8:00:00 AM', '12/17/2018  8:00:00 PM'
CREATE PROC [dbo].[spSelectCaretakerScheduleList] (
	@CaratakerUserId INT,
	@ClientId INT,
	@FromDate DATETIME,
	@ToDate DATETIME
) AS
	Declare @SQLQuery AS NVarchar(4000)
    Declare @ParamDefinition AS NVarchar(2000) 
	Set @SQLQuery = 'SELECT       Client_Master.ClientName, 
					Settings_WorkShift.WorkShiftName, 
					isnull(Settings_TimeShift.TimeShiftName,FORMAT(Client_Scheduling.StartDateTime,''hh:mm tt'') + '' to '' + FORMAT(Client_Scheduling.EndDateTime,''hh:mm tt'')) as TimeShiftName ,
					Client_Scheduling.Description, 
					Client_Scheduling.StartDateTime , 
					Client_OneToOne_Details.Description AS Description2
					FROM Client_Master INNER JOIN
                         Client_Scheduling ON Client_Master.ClientId = Client_Scheduling.ClientId LEFT JOIN
                         Settings_TimeShift ON Client_Scheduling.TimeShiftId = Settings_TimeShift.TimeShiftId INNER JOIN
                         Settings_WorkShift ON Client_Scheduling.WorkShiftId = Settings_WorkShift.WorkShiftId LEFT OUTER JOIN
                         Client_OneToOne_Details ON Client_Scheduling.SchedulingId = Client_OneToOne_Details.SchedulingId WHERE CaretakerUserId=@CaratakerUserId'
	IF(@ClientId IS NOT NULL)
	BEGIN
		Set @SQLQuery = @SQLQuery + ' And (Client_Scheduling.ClientId = @ClientId)'
	END

	IF(@FromDate IS NOT NULL AND @ToDate IS NOT NULL)
	BEGIN
		Set @SQLQuery = @SQLQuery + ' And cast(@ToDate as date) >= cast(Client_Scheduling.StartDateTime as date) AND cast(Client_Scheduling.EndDateTime as date) >= cast(@FromDate as date)'
	END
		Set @SQLQuery = @SQLQuery + ' ORDER BY Client_Scheduling.StartDateTime ASC'
	Set @ParamDefinition = '@CaratakerUserId int,
							@ClientId int,
							@FromDate DATETIME,
							@ToDate DATETIME'

	Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@CaratakerUserId,
				@ClientId,
				@FromDate,
				@ToDate
                
    If @@ERROR <> 0
    Set NoCount OFF