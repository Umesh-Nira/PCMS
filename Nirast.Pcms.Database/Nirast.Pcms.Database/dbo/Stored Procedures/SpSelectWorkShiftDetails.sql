
CREATE PROCEDURE [dbo].[SpSelectWorkShiftDetails] 
	(@WorkShiftId INT = 0) 
AS
BEGIN
		IF(@WorkShiftId = 0)
				SET @WorkShiftId = NULL

		SELECT WorkShiftId AS ShiftId, 
			WorkShiftName AS ShiftName,
			ShowResidentName,
			IsSeparateInvoice
		FROM [dbo].[Settings_WorkShift]
		WHERE WorkShiftId = ISNULL(@WorkShiftId,WorkShiftId)
END