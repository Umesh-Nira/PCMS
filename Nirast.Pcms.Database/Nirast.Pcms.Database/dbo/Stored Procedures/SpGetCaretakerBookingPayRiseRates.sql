CREATE PROCEDURE [dbo].[SpGetCaretakerBookingPayRiseRates]
	(
		@CaretakerId int
	)
AS
BEGIN

declare @payRiseId int
declare @payRiseDate datetime

	SELECT @payRiseId =  [PayriseId],
			@payRiseDate = [Payrisedate]
	FROM [dbo].[Caretaker_Booking_Payrise]
	WHERE [CaretakerId] = @CaretakerId
	and [Payrisedate] = (select MAX([Payrisedate]) from [Caretaker_Booking_Payrise] where [CaretakerId] = @CaretakerId)
	SELECT
	r.BookingRateId As PayRiseId,
		Isnull([PayingRate],0) AS PayingRate,
		Isnull([DisplayRate],0) AS DisplayRate,
		s.ServiceId,
		s.ServiceName,
		CaretakerId=@CaretakerId,
		EffectiveFrom=@payRiseDate
	FROM [dbo].Settings_CaretakerServices s
	LEFT JOIN [dbo].[Caretaker_Booking_Rates]r on s.ServiceId = r.ServiceId and CaretakerId =@CaretakerId
		And BookingPayRiseId = @payRiseId order by s.ServiceName
	
	
END