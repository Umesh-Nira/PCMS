


CREATE FUNCTION [dbo].[getCaretakerPayingRate] (@CareTakerId int, @ServiceId int, @Date datetime)
RETURNS float
AS
BEGIN
DECLARE @Rate as float;
DECLARE @MaxDate as datetime;
		select @MaxDate = MAX(p.PayriseDate) from [dbo].[Caretaker_Booking_Rates] r
		INNER JOIN [dbo].[Caretaker_Booking_Payrise] p on p.PayriseId = r.BookingPayRiseId
		where r.CaretakerId = @CareTakerId 
					and r.ServiceId = @ServiceId
					and cast(p.PayriseDate as date) <= cast(@Date as date)

		SELECT @Rate = ISNULL(r.PayingRate,0) from [Caretaker_Booking_Rates] r
		INNER JOIN [dbo].[Caretaker_Booking_Payrise] p on p.PayriseId = r.BookingPayRiseId
		where r.CaretakerId = @CaretakerId 
			and r.ServiceId = @ServiceId
			and cast(p.PayriseDate as date) = cast(@MaxDate as date)

return @Rate
END