CREATE PROCEDURE [dbo].[SpGetPayHoursSummary] --null,null,null,null,null,null,null
(
	@ClientId int,
	@CareTakerId int, 
	@CategoryId int, 
	@FromDate datetime,
	@ToDate datetime,
	@Year int,	
	@Month	int
)
AS


	Declare @SQLQuery AS NVarchar(max)
    Declare @ParamDefinition AS NVarchar(2000) 



		set @SQLQuery= 'DECLARE @Currency VARCHAR(100)
 DECLARE @CurrencySymbol VARCHAR(10)

 IF EXISTS (SELECT 1 from [Settings_Country] WHERE IsDefault = 1)
 BEGIN
  SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,''$'') FROM [dbo].[Settings_Country] c Where IsDefault = 1
 END
 ELSE
 BEGIN
  SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,''$'') FROM [dbo].[Settings_Country] c Where [CountryId] = 1
 END 
	
SELECT CM.ClientName,CCM.CaretakerUserId, UD.FirstName + '' '' +  UD.LastName AS CareTakerName,
				ST.TypeName as ServiceTypeName,
				@CurrencySymbol as CurrencySymbol,
				CCM.Rate,
				(select case when ISNULL(SUM(CSD.Hours),0) >= 8 or ISNULL(SUM(CSD.Hours),0)>=12 then ISNULL(SUM(CSD.Hours),0)-(SELECT TOP 1 IntervalHours FROM [dbo].[Settings_IntervalHours]) else ISNULL(SUM(CSD.Hours),0) end as hrs) as hours,
				(select case when ISNULL(SUM(CSDX.Hours),0) >= 8 or ISNULL(SUM(CSDX.Hours),0)>=12 then ISNULL(SUM(CSDX.Hours),0)-(SELECT TOP 1 IntervalHours FROM [dbo].[Settings_IntervalHours]) else ISNULL(SUM(CSDX.Hours),0) end as hrs) as HoildayHours, 
					isnull(shp.HolidayPayValue,0) as HolidayPayValue
 FROM Client_Caretaker_Mapping CCM

left  JOIN Client_Master CM ON CM.ClientId=CCM.ClientId
left  JOIN Caretaker_Details CD ON CD.UserId=CCM.CaretakerUserId
left  JOIN Settings_CaretakerType ST ON ST.TypeId=CD.CaretakerTypeId
left  JOIN UserDetails_Master UD ON UD.UserId=CD.UserId
LEFT JOIN Client_Scheduling CS ON CS. ClientId=CCM.ClientId AND CS.CaretakerUserId=CCM.CaretakerUserId
LEFT JOIN Client_Scheduling_Dates CSD ON CSD.SchedulingId=CS.SchedulingId and cast(@ToDate as date) >= cast(CSD.Date as date) AND cast(CSD.Date as date) >= cast(@FromDate as date)
left join Client_Scheduling_Dates CSDX ON CSDX.SchedulingId=CS.SchedulingId and CAST(CSDX.DATE AS DATE) IN (SELECT CAST(HolidayDate AS DATE) FROM Settings_Holidays )  and cast(csdx.date as date )=cast(csd.date as date)
 JOIN Settings_HolidayPay shp on shp.HolidayPayId=shp.HolidayPayId

 WHERE (1=1) '
			
				if @ClientId is not null 
					set @SQLQuery = @SQLQuery  + 'and (cs.ClientId=@ClientId)'

				if @CareTakerId is not null 
					set @SQLQuery = @SQLQuery  + 'and (CCM.CaretakerUserId=@CareTakerId)'

				if @CategoryId is not null 
					set @SQLQuery = @SQLQuery  + 'and (ST.TypeId=@CategoryId)'

				if @Year is not null 
					set @SQLQuery = @SQLQuery  + 'and (year(cs.StartDateTime)=@Year)'

				if @Month is not null 
					set @SQLQuery = @SQLQuery  + 'and (MONTH(cs.StartDateTime)=@Month)'

				if @FromDate is not null and @ToDate is not null
					set @SQLQuery = @SQLQuery  + 'and cast(@ToDate as date) >= cast(cs.StartDateTime as date) AND cast(cs.EndDateTime as date) >= cast(@FromDate as date)'

					set @SQLQuery=@SQLQuery + 'GROUP BY shP.HolidayPayValue,CCM.ClientId,CM.ClientName,UD.FirstName,UD.LastName,CCM.Rate,ST.TypeName,CCM.CaretakerUserId'

				print @SQLQuery
		

					Set @ParamDefinition = '@ClientId int,
							@CareTakerId int,
							@CategoryId int,							
							@FromDate Datetime,
							@ToDate datetime,
							@Year int,
							@Month int'
							
							    Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@ClientId,
				@CareTakerId,
				@CategoryId,
				@FromDate,
				@ToDate,
				@Year,
				@Month
				 
                
    If @@ERROR <> 0
    Set NoCount OFF