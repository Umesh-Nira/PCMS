CREATE PROCEDURE [dbo].[SpSelectCaretakerServices]
	(
		@CaretakerUserId int
	)
AS
BEGIN

		DECLARE @payRiseId int
			DECLARE @payRiseDate datetime
			DECLARE @maxDate datetime

			SELECT  @maxDate=MAX([Payrisedate]) FROM [Caretaker_Booking_Payrise] WHERE Payrisedate<=(SELECT GETDATE()) AND  [CaretakerId] =@CaretakerUserId	
			IF @maxDate IS NULL
			begin
			SELECT TOP 1 @payRiseId=[PayriseId],@payRiseDate = [Payrisedate] FROM [Caretaker_Booking_Payrise] WHERE Payrisedate IS NULL  AND  [CaretakerId] =@CaretakerUserId	
			END
			ELSE
			begin
			SELECT top 1 @payRiseId=[PayriseId],@payRiseDate = [Payrisedate] FROM [Caretaker_Booking_Payrise] WHERE Payrisedate = @maxDate  AND  [CaretakerId] =@CaretakerUserId			
			END

			SELECT
			r.BookingRateId AS PayRiseId,
			Isnull([PayingRate],0) AS PayingRate,
			Isnull([DisplayRate],0) AS DisplayRate,
			s.ServiceId,
			s.ServiceName,
			CaretakerId=@CaretakerUserId,
			EffectiveFROM=@payRiseDate
			FROM [dbo].Settings_CaretakerServices s
			INNER JOIN [dbo].[Caretaker_Booking_Rates]r on s.ServiceId = r.ServiceId AND CaretakerId =@CaretakerUserId		AND BookingPayRiseId = @payRiseId 
	
	
END