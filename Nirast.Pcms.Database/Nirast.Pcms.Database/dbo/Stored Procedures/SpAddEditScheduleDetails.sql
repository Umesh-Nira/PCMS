CREATE PROCEDURE [dbo].[SpAddEditScheduleDetails] 
(
	@Id						INT = 0,
	@ClientId				INT,
	@WorkShiftId			INT,
	@TimeShiftId			INT,
	@StartDate				DATETIME,
	@EndDate				DATETIME,
	@ScheduleDescription	NVARCHAR(50),
	@CareTaker				INT,
	@ScheduledID_OUT		INT OUT
)
AS
BEGIN
	IF @Id = 0
		BEGIN
			INSERT INTO [dbo].[Client_Scheduling]
			   (
					[ClientId],
					[WorkShiftId],
					[TimeShiftId],
					[StartDateTime],
					[EndDateTime],
					[Description],
					[CaretakerUserId]
				)
			VALUES
			   (
					@ClientId,
					@WorkShiftId,
					@TimeShiftId,
					@StartDate,
					@EndDate,
					@ScheduleDescription,
					@CareTaker
				)
				SET @ScheduledID_OUT=SCOPE_IDENTITY()
		END
	ELSE
		BEGIN
			UPDATE [dbo].[Client_Scheduling]
			SET
					[ClientId]=@ClientId,
					[WorkShiftId]=@WorkShiftId,
					[TimeShiftId]=@TimeShiftId,
					[StartDateTime]=@StartDate,
					[EndDateTime]=@EndDate,
					[Description]=@ScheduleDescription,
					[CaretakerUserId]=@CareTaker
			WHERE SchedulingId = @Id
			SET @ScheduledID_OUT=@Id
		END	
END