CREATE PROCEDURE [dbo].[SpInsertUpdateClientCaretakersPayRise] 
	(
		@ClientId int,
		@CaretakerId int,
		@MappedRate  AS [dbo].[MappedCaretakerPayRiseRates] READONLY,
		@Payrisedate Datetime
	)
AS
BEGIN
      --========================================================================= CLIENT CARETAKER INSERTION START =============================================================
	--DELETE FROM [dbo].[Client_Caretaker_Mapping_PayRise] WHERE ClientId = @ClientId AND CaretakerUserId = @CaretakerId 

	
	DECLARE @PayriseId_OUT int
	DECLARE @payriseId int
	select @payriseId=[PayriseId] from [dbo].[Caretaker_Payroll_Payrise] where [PayriseDate]=@Payrisedate AND CaretakerId=@CaretakerId AND [ClientId] =@ClientId

	IF (@payriseId>0)
	BEGIN
	DELETE FROM [dbo].[Caretaker_Payroll_Rates] where PayrollPayriseId=@payriseId

	INSERT INTO [dbo].[Caretaker_Payroll_Rates]
				(
				[ClientId],
				ShiftId,
				[Rate],
				[CaretakerId],
				PayrollPayriseId,
				[MapStatus]
				)
				SELECT  
						[ClientId],
						[WorkShiftId],
						[Rate],
						[CaretakerId],
						@payriseId,
						[MapStatus]
				FROM @MappedRate
	
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[Caretaker_Payroll_Payrise]
	([PayriseDate],
    CaretakerId,
	[ClientId]
	)
	values (@Payrisedate,@CaretakerId,@ClientId)
	SET @PayriseId_OUT=SCOPE_IDENTITY()
	
	
	 
	 INSERT INTO [dbo].[Caretaker_Payroll_Rates]
				(
				[ClientId],
				ShiftId,
				[Rate],
				[CaretakerId],
				PayrollPayriseId,
				[MapStatus]
				)
				SELECT  
						[ClientId],
						[WorkShiftId],
						[Rate],
						[CaretakerId],
						@PayriseId_OUT,
						[MapStatus]
				FROM @MappedRate
				
	END
	 
	END