CREATE PROCEDURE [dbo].[SpGetCareTakersByCareTakerType] (@CareTakerTypeId INT)
AS
BEGIN
          SELECT	CD.UserId AS CaretakerId,
					[FirstName] +' '+[LastName] AS CareTakerName
		  FROM [dbo].[Caretaker_Details] CD 
		  INNER JOIN  [UserDetails_Master] UD ON CD.UserId = UD.UserId
		  WHERE CD.CaretakerTypeId = @CareTakerTypeId
			AND  cd.CaretakerStatus=2
		  ORDER BY UD.FirstName
END