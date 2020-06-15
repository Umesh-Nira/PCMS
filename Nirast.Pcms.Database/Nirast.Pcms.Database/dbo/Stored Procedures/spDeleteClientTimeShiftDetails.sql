CREATE PROC spDeleteClientTimeShiftDetails 
	(@TimeShiftId INT) AS
BEGIN
	DELETE FROM [dbo].[Settings_TimeShift] 
	WHERE TimeShiftId = @TimeShiftId
END