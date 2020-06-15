CREATE PROC [dbo].[SpConfirmAppointments]
	(
	@Id INT,
	@Type INT
	) 
AS
BEGIN
        IF @Type = 1
		BEGIN
		UPDATE [dbo].[PublicUser_Caretaker_Booking]
		SET IsConfirmed = 'true'
		WHERE BookingId = @Id
		END
       ELSE IF @Type = 2
	   BEGIN
		UPDATE [dbo].[Client_Scheduling]
		SET IsConfirmed = 'true'
		WHERE SchedulingId = @Id
		END
END
