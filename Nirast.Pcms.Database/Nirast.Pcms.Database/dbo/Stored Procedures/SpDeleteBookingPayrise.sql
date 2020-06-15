/*a
--------------------------------------------------------------------------------------------------
Author				: SETHU
Created Date		: 17-07-2018

Last Updated BY		: 
Last Updated Date	: 

This Stored Procedure calling from:	
----------------------------------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpDeleteBookingPayrise]
(
	@BookingPayriseId int
)
AS
BEGIN
	DELETE [dbo].[Caretaker_Booking_Rates]
		WHERE  [BookingPayRiseId] = @BookingPayriseId

		DELETE [dbo].[Caretaker_Booking_Payrise]
		WHERE  [PayriseId]  = @BookingPayriseId
		
		
END