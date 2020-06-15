
Create  PROCEDURE [dbo].[spSavePublicUserBookingDates]
(
	@BookingId INT,
	@Date datetime,
	@Hours float
)
AS
BEGIN

	

	INSERT INTO [dbo].[PublicUser_Booking_Dates]
											(
												BookingId,
												Date,
												Hours
											)
											values
											(
											@BookingId,
											@Date,
											@Hours
											)

		
END