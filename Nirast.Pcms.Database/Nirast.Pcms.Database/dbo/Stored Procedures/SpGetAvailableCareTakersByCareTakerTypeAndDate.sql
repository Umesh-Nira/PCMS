--[SpGetAvailableCareTakersByCareTakerTypeAndDate] 3,'2019-09-10',0,11,12
CREATE PROCEDURE [dbo].[SpGetAvailableCareTakersByCareTakerTypeAndDate] 
(
@CareTakerTypeId INT,
@Start  datetime,
@hours int,
@clientId int,
@Workshift int
)
AS
BEGIN
	if(@Workshift >= 0)
		begin
     SELECT DISTINCT	CD.UserId AS CaretakerId,
		  [FirstName] +' '+[LastName] AS CareTakerName,
		  cd.ProfileId,isnull(ua.Phone1,'') as Phone1,ua.Location as TypeName,count(crs.RejectedId)RejectedId,
		(select case when count(crs.RejectedId) = 0 then ' ' else 'red' end as status) as rejectedstatus

		  FROM [dbo].[Caretaker_Payroll_Rates] cm 
		  INNER JOIN  [UserDetails_Master] UD ON cm.CaretakerId = UD.UserId	
		  inner join User_AddressDetails ua on ua.UserId=UD.UserId
		  inner join [dbo].[Caretaker_Details] CD  on CD.UserId = UD.UserId	  
		  inner join Settings_CaretakerType st on st.TypeId=cd.CaretakerTypeId		  
		  left join Caretaker_Rejected_Schedulings crs on crs.CareTakerId=cd.UserId and cast(crs.ScheduleDate as date) =cast(@Start as date)  and crs.Workshift=@Workshift
		  WHERE CD.CaretakerTypeId = @CareTakerTypeId
		  and cm.ClientId=@clientId
		  AND  UD.UserStatus =1  and cd.CaretakerStatus=2 and cm.MapStatus=1
		  and	CD.UserId not in
		   (select CaretakerUserId from Client_Scheduling 
		   where 
		   StartDateTime < dateadd(HOUR, @hours, @Start)
		   and  
		   EndDateTime > @Start 
		   and 
		   CaretakerTypeId =@CareTakerTypeId 
		   --and ClientId=@clientId 
		   )	
		   group by CD.UserId,[FirstName],[LastName],ProfileId,Phone1,Location,RejectedId
		   order by 2
		   END
		   ELSE
		   BEGIN
			   SELECT DISTINCT	CD.UserId AS CaretakerId,
		  [FirstName] +' '+[LastName] AS CareTakerName,
		  cd.ProfileId,isnull(ua.Phone1,'') as Phone1,ua.Location as TypeName,count(crs.RejectedId)RejectedId,
		(select case when count(crs.RejectedId) = 0 then ' ' else 'red' end as status) as rejectedstatus

		  FROM [dbo].[Caretaker_Payroll_Rates] cm 
		  INNER JOIN  [UserDetails_Master] UD ON cm.CaretakerId = UD.UserId	
		  inner join User_AddressDetails ua on ua.UserId=UD.UserId
		  inner join [dbo].[Caretaker_Details] CD  on CD.UserId = UD.UserId	  
		  inner join Settings_CaretakerType st on st.TypeId=cd.CaretakerTypeId		  
		  left join Caretaker_Rejected_Schedulings crs on crs.CareTakerId=cd.UserId and cast(crs.ScheduleDate as date) =cast(@Start as date)  
		  WHERE CD.CaretakerTypeId = @CareTakerTypeId
		  and cm.ClientId=@clientId
		  AND  UD.UserStatus =1  and cd.CaretakerStatus=2 and cm.MapStatus=1
		  and	CD.UserId not in
		   (select CaretakerUserId from Client_Scheduling 
		   where 
		   StartDateTime < dateadd(HOUR, @hours, @Start)
		   and  
		   EndDateTime > @Start 
		   and 
		   CaretakerTypeId =@CareTakerTypeId 
		   --and ClientId=@clientId 
		   )	
		   group by CD.UserId,[FirstName],[LastName],ProfileId,Phone1,Location,RejectedId
		   order by 2
		   END

END