CREATE PROCEDURE [dbo].[SpGetCareTakersByCareTakerTypeAndDateTime] 
(
@CareTakerTypeId INT,
@Start  datetime,
@hours int,
@clientId int
)
AS
BEGIN
         --select * from Client_Scheduling
		 if(@hours > 0)
		 begin
		 			SELECT	DISTINCT (CD.UserId) AS CaretakerId,
		  [FirstName] +' '+[LastName] AS CareTakerName

		  FROM [dbo].Client_Caretaker_Mapping cm 
		  INNER JOIN  [UserDetails_Master] UD ON cm.CaretakerUserId = UD.UserId	
		  inner join [dbo].[Caretaker_Details] CD  on CD.UserId = UD.UserId	  
		  
		  WHERE CD.CaretakerTypeId = @CareTakerTypeId
		  and cm.ClientId=@clientId
		  AND  UD.UserStatus =1  and cd.CaretakerStatus=2
		  and	CD.UserId not in
		 -- (select CaretakerUserId from Client_Scheduling where StartDateTime between @Start and dateadd(HOUR, @hours, @Start) or EndDateTime between @Start and dateadd(HOUR, @hours, @Start))	
		  -- (select CaretakerUserId from Client_Scheduling where StartDateTime = @Start and EndDateTime= dateadd(HOUR, @hours, @Start))
		  (select CaretakerUserId from Client_Scheduling 
		   where 
		   StartDateTime < dateadd(HOUR, @hours, @Start)
		   and  
		   EndDateTime > @Start 
		   and 
		   CaretakerTypeId =@CareTakerTypeId 
		   and ClientId=@clientId )	

		  ORDER BY CareTakerName
		 end
		 else 
			begin
		 

		  			SELECT	DISTINCT(CD.UserId) AS CaretakerId,
		  [FirstName] +' '+[LastName] AS CareTakerName
		  FROM [dbo].Client_Caretaker_Mapping cm 
		  INNER JOIN  [UserDetails_Master] UD ON cm.CaretakerUserId = UD.UserId	
		  inner join [dbo].[Caretaker_Details] CD  on CD.UserId = UD.UserId	  
		  
		  WHERE CD.CaretakerTypeId = @CareTakerTypeId
		  and cm.ClientId=@clientId
		  AND  UD.UserStatus =1  and cd.CaretakerStatus=2
		   and	CD.UserId not in
		 -- (select CaretakerUserId from Client_Scheduling where StartDateTime between @Start and dateadd(HOUR, @hours, @Start) or EndDateTime between @Start and dateadd(HOUR, @hours, @Start))	
		   --(select CaretakerUserId from Client_Scheduling where StartDateTime = @Start and EndDateTime= dateadd(HOUR, @hours, @Start))	
		   (select CaretakerUserId from Client_Scheduling 
		   where 
		   StartDateTime < dateadd(HOUR, @hours, @Start)
		   and  
		   EndDateTime > @Start 
		   and
		   CaretakerTypeId =@CareTakerTypeId
		    and 
			ClientId=@clientId)
		  ORDER BY CareTakerName

		 end
          
END