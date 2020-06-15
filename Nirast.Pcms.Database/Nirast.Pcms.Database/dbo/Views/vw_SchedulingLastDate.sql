




CREATE VIEW [dbo].[vw_SchedulingLastDate] AS
		SELECT
			cs.schedulingid,
			cm.InvoiceNumber,
			cm.InvoicePrefix,
			cm.ClientName,
			cs.StartDateTime,
			cs.EndDateTime,
			max(csds.Date) as detaildate,
			CAD.BuildingName ,
			ST.StateName,
			CAD.Zipcode,
			CAD.Phone1,
			(cs.EndDateTime) as Startdate,
			((cs.EndDateTime)) as Enddate,
			cs.Description,		
			CASE WHEN DATEDIFF(dd,cs.StartDateTime,cs.EndDateTime)=1		
					THEN Format(DATEADD(dd, DATEDIFF(dd, 0, cs.EndDateTime), 0),'hh:mm tt')     
					ELSE format(cs.StartDateTime,'hh:mm tt') END AS InTime,
			format(cs.EndDateTime,'hh:mm tt') AS TimeOut,
			isnull(ts.TimeShiftName,FORMAT(cs.StartDateTime,'hh:mm tt') + ' to ' + FORMAT(cs.EndDateTime,'hh:mm tt')) as WorkTimeName,
			ud.FirstName + ' ' + ud.LastName as	CareTakerName,
			ct.TypeName as ServiceTypeName,
			ws.WorkShiftName as WorkModeName,
			ws.IsSeparateInvoice,			
			case when cast((DATEDIFF(SECOND, cs.StartDateTime,cs.EndDateTime)*1.00/(60*60)) as decimal(10,2))>=8 or  csds.Hours >=8 
						then csds.Hours-(SELECT TOP 1 IntervalHours FROM [dbo].[Settings_IntervalHours]) 
						else csds.Hours end as StartHrs, 
            case when cast((DATEDIFF(SECOND, cs.StartDateTime,cs.EndDateTime)*1.00/(60*60)) as decimal(10,2))>=8 or csdsend.Hours >=8 
						then csdsend.Hours-(SELECT TOP 1 IntervalHours FROM [dbo].[Settings_IntervalHours]) 
						else csdsend.Hours end as EndHrs,
			cast((DATEDIFF(SECOND, cs.StartDateTime,cs.EndDateTime)*1.00/(60*60)) as decimal(10,2)) as TotalHours,
			case when (DATEDIFF(SECOND, cs.StartDateTime,cs.EndDateTime)*1.00/(60*60)) >=8 
					then (SELECT TOP 1 IntervalHours FROM [dbo].[Settings_IntervalHours])
					else '0' end as RestTime,
			isnull(dbo.getPayrollRate(cs.ClientId,cs.CaretakerUserId,cs.WorkShiftId,cs.StartDateTime),0) as TypeRate,
			isnull(dbo.getClientInvoiceRate(cs.ClientId,ct.TypeId,cs.EndDateTime),0.00) as XRate,
			isnull(cast(( isnull((ts.PayingHours),
			isnull((sum(csd.Hours)),
			(DATEDIFF(hour, cs.StartDateTime,cs.EndDateTime)))) * isnull(dbo.getPayrollRate(cs.ClientId,cs.CaretakerUserId,cs.WorkShiftId,cs.StartDateTime),0.00)) as decimal(10,2)),0) as Amount,
			cm.HasMidNightCut,
			dbo.getIsTaxApplicable(cs.ClientId,ct.TypeId) as IsTaxApplicable,
			st.StateId,
			st.TaxPercent,
			cs.CaretakerUserId,
			cs.ClientId,
			cs.WorkShiftId,
			ct.TypeId as CaretakerType

FROM [Client_Scheduling] AS cs
		left join Client_Scheduling_Dates csd on cs.SchedulingId=csd.SchedulingId
		inner join Client_Scheduling_Dates csds on cs.SchedulingId=csds.SchedulingId  and cast(cs.StartDateTime as date) =cast(csds.Date as date)
		inner join Client_Scheduling_Dates csdsend on cs.SchedulingId=csdsend.SchedulingId  and cast(cs.EndDateTime as date) =cast(csdsend.Date as date)
		left join Client_Master cm on cm.ClientId=cs.ClientId
		left join Caretaker_Details ctd on ctd.UserId=cs.CaretakerUserId
		left join Client_Caretaker_Mapping cc on cc.CaretakerUserId=cs.CaretakerUserId and cc.ClientId=cs.ClientId and cc.ShiftId = cs.WorkShiftId
		left join Client_Invoice_Rates ccr on ccr.CaretakerTypeId=ctd.CaretakerTypeId and ccr.ClientId=cs.ClientId
		left join UserDetails_Master ud on ud.UserId=ctd.UserId	
		left join Settings_CaretakerType ct on  ct.TypeId=ctd.CaretakerTypeId
		left join Settings_WorkShift ws on ws.WorkShiftId =cs.WorkShiftId
		left join Settings_TimeShift ts on ts.TimeShiftId =cs.TimeShiftId
		left join Client_OneToOne_Details cso on cso.SchedulingId=cs.SchedulingId
		left join Client_AddressDetails cad on cad.ClientId=cm.ClientId and CAD.BuildingName= (SELECT TOP 1 CADS.BuildingName FROM Client_AddressDetails CADS WHERE CADS.ClientId = cm.ClientId )
		left join Settings_City sc on sc.CityId=cad.CityId
		left join Settings_State st on st.StateId=sc.StateId
WHERE (1=1) and (st.StateId is not null)
GROUP by csdsend.Hours,csds.Hours,cm.HasMidNightCut,ws.IsSeparateInvoice,CAD.BuildingName ,
		ST.StateName,CAD.Zipcode,CAD.Phone1,ts.TimeShiftName,cm.ClientName,st.TaxPercent,st.StateId,
		cs.Description,cs.StartDateTime,cs.EndDateTime,ud.FirstName,ud.LastName,ct.TypeName,
		ws.WorkShiftName,ts.PayingHours,cs.SchedulingId,cm.InvoiceNumber,cm.InvoicePrefix,
		cs.CaretakerUserId, cs.ClientId, cs.WorkShiftId, ct.TypeId


-- select * from [vw_SchedulingLastDate] where Startdate >= '2019-08-01'