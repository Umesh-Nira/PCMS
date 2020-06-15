Create PROCEDURE [dbo].[SpDeletePublicUserBookingDates] 
(@BookingId int)
AS
BEGIN

	DELETE FROM [dbo].[PublicUser_Booking_Dates] WHERE BookingId=@BookingId
END