CREATE PROCEDURE [dbo].[SpGetCareTakersDdl]
AS
BEGIN
	 SELECT DISTINCT ud.UserId as CaretakerId, ud.FirstName + ' '+  ud.LastName as CareTakerName
		    FROM Caretaker_Details CD
			INNER JOIN  UserDetails_Master UD ON CD.UserId = UD.UserId
			WHERE UD.UserStatus <> 3
			ORDER BY 2
END
