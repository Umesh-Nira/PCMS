
CREATE PROC [dbo].[SpApproveCaretaker]
	(@UserId INT,
	@Payrisedate Datetime,
	@IsPrivate BIT,
	@CaretakerServices AS [dbo].[CaretakerPayRiseRates] Readonly)
AS
BEGIN
	UPDATE [dbo].[UserDetails_Master] 
	SET 
		UserStatus = 1
	WHERE UserId = @UserId

	UPDATE [dbo].[Caretaker_Details] 
	SET CaretakerStatus = 2,
		IsPrivate = @IsPrivate 
	WHERE UserId = @UserId

	DECLARE @PayriseId_OUT int
	DECLARE @payriseId int

	select @payriseId=PayriseId from [dbo].[Caretaker_Booking_Payrise] where Payrisedate=@Payrisedate AND CaretakerId=@UserId
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
				FROM @CaretakerServices
	
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[Caretaker_Booking_Payrise]
	([Payrisedate],
     [CaretakerId]
	)
	values (@Payrisedate,@UserId)
	SET @PayriseId_OUT=SCOPE_IDENTITY()
	
END
END