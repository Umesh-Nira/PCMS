--[SpGetAllScheduleRejectedCaretake] null,null,null
CREATE PROCEDURE [dbo].[SpGetAllScheduleRejectedCaretake](@Caretaker NVARCHAR(100),
@DateFrom DATETIME,
@DateTo DATETIME)
AS
BEGIN
	Set NoCount ON
    /* Variable Declaration */
    Declare @SQLQuery AS NVarchar(MAX)
	Declare @ParamDefinition AS NVarchar(2000) 
	IF(@Caretaker IS NULL AND @DateFrom IS NULL AND @DateTo IS NULL)
		SET @SQLQuery = 'SELECT TOP 25 '
	ELSE
		SET @SQLQuery = 'SELECT '
		
	SET @SQLQuery = @SQLQuery +  'ud.FirstName + '' ''+ ud.LastName as CaretakerName ,cm.ClientName, crs.Datetime ,crs.Description,isnull(st.TimeShiftName,'''') as WorkshiftName,cast(crs.ScheduleDate as date) as ScheduleDate
	from Caretaker_Rejected_Schedulings crs
	left join UserDetails_Master ud on ud.UserId =crs.CareTakerId
	left join Client_Master cm on cm.ClientId=crs.ClientId
	left join Settings_TimeShift st on st.TimeShiftId=crs.Workshift WHERE (1=1)'
	IF(@Caretaker IS NULL AND @DateFrom IS NULL AND @DateTo IS NULL)
		SET @SQLQuery = @SQLQuery + ' AND DATEPART(MM, crs.Datetime) = DATEPART(MM,GETUTCDATE())'
	IF @Caretaker IS NOT NULL
		SET @SQLQuery = @SQLQuery + ' AND crs.[CareTakerId]=@Caretaker'	
	IF @DateFrom  IS NOT NULL AND @DateTo IS NOT NULL
		SET @SQLQuery = @SQLQuery + ' AND crs.Datetime BETWEEN @DateFrom AND @DateTo'

	SET @SQLQuery = @SQLQuery + ' order by crs.Datetime  desc'

	Set @ParamDefinition = '@Caretaker NVARCHAR(100),
							@DateFrom DATETIME,
							@DateTo DATETIME'
							PRINT @SQLQuery
    /* Execute the Transact-SQL String with all parameter value's 
       Using sp_executesql Command */
    Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@Caretaker,
				@DateFrom,
				@DateTo
                
    If @@ERROR <> 0
    Set NoCount OFF
END