Create PROCEDURE [dbo].[SpGetCareTakersByServiceType] 
(
@ServiceId INT
)
AS
BEGIN
          SELECT	CD.UserId AS CaretakerId,
					[FirstName] +' '+[LastName] AS CareTakerName
		  FROM [dbo].[Caretaker_Details] CD 
		  INNER JOIN  [UserDetails_Master] UD ON CD.UserId = UD.UserId
		  inner join [Caretaker_PublicUser_Service]  cs on cs.UserId=ud.UserId
		  WHERE cs.ServiceId = @ServiceId
			AND  cd.CaretakerStatus=2
		  ORDER BY UD.FirstName



END