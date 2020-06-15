CREATE PROCEDURE [dbo].[SpDeleteClientScheduleOneToOneTable] 
(@ScheduleId int)
AS
BEGIN
	DELETE FROM [dbo].[Client_OneToOne_Details]
	WHERE SchedulingId = @ScheduleId	
END