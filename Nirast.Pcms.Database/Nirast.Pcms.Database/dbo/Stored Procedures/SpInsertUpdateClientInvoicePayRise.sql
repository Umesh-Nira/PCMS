CREATE PROCEDURE [dbo].[SpInsertUpdateClientInvoicePayRise]
	-- Add the parameters for the stored procedure here
	@Payrisedate Datetime,
	@ClientId int,
	@ClientInvoicePayRiseRates  AS [dbo].[ClientInvoicePayRiseRates] READONLY
AS
BEGIN

	DECLARE @PayriseId_OUT int
	DECLARE @payriseId int
	select @payriseId=[PayriseId] from [dbo].[Client_Invoice_Payrise] where [PayriseDate]=@Payrisedate AND [ClientId]=@ClientId

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
				SELECT  
						[ClientId],
						[CategoryId],
						[Rate],
						[IsTaxApplicable],
						@payriseId
				FROM @ClientInvoicePayRiseRates
	
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
				SELECT  
						[ClientId],
						[CategoryId],
						[Rate],						
						[IsTaxApplicable],
						@PayriseId_OUT
				FROM @ClientInvoicePayRiseRates
				
	END
	 
END