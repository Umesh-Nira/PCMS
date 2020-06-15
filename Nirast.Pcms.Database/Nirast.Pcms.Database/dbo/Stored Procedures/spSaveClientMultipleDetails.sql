/*
-----------------------------------------------------------------------------------
< spSaveClientMultipleDetails >

Author				: Rithik Raj
Created Date		: 18-OCT-2018
-----------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[spSaveClientMultipleDetails] 
(
	@Payrisedate Datetime,
	@ClientId INT,
	@ClientCategoryRates AS ClientCaretakerTypeDataType Readonly,
	--@ClientCaretakers AS ClientCaretakersDataType Readonly,
	@ClientShifts AS ClientShiftDataType Readonly
)
AS
BEGIN


	DECLARE @PayriseId_OUT int
	DECLARE @payriseId int

	select @payriseId=PayriseId from [dbo].[Client_Invoice_Payrise]  where Payrisedate=@Payrisedate AND [ClientId]=@ClientId
	IF (@payriseId>0)
	BEGIN
	DELETE FROM [dbo].[Client_Invoice_Rates] where [InvoicePayriseId]=@payriseId

	INSERT INTO [dbo].[Client_Invoice_Rates]
				(
				[ClientId],
				[CaretakerTypeId],
				[Rate],
				[IsTaxApplicable],	
				[InvoicePayriseId]
				)
				SELECT  @ClientId,
						[CareTakerTypeId], 
						[Rate],
						[IsTaxApplicable],
						@payriseId
				  FROM @ClientCategoryRates
	
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[Client_Invoice_Payrise]
	([PayriseDate],
     [ClientId]
	)
	values (@Payrisedate,@ClientId)
	SET @PayriseId_OUT=SCOPE_IDENTITY()
	
	
	 
	 INSERT INTO [dbo].[Client_Invoice_Rates]
				(
				[ClientId],
				[CaretakerTypeId],
				[Rate],
				[IsTaxApplicable],	
				[InvoicePayriseId]
				)
				SELECT  @ClientId,
						[CareTakerTypeId], 
						[Rate],
						[IsTaxApplicable],
						@PayriseId_OUT
				  FROM @ClientCategoryRates
				
	END
END

BEGIN

	--DELETE FROM [dbo].[Client_Caretaker_Mapping] WHERE ClientId = @ClientId
	DELETE FROM [dbo].[Client_ShiftDetails] WHERE ClientId = @ClientId
	

	--INSERT INTO [Client_Caretaker_Mapping]
	--										(
	--											[ClientId],
	--											[CaretakerUserId],
	--											[Rate]
	--										)
	--										SELECT @ClientId,
	--												[CaretakerId],
	--												[Rate]
	--										 FROM @ClientCaretakers
	BEGIN
      INSERT INTO [Client_ShiftDetails]
											(
												[ClientId],
												[ShiftId]
									
											)
											SELECT @ClientId,
													[ShiftId]

										 FROM @ClientShifts
										 END
										 END