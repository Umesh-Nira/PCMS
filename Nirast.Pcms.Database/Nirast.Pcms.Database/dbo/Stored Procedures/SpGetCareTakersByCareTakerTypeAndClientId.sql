Create PROCEDURE [dbo].[SpGetCareTakersByCareTakerTypeAndClientId] 
(
@CareTakerTypeId INT,
@ClientId  int
)
AS
BEGIN



		  SELECT	cm.CaretakerUserId AS CaretakerId,
					[FirstName] +' '+[LastName] AS CareTakerName
		  FROM [dbo].Client_Caretaker_Mapping cm 		    
		  INNER JOIN  [UserDetails_Master] UD ON cm.CaretakerUserId = UD.UserId
		  inner join [dbo].[Caretaker_Details] CD  on CD.UserId = UD.UserId
		  WHERE 
		  CD.CaretakerTypeId = @CareTakerTypeId and cm.ClientId=@clientId
			AND  cd.CaretakerStatus=2 and cd.CaretakerStatus <> 3

END