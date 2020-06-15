
CREATE PROC [dbo].[spGetInvoicePayriseDetails]
AS
BEGIN
DECLARE @Currency VARCHAR(100)
	DECLARE @CurrencySymbol VARCHAR(10)

	IF EXISTS (SELECT 1 from [Settings_Country] WHERE IsDefault = 1)
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where IsDefault = 1
	END
	ELSE
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where [CountryId] = 1
	END
			SELECT
				  cip.PayriseId AS InvoicePayriseId,
				  cip.Payrisedate AS EffectiveFromDate,
				  cir.Rate,
				  cir.ClientId,
				  cd.ClientName,
				  sct.TypeName  AS CategoryName,
				 @Currency as Currency,
					@CurrencySymbol as CurrencySymbol
				
				  

				  FROM [dbo].[Client_Invoice_Payrise] cip 
				   LEFT JOIN  [dbo].[Client_Invoice_Rates]cir on cir.InvoicePayriseId = cip.PayriseId
				    LEFT JOIN [dbo].[Client_Master] cd on cd.ClientId = cir.ClientId
					    LEFT JOIN 	[dbo].[Settings_CaretakerType] sct on sct.[TypeId] = cir.CaretakerTypeId
				
					
					

	
END