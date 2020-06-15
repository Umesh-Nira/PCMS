CREATE PROCEDURE [dbo].[SpCaretakerIvoiceSearch]--null,null,null,null,null,null,null,2
(
	@CareTakerId int, 
	@CategoryId int, 
	@FromDate datetime,
	@ToDate datetime,
	@Year int,
	@Month	int,
	@Workmode int,
	@ClientId int
)
AS


	Declare @SQLQuery AS NVarchar(max)
    Declare @ParamDefinition AS NVarchar(2000) 


		Set @SQLQuery ='
		
		DECLARE @Currency VARCHAR(100)
 DECLARE @CurrencySymbol VARCHAR(10)

 IF EXISTS (SELECT 1 from [Settings_Country] WHERE IsDefault = 1)
 BEGIN
  SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,''$'') FROM [dbo].[Settings_Country] c Where IsDefault = 1
 END
 ELSE
 BEGIN
  SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,''$'') FROM [dbo].[Settings_Country] c Where [CountryId] = 1
 END
		
		
		select *, 
		t1.hours-t1.RestTime as WorkTIme,
		cast(isnull(t2.HoildayHours,0)as decimal(10,2))as HoildayHours ,		
		cast((isnull(t2.HoildayHours,0)*t1.rate)*t2.HolidayPayValue as decimal(10,2)) as  HoildayAmout ,
		isnull(((t1.hours-t1.RestTime)*t1.Rate)+ ((isnull(t2.HoildayHours,0)*t1.rate)*t2.HolidayPayValue),(t1.hours-t1.RestTime)*t1.Rate) as Total
		from 
			(SELECT 
			cs.SchedulingId,
				cm.ClientName,
				format(cs.StartDateTime,''dd/MM/yyyy'') as Startdate,
				isnull((format(max(csd.Date),''dd/MM/yyyy'')),(format(cs.EndDateTime,''dd/MM/yyyy''))) as Enddate,
				format(cs.StartDateTime,''hh:mm tt'') as TimeIn,
				format(cs.EndDateTime,''hh:mm tt'')as TimeOut,
				ud.FirstName + '+' '+' + ud.LastName as		CareTakerName,
				ct.TypeName as ServiceTypeName,
				ws.WorkShiftName as WorkModeName,
				cs.Description,
				@Currency as Currency,
				@CurrencySymbol as CurrencySymbol,
				isnull((ts.PayingHours),isnull((sum(csd.Hours)),(DATEDIFF(SECOND, cs.StartDateTime,cs.EndDateTime)*1.00/(60*60)))) as Hours,
				(select case when isnull((ts.PayingHours),isnull((sum(csd.Hours)),(DATEDIFF(SECOND, cs.StartDateTime,cs.EndDateTime)*1.00/(60*60)))) >=8 
							then ''.5'' 
							else ''0'' 
							end as timed) as RestTime,
				isnull(cc.Rate,isnull(ccr.Rate,0.00)) as  Rate,
				isnull(cast(( isnull((ts.PayingHours),isnull((sum(csd.Hours)),(DATEDIFF(hour, cs.StartDateTime,cs.EndDateTime)))) * isnull(cc.Rate,0.00))as decimal(10,2)),0) as Amount
						FROM Client_Scheduling cs
						left join Client_Scheduling_Dates csd on cs.SchedulingId=csd.SchedulingId
						left join Client_Master cm on cm.ClientId=cs.ClientId
						left join Caretaker_Details ctd on ctd.UserId=cs.CaretakerUserId
						left join Client_Caretaker_Mapping cc on cc.CaretakerUserId=cs.CaretakerUserId and cc.ClientId=cs.ClientId
						left join Client_CaretakerType_Rate ccr on ccr.CaretakerTypeId=ctd.CaretakerTypeId and ccr.ClientId=cs.ClientId
						left join UserDetails_Master ud on ud.UserId=ctd.UserId
						left join Settings_CaretakerType ct on  ct.TypeId=ctd.CaretakerTypeId
						left join Settings_WorkShift ws on ws.WorkShiftId =cs.WorkShiftId
						left join Settings_TimeShift ts on ts.TimeShiftId =cs.TimeShiftId
						left join Client_OneToOne_Details cso on cso.SchedulingId=cs.SchedulingId
						where (1=1)'

				 if @ClientId is not null 
					set @SQLQuery = @SQLQuery  + 'and (cs.ClientId=@ClientId)'
				if @CareTakerId is not null 
					set @SQLQuery = @SQLQuery  + 'and (cs.CaretakerUserId=@CareTakerId)'
				if @CategoryId is not null 
					set @SQLQuery = @SQLQuery  + 'and (ctd.CaretakerTypeId=@CategoryId)'
				if @Workmode is not null 
					set @SQLQuery = @SQLQuery  + 'and (cs.WorkShiftId=@Workmode)'
				if @Year is not null 
					set @SQLQuery = @SQLQuery  + 'and (year(cs.StartDateTime)=@Year)'
				if @Month is not null 
					set @SQLQuery = @SQLQuery  + 'and (MONTH(cs.StartDateTime)=@Month)'
				if @FromDate is not null and @ToDate is not null
					set @SQLQuery = @SQLQuery  + 'and (cs.StartDateTime between @FromDate and @ToDate)'

		set @SQLQuery=@SQLQuery + 'group by cs.Description,cs.StartDateTime,cs.EndDateTime,ud.FirstName,ud.LastName,ct.TypeName,ws.WorkShiftName,ts.PayingHours,cc.Rate,cs.SchedulingId,cm.ClientName,ccr.Rate )  t1
		left join
		(select csd.SchedulingId,
			sum(csd.Hours) as HoildayHours,
			sum(Hours*shp.HolidayPayValue)  as HolidayAmount,
			isnull(shp.HolidayPayValue,0) as HolidayPayValue,
			sh.CountryId
			 from Settings_Holidays sh
			 JOIN Client_Scheduling_Dates csd on csd.Date=sh.HolidayDate
			 JOIN Settings_HolidayPay shp on shp.HolidayPayId=shp.HolidayPayId
			 join [dbo].[Client_Scheduling] B on B.SchedulingId = csd.SchedulingId
			 JOIN [dbo].[UserDetails_Master] CU on cu.UserId = b.CaretakerUserId
			 JOIN [dbo].[User_AddressDetails] cua on cua.UserId = b.CaretakerUserId
			 JOIN [dbo].[Settings_City] cuc on cuc.CityId = cua.CityId
			 JOIN [dbo].[Settings_State] cus on cus.StateId = cuc.StateId and cus.CountryId = sh.CountryId
			 WHERE Sh.StateId IS NULL OR Sh.StateId = cuc.StateId
			 group by csd.SchedulingId,sh.CountryId,shp.HolidayPayValue) t2
			 on t1.SchedulingId=t2.SchedulingId
			 	 order by t1.Startdate'

					Set @ParamDefinition = '@CareTakerId int,
							@CategoryId int,							
							@FromDate Datetime,
							@ToDate datetime,
							@Year int,
							@Month int,
							@Workmode int,
							@ClientId int'

							    Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@CareTakerId,
				@CategoryId,
				@FromDate,
				@ToDate,
				@Year,
				@Month,
				@Workmode,
				@ClientId 
                
    If @@ERROR <> 0
    Set NoCount OFF