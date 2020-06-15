CREATE PROCEDURE [dbo].[SpGetLastClientInvoiceRates] --'9-18-2019',  16
	-- Add the parameters for the stored procedure here
	@Payrisedate Datetime,
	@ClientId int
	
AS
BEGIN

	DECLARE @PayriseId_OUT int
	DECLARE @payriseId int
	
	DECLARE @payDate datetime

	select @payDate = MAX([PayriseDate]) from [dbo].[Client_Invoice_Payrise]  where [PayriseDate] < @Payrisedate AND [ClientId]=@ClientId
	select @payriseId = [PayriseId] from [dbo].[Client_Invoice_Payrise] where [PayriseDate]=@payDate and [ClientId]=@ClientId

	declare @lastdate int


	select 
	[ClientId],
	[CaretakerTypeId] As CategoryId,
	[Rate],
	[IsTaxApplicable]
	from [dbo].[Client_Invoice_Rates] where [InvoicePayriseId]=@payriseId --@lastdate
	
END