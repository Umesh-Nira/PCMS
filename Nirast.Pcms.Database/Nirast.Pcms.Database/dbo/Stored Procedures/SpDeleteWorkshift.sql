CREATE PROCEDURE [dbo].[SpDeleteWorkshift]
(
	@ShiftId int
)
AS
BEGIN
	
		DELETE [dbo].[Settings_WorkShift]
		WHERE [WorkShiftId] = @ShiftId
END