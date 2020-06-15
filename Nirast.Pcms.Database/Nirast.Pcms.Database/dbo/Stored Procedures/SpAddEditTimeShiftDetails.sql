/*
-----------------------------------------------------------------------------------
< Insert/Update time shift details >

Author				: Nowfal S R
Created Date		: 10-August-2018

Last Updated BY		: 
Last Updated Date	: 
Updation			: 
-----------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpAddEditTimeShiftDetails]
(
	@TimeShiftId INT = 0,
	@TimeShift NVARCHAR(50),
	@WorkingHours INT,
	@PayingHours NUMERIC(18,2),
	@StartTime DateTime
)
AS
BEGIN
	IF @TimeShiftId = 0
		BEGIN
			INSERT INTO [dbo].[Settings_TimeShift]
			   (
				   [TimeShiftName],
				   [WorkingHours],
				   [PayingHours],
				   [ShiftStartTime]
				)
			VALUES
			   (
				   @TimeShift,
				   @WorkingHours,
				   @PayingHours,
				   @StartTime
				)
				SELECT CAST(SCOPE_IDENTITY() AS int)
		END
	ELSE
		BEGIN
			UPDATE [dbo].[Settings_TimeShift]
			SET

				TimeShiftName = @TimeShift,
				WorkingHours=@WorkingHours,
				PayingHours=@PayingHours,
				ShiftStartTime=@StartTime
			WHERE TimeShiftId = @TimeShiftId
		END	
END
