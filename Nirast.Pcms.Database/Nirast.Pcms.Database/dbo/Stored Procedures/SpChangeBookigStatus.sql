CREATE PROC [dbo].[SpChangeBookigStatus]
	(@UserRegnId INT, @Status SMALLINT) 
AS
BEGIN
		UPDATE [dbo].[PublicUser_Caretaker_Booking]
		SET Status = @Status , StatusModifiedDate = GETUTCDATE()
		WHERE BookingId = @UserRegnId	
END