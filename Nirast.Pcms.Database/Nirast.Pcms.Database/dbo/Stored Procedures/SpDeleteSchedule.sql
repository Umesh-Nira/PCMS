CREATE PROCEDURE [dbo].[SpDeleteSchedule]--8
(
	@Id			INT
)
AS
BEGIN
		DELETE FROM [dbo].[Client_OneToOne_Details]
		WHERE [SchedulingId] = @Id
		
		Delete from [dbo].[Client_Scheduling_Dates]
		where [SchedulingId]=@Id

		DELETE [dbo].[Client_Scheduling]
		WHERE  SchedulingId = @Id

		
		
		
END