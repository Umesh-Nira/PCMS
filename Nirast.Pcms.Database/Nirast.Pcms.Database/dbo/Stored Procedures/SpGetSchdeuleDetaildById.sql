 
CREATE PROC [dbo].[SpGetSchdeuleDetaildById]
	(@SchedulingId int)
AS
BEGIN
	select CS.SchedulingId ,cm.ClientName,
	Convert(varchar, cs.StartDateTime, 100)as Startdate,
	--cs.StartDateTime as Startdate,
	--cs.EndDateTime as Enddate ,
	Convert(varchar, cs.EndDateTime, 100)as Enddate,
	cs.ClientId,um.FirstName + '' +um.LastName as CareTakerName,
	cs.CaretakerUserId as CareTaker,
	sw.WorkShiftName as WorkModeName,
	cs.Description 
from Client_Scheduling cs
inner join Client_Master cm on cm.ClientId=cs.ClientId
inner join UserDetails_Master um on um.UserId=cs.CaretakerUserId
left join Settings_WorkShift sw on sw.WorkShiftId=cs.WorkShiftId
where cs.SchedulingId=@SchedulingId
END