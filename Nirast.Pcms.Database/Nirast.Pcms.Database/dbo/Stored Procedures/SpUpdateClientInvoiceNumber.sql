Create PROCEDURE [dbo].[SpUpdateClientInvoiceNumber] 
(
	 @ClientId int,
	 @InvoiceNumber int
	)
AS
BEGIN
	UPDATE [dbo].[Client_Master]
	SET InvoiceNumber = @InvoiceNumber 
	WHERE ClientId = @ClientId
 END