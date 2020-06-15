CREATE proc [dbo].[SpGetInvoiceReport]
	@CareTakerId int, 
	@CategoryId int, 
	@FromDate datetime,
	@ToDate datetime,
	@Year int,	
	@Month	int,
	@IsOrientation bit,
	@ClientId int
as
begin
	 Declare @SQLQueryFirst AS varchar(max)
	 Declare @SQLQueryLast AS varchar(max)
	 Declare @SQLWhere AS varchar(max)
	 Declare @SQL AS nvarchar(max)
	 Declare @ParamDefinition AS nvarchar(2000) 
	 DECLARE @Currency VARCHAR(100)
	 DECLARE @CurrencySymbol VARCHAR(10)

	 IF EXISTS (SELECT 1 from [Settings_Country] WHERE IsDefault = 1)
	 BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$') FROM [dbo].[Settings_Country] c Where IsDefault = 1
	 END
	 ELSE
	 BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$') FROM [dbo].[Settings_Country] c Where [CountryId] = 1
	 END 
	
	 SET @SQLWhere= ' where (1=1) '
	
				if @CareTakerId is not null 
					set @SQLWhere = @SQLWhere  + 'and (CaretakerUserId=@CareTakerId)'

				if @ClientId is not null 
				set @SQLWhere = @SQLWhere  + 'and (ClientId=@ClientId)'

				if @IsOrientation  = 'false' 
					set @SQLWhere = @SQLWhere  + 'and (WorkShiftId <> 3)'

				if @CategoryId is not null 
					set @SQLWhere = @SQLWhere  + 'and (CaretakerType=@CategoryId)'
				
				if @FromDate is not null and @ToDate is not null
					set @SQLWhere = @SQLWhere  + 'and cast(@ToDate as date) >= cast(StartDateTime as date) AND cast(EndDateTime as date) >= cast(@FromDate as date)'


	SET @SQLQueryFirst= 'select * from [dbo].[vw_SchedulingFirstDate]'
	SET @SQLQueryLast= 'select * from [dbo].[vw_SchedulingLastDate]'


	SET @SQL = @SQLQueryFirst + @SQLWhere + ' UNION ALL ' + @SQLQueryLast + @SQLWhere

	Declare @SQLOuter varchar(Max)
	set @SQLOuter = ' select distinct * ,
				'''+@Currency+''' as Currency,
				'''+@CurrencySymbol+''' as CurrencySymbol, '+
				'case 
					when  t1.Startdate =t1.Enddate then t1.EndHrs
					else t1.StartHrs end as Hours,
				t1.TotalHours-t1.RestTime as XHours,
				t2.HolidayPayValue,
				case 
					when  t1.Startdate =t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) then
						(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate =t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) then t2.HolidayPayValue *t1.rate 
								else t1.rate end as r) 
					when  t1.Startdate !=t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) then
						(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate !=t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays)then t2.HolidayPayValue *t1.rate 
								else t1.rate end as r) 
					else t1.rate end as Rate,
				cast(isnull(t2.HoildayHours-t2.HolidayRestTime,0)as decimal(10,2))as HoildayHours ,		
				cast((isnull(t2.HoildayHours-t2.HolidayRestTime,0)*t1.rate)*t2.HolidayPayValue as decimal(10,2)) as  HoildayAmout,
				(select case 
						when  t1.Startdate =t1.Enddate  then t1.EndHrs
						else t1.StartHrs end as hrs) *
						(select case 
								when  t1.Startdate =t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays)  then
								(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate =t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) then 
													t2.HolidayPayValue *t1.rate 
											else t1.rate end as r) 
								when  t1.Startdate !=t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays)  then
								(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate !=t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) then
													t2.HolidayPayValue *t1.rate 
											else t1.rate end as r) 
								else t1.rate end as rate) 
						as Total,
				case when t1.IsTaxApplicable = 1
							then (t1.TaxPercent * (select case when  t1.Startdate = t1.Enddate then 
																	t1.EndHrs
																else t1.StartHrs
																end as hrs)
												* (select case 	when  t1.Startdate =t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) then
																	(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate =t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) then t2.HolidayPayValue *t1.rate 
																				else t1.rate end as r)
																when  t1.Startdate !=t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) then
																	(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate !=t1.Enddate and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays)then t2.HolidayPayValue *t1.rate 
																				else t1.rate end as r) 
																else t1.rate end as rate))/100
							else 0 end as HST,
				CASE WHEN cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) 
						THEN cast(isnull(t2.HoildayHours-t2.HolidayRestTime,0)as decimal(10,2))
						ELSE 0
					END AS HoursInHoliday'

	SET @SQL = (@SQLOuter+ ' from ('+@SQL+')t1
				 left join [dbo].[vw_HolidayHours] t2 on t1.SchedulingId=t2.SchedulingId
				 order by t1.StartDate asc')

	print (@SQL)

	 Set @ParamDefinition = '@CareTakerId int,
							@CategoryId int,							
							@FromDate Datetime,
							@ToDate datetime,
							@Year int,
							@Month int,
							@ClientId int'


			Execute sp_Executesql @SQL, 
                @ParamDefinition,
				@CareTakerId,
				@CategoryId,
				@FromDate,
				@ToDate,
				@Year,
				@Month,
				@ClientId

	 
end