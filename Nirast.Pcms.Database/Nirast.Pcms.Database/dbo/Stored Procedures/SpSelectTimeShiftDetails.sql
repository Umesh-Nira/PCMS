
CREATE PROCEDURE [dbo].[SpSelectTimeShiftDetails] 
	(@TimeShiftId INT = 0) 
AS
BEGIN
	IF(@TimeShiftId = 0)
		SET @TimeShiftId = NULL

		SELECT TimeShiftId, 
			TimeShiftName, 
			PayingHours, 
			WorkingHours, 
			ShiftStartTime AS StartTime
		FROM  [dbo].[Settings_TimeShift]
		WHERE TimeShiftId = ISNULL(@TimeShiftId,TimeShiftId)
END