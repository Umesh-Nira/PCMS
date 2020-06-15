
CREATE PROCEDURE [dbo].[SpInsertUpdateCaretakersPayRise]--'16-Feb-2019',5
	-- Add the parameters for the stored procedure here
	@Payrisedate Datetime,
	@CaretakerId int,
	@MappedRate  AS [dbo].[CaretakerPayRiseRates] READONLY
AS
BEGIN

	DECLARE @PayriseId_OUT int
	DECLARE @payriseId int

	select @payriseId=PayriseId from [dbo].[Caretaker_Booking_Payrise] where Payrisedate=@Payrisedate AND CaretakerId=@CaretakerId
	print(@Payrisedate)
	IF (@payriseId>0)
	BEGIN
	DELETE FROM [Caretaker_Booking_Rates] where BookingPayRiseId=@payriseId

	INSERT INTO [Caretaker_Booking_Rates]
				(
				[CaretakerId],
				[PayingRate],
				[DisplayRate],
				[ServiceId],	
				[BookingPayRiseId]
				)
				SELECT  
						CaretakerId,
						PayingRate,
						DisplayRate,
						ServiceId,
						@payriseId
				FROM @MappedRate
	
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[Caretaker_Booking_Payrise]
	([Payrisedate],
     [CaretakerId]
	)
	values (@Payrisedate,@CaretakerId)
	SET @PayriseId_OUT=SCOPE_IDENTITY()
	
	
	 
	 INSERT INTO [Caretaker_Booking_Rates]
				(
				[CaretakerId],
				[PayingRate],
				[DisplayRate],
				[ServiceId],	
				[BookingPayRiseId]
				)
				SELECT  
						CaretakerId,
						PayingRate,
						DisplayRate,
						ServiceId,
						@PayriseId_OUT
				FROM @MappedRate
				
	END
	 
END