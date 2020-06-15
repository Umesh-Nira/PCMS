
Create PROCEDURE [dbo].[SpSelectTimeShiftDetailsByClientid] 
	(@clientId int) 
AS
BEGIN
	
		SELECT TimeShiftId, 
			TimeShiftName, 
			PayingHours, 
			WorkingHours, 
			ShiftStartTime AS StartTime
		FROM  [dbo].[Settings_TimeShift]
		WHERE TimeShiftId in (select ShiftId from Client_ShiftDetails where ClientId= @clientId)
END