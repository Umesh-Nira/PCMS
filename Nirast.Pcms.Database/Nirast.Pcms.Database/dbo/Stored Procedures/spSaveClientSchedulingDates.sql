
CREATE  PROCEDURE [dbo].[spSaveClientSchedulingDates]
(
	@SchedulingId INT,
	@Date datetime,
	@Hours float
)
AS
BEGIN

	

	INSERT INTO [Client_Scheduling_Dates]
											(
												SchedulingId,
												Date,
												Hours
											)
											values
											(
											@SchedulingId,
											@Date,
											@Hours
											)

		
END