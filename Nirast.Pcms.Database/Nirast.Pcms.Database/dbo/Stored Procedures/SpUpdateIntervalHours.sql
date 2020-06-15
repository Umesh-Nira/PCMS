Create PROCEDURE [dbo].[SpUpdateIntervalHours]
	(@IntervalHours float)
AS
 BEGIN
        UPDATE [dbo].[Settings_IntervalHours]
        SET 
         IntervalHours  = @IntervalHours
 END