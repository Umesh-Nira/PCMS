Create PROCEDURE [dbo].[SpDeleteClientSchedulingDates] 
(@ScheduleId int)
AS
BEGIN

	DELETE FROM [dbo].[Client_Scheduling_Dates] WHERE SchedulingId=@ScheduleId
END