
CREATE PROCEDURE [dbo].[SpClientIvoiceSearchWithOutDateSplit] --2,3,'16-Feb-2019','19-feb-2019',null,null,0,null
(
	@CareTakerId int, 
	@CategoryId int, 
	@FromDate datetime,
	@ToDate datetime,
	@Year int,	
	@Month	int,
	@IsOrientation bit,
	@ClientId int

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


select distinct * , 
				(select case 
				when  t1.Startdate =t1.Enddate  then t1.EndHrs
				else t1.StartHrs
				end as hrs) as XHours,
		(t1.TotalHours-t1.RestTime)-cast(isnull(t2.HoildayHours-t2.HolidayRestTime,0)as decimal(10,2)) as Hours,
		t2.HolidayPayValue,

				(select case 
				when  t1.Startdate =t1.Enddate 
				and cast(t1.Startdate as date)in (select cast(HolidayDate as date) from Settings_Holidays)  then
		(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate =t1.Enddate 
		and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) then t2.HolidayPayValue *t1.rate else t1.rate end as r) 
		when  t1.Startdate !=t1.Enddate and cast(t1.Startdate as date)in (select cast(HolidayDate as date) from Settings_Holidays)  then
		(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate !=t1.Enddate 
		and cast(t1.Startdate as date)in (select cast(HolidayDate as date) from Settings_Holidays)then t2.HolidayPayValue *t1.rate else t1.rate end as r) 
		else t1.rate end as rate) as Rate,
		cast(isnull(t2.HoildayHours-t2.HolidayRestTime,0)as decimal(10,2))as HoildayHours ,		
		cast((isnull(t2.HoildayHours-t2.HolidayRestTime,0)*t1.rate)*t2.HolidayPayValue as decimal(10,2)) as  HoildayAmout ,


		(select case 
				when  t1.Startdate =t1.Enddate  then t1.EndHrs
				else t1.StartHrs
				end as hrs) *
						(select case 
				when  t1.Startdate =t1.Enddate 
				and cast(t1.Startdate as date)in (select cast(HolidayDate as date) from Settings_Holidays)  then
		(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate =t1.Enddate 
		and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) then t2.HolidayPayValue *t1.rate else t1.rate end as r) 
		when  t1.Startdate !=t1.Enddate and cast(t1.Startdate as date)in (select cast(HolidayDate as date) from Settings_Holidays)  then
		(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate !=t1.Enddate 
		and cast(t1.Startdate as date)in (select cast(HolidayDate as date) from Settings_Holidays)then t2.HolidayPayValue *t1.rate else t1.rate end as r) 
		else t1.rate end as rate) 
				as Total,


						(select case when t1.IsTaxApplicable = 1
		then (t1.TaxPercent * (select case 
				when  t1.Startdate =t1.Enddate  then t1.EndHrs
				else t1.StartHrs
				end as hrs) *
						(select case 
				when  t1.Startdate =t1.Enddate 
				and cast(t1.Startdate as date)in (select cast(HolidayDate as date) from Settings_Holidays)  then
		(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate =t1.Enddate 
		and cast(t1.Startdate as date) in (select cast(HolidayDate as date) from Settings_Holidays) then t2.HolidayPayValue *t1.rate else t1.rate end as r) 
		when  t1.Startdate !=t1.Enddate and cast(t1.Startdate as date)in (select cast(HolidayDate as date) from Settings_Holidays)  then
		(select case when t2.HolidayPayValue !=  null or t2.HolidayPayValue > 0 and t1.Startdate !=t1.Enddate 
		and cast(t1.Startdate as date)in (select cast(HolidayDate as date) from Settings_Holidays)then t2.HolidayPayValue *t1.rate else t1.rate end as r) 
		else t1.rate end as rate))/100
		else 0
		end as HST) as HST

		FROM
		(SELECT
			cs.schedulingid,cm.InvoiceNumber,cm.InvoicePrefix ,
			cm.ClientName,@Currency as Currency,cs.StartDateTime,cs.EndDateTime,max(csds.Date)  as detaildate,
			CAD.BuildingName ,ST.StateName,CAD.Zipcode,CAD.Phone1,
			@CurrencySymbol as CurrencySymbol,
			(cs.StartDateTime) as Startdate,
			((cs.EndDateTime)) as Enddate,
			cs.Description,
			format(cs.StartDateTime,''hh:mm tt'') as TimeIn,
			format((DATEADD(dd, DATEDIFF(dd, 0,  format(cs.EndDateTime,''hh:mm tt'')), 0)),''hh:mm tt'') AS TimeOut,
			isnull(ts.TimeShiftName,FORMAT(cs.StartDateTime,''hh:mm tt'') + '' to '' + FORMAT(cs.EndDateTime,''hh:mm tt'')) as WorkTimeName,
			ud.FirstName + '' '' + ud.LastName as		CareTakerName,
			ct.TypeName as ServiceTypeName,
			ws.WorkShiftName as WorkModeName,ws.IsSeparateInvoice,			
			(select case when csds.Hours >=8 then csds.Hours-(SELECT TOP 1 IntervalHours FROM [dbo].[Settings_IntervalHours]) else csds.Hours end as starthrs) as StartHrs, 
            (select case when csdsend.Hours >=8 then csdsend.Hours-(SELECT TOP 1 IntervalHours FROM [dbo].[Settings_IntervalHours]) else csdsend.Hours end as endhrs) as EndHrs, 
			cast((DATEDIFF(SECOND, cs.StartDateTime,cs.EndDateTime)*1.00/(60*60)) as decimal(10,2)) as TotalHours,
			(select case when (DATEDIFF(SECOND, cs.StartDateTime,cs.EndDateTime)*1.00/(60*60)) >=8 
			then (SELECT TOP 1 IntervalHours FROM [dbo].[Settings_IntervalHours])
			else ''0''
			end as timed) as RestTime,
			isnull(cc.Rate,0) as  TypeRate,
			isnull(ccr.Rate,0.00) as  Rate,
			isnull(cast(( isnull((ts.PayingHours),isnull((sum(csd.Hours)),(DATEDIFF(hour, cs.StartDateTime,cs.EndDateTime)))) * isnull(cc.Rate,0.00))as decimal(10,2)),0) as Amount,
			cm.HasMidNightCut,ccr.IsTaxApplicable,st.StateId,st.TaxPercent

FROM
    [Client_Scheduling] AS cs
		left join Client_Scheduling_Dates csd on cs.SchedulingId=csd.SchedulingId
		inner  join Client_Scheduling_Dates csds on cs.SchedulingId=csds.SchedulingId  and cast(cs.StartDateTime as  date) =cast(csds.Date as date)
		inner  join Client_Scheduling_Dates csdsend on cs.SchedulingId=csdsend.SchedulingId  and cast(cs.EndDateTime as  date) =cast(csdsend.Date as date)
		left join Client_Master cm on cm.ClientId=cs.ClientId
		left join Caretaker_Details ctd on ctd.UserId=cs.CaretakerUserId
		left join Client_Caretaker_Mapping cc on cc.CaretakerUserId=cs.CaretakerUserId and cc.ClientId=cs.ClientId
		left join Client_CaretakerType_Rate ccr on ccr.CaretakerTypeId=ctd.CaretakerTypeId and ccr.ClientId=cs.ClientId
		left join UserDetails_Master ud on ud.UserId=ctd.UserId	
		left join Settings_CaretakerType ct on  ct.TypeId=ctd.CaretakerTypeId
		left join Settings_WorkShift ws on ws.WorkShiftId =cs.WorkShiftId
		left join Settings_TimeShift ts on ts.TimeShiftId =cs.TimeShiftId
		left join Client_OneToOne_Details cso on cso.SchedulingId=cs.SchedulingId
		left join Client_AddressDetails cad on cad.ClientId=cm.ClientId and CAD.BuildingName= (SELECT TOP 1 CADS.BuildingName FROM Client_AddressDetails CADS WHERE CADS.ClientId = cm.ClientId )
		left join Settings_City sc on sc.CityId=cad.CityId
		left join Settings_State st on st.StateId=sc.StateId
WHERE
     (1=1) and (st.StateId is not null)'

				if @CareTakerId is not null 
					set @SQLQuery = @SQLQuery  + 'and (cs.CaretakerUserId=@CareTakerId)'

				if @ClientId is not null 
					set @SQLQuery = @SQLQuery  + 'and (cs.ClientId=@ClientId)'

				if @IsOrientation  = 'false' 
					set @SQLQuery = @SQLQuery  + 'and (cs.WorkShiftId <> 3)'

				if @CategoryId is not null 
					set @SQLQuery = @SQLQuery  + 'and (ct.TypeId=@CategoryId)'
				if @Year is not null 
					set @SQLQuery = @SQLQuery  + 'and (year(cs.StartDateTime)=@Year)'
				if @Month is not null 
					set @SQLQuery = @SQLQuery  + 'and (MONTH(cs.StartDateTime)=@Month)'

				--if @FromDate is not null and @ToDate is not null
				--	set @SQLQuery = @SQLQuery  + 'and (cast(cs.StartDateTime as date) between cast(@FromDate as date) and cast(@ToDate as date))'

				if @FromDate is not null and @ToDate is not null
					set @SQLQuery = @SQLQuery  + 'and cast(@ToDate as date) >= cast(cs.StartDateTime as date) AND cast(cs.EndDateTime as date) >= cast(@FromDate as date)'


					print '1' + @SQLQuery   




set @SQLQuery = @SQLQuery  + 'GROUP by csdsend.Hours,csds.Hours,cm.HasMidNightCut,ws.IsSeparateInvoice,CAD.BuildingName ,
		ST.StateName,CAD.Zipcode,CAD.Phone1,ts.TimeShiftName,cm.ClientName,st.TaxPercent,st.StateId,
		ccr.IsTaxApplicable,cs.Description,cs.StartDateTime,cs.EndDateTime,ud.FirstName,ud.LastName,ct.TypeName,
		ws.WorkShiftName,ts.PayingHours,cc.Rate,cs.SchedulingId,ccr.Rate,cm.InvoiceNumber,cm.InvoicePrefix)t1


		left join
		(select csd.SchedulingId,
			sum(csd.Hours) as HoildayHours,
			(select case when sum(csd.Hours) >=8 
			then (SELECT TOP 1 IntervalHours FROM [dbo].[Settings_IntervalHours])
			else ''0''
			end as timed) as HolidayRestTime,
			sum(Hours*shp.HolidayPayValue)  as HolidayAmount,
			isnull(shp.HolidayPayValue,0) as HolidayPayValue,
			sh.CountryId
			 from Settings_Holidays sh
			 JOIN Client_Scheduling_Dates csd on cast(csd.Date as date)=sh.HolidayDate
			 JOIN Settings_HolidayPay shp on shp.HolidayPayId=shp.HolidayPayId
			 join [dbo].[Client_Scheduling] B on B.SchedulingId = csd.SchedulingId
			 JOIN [dbo].[UserDetails_Master] CU on cu.UserId = b.CaretakerUserId
			 JOIN [dbo].[User_AddressDetails] cua on cua.UserId = b.CaretakerUserId
			 JOIN [dbo].[Settings_City] cuc on cuc.CityId = cua.CityId
			 JOIN [dbo].[Settings_State] cus on cus.StateId = cuc.StateId and cus.CountryId = sh.CountryId
			 WHERE Sh.StateId IS NULL OR Sh.StateId = cuc.StateId
			 group by csd.SchedulingId,sh.CountryId,shp.HolidayPayValue) t2
			 on t1.SchedulingId=t2.SchedulingId'
	

					Set @ParamDefinition = '@CareTakerId int,
							@CategoryId int,							
							@FromDate Datetime,
							@ToDate datetime,
							@Year int,
							@Month int,
							@ClientId int'
							



							    Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@CareTakerId,
				@CategoryId,
				@FromDate,
				@ToDate,
				@Year,
				@Month,
				@ClientId

					
				 
                
    If @@ERROR <> 0
    Set NoCount OFF