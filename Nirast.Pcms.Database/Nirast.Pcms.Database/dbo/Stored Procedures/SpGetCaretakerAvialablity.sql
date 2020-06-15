CREATE PROC [dbo].[SpGetCaretakerAvialablity]
	(
	@FromDate datetime,
	@ToDate datetime,
	@ClientId int
	)
AS
BEGIN


--drop table #MyTempTable

DECLARE @dt1 Datetime=@FromDate
DECLARE @dt2 Datetime=@ToDate
;WITH ctedaterange 
     AS (SELECT [Dates]=@dt1  
		 UNION ALL
		 SELECT [dates] + 1 
         FROM   ctedaterange 
         WHERE  [dates] + 1<= @dt2) 
SELECT [dates] 
into #MyTempTable
FROM   ctedaterange 
OPTION (maxrecursion 0)

if @ClientId > 0
begin


		SELECT	cs.ClientId,cm.ClientName,cs.CaretakerUserId,cs.Description,
		ud.FirstName + ' ' + ud.LastName as CareTakerName,
		ct.TypeName as ServiceTypeName,mt.Dates,
		sum(csd.hours) as TotalHours,
		isnull(st.TimeShiftName,FORMAT(cs.StartDateTime,'h:mm tt') + '-' + FORMAT(cs.EndDateTime,'h:mm tt')) + ' ['+ isnull(cs.Description,' ') + ']' as Timeshifts,
			isnull(st.TimeShiftName,FORMAT(cs.StartDateTime,'h:mm tt') + '-' + FORMAT(cs.EndDateTime,'h:mm tt')) as 'Time',
			cast(isnull(cast(st.ShiftStartTime as time),cast(cs.StartDateTime as time)) as varchar) as 'StartTime'
				FROM #MyTempTable mt
				left join Client_Scheduling_Dates csd	 on cast(csd.Date as date)=mt.dates
				left join Client_Scheduling       cs	 on cs.SchedulingId=csd.SchedulingId and cs.ClientId=@ClientId and cast(cs.StartDateTime as date)=cast(mt.dates as date)
				left join Client_Master			 cm	     on cm.ClientId=cs.ClientId 
				left join Caretaker_Details 	  ctd	 on ctd.UserId=cs.CaretakerUserId
				left join UserDetails_Master 	  ud	 on ud.UserId=ctd.UserId
				left join Settings_CaretakerType  ct     on  ct.TypeId=ctd.CaretakerTypeId	
				left join Settings_TimeShift st on st.TimeShiftId=cs.TimeShiftId			
				group by ctd.CaretakerTypeId,cs.CaretakerUserId,mt.Dates,ud.FirstName,ud.LastName,ct.TypeName,cs.ClientId,cm.ClientName,st.TimeShiftName,cs.StartDateTime,cs.EndDateTime,cs.Description,st.ShiftStartTime
				order by dates
end
else
begin
		SELECT	cs.ClientId,
			cm.ClientName,
			cs.CaretakerUserId,
			cs.Description,
			ud.FirstName + ' ' + ud.LastName as CareTakerName,
			ct.TypeName as ServiceTypeName,
			mt.Dates,
			sum(csd.hours) as TotalHours,			
			isnull(st.TimeShiftName,FORMAT(cs.StartDateTime,'h:mm tt') + '-' + FORMAT(cs.EndDateTime,'h:mm tt')) + ' ['+ isnull(cs.Description,' ') + ']' as Timeshifts,
			isnull(st.TimeShiftName,FORMAT(cs.StartDateTime,'h:mm tt') + '-' + FORMAT(cs.EndDateTime,'h:mm tt')) as 'Time',
			cast(isnull(cast(st.ShiftStartTime as time),cast(cs.StartDateTime as time)) as varchar) as 'StartTime'
		FROM #MyTempTable mt
			left join Client_Scheduling_Dates csd	 on cast(csd.Date as date)=mt.dates
			left join Client_Scheduling       cs	 on cs.SchedulingId=csd.SchedulingId and cast(cs.StartDateTime as date)=cast(mt.dates as date)
			left join Client_Master			 cm	     on cm.ClientId=cs.ClientId 
			left join Caretaker_Details 	  ctd	 on ctd.UserId=cs.CaretakerUserId
			left join UserDetails_Master 	  ud	 on ud.UserId=ctd.UserId
			left join Settings_CaretakerType  ct     on  ct.TypeId=ctd.CaretakerTypeId	
			left join Settings_TimeShift st on st.TimeShiftId=cs.TimeShiftId			
		group by ctd.CaretakerTypeId,cs.CaretakerUserId,mt.Dates,ud.FirstName,ud.LastName,
			ct.TypeName,cs.ClientId,cm.ClientName,st.TimeShiftName,cs.StartDateTime,cs.EndDateTime,cs.Description,st.ShiftStartTime
		order by mt.[dates]
end
END
