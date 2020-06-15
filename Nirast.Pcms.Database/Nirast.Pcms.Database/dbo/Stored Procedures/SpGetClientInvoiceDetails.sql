
CREATE PROCEDURE [dbo].[SpGetClientInvoiceDetails]
		
AS
BEGIN

	SELECT  ClientId,ClientName,InvoicePrefix,InvoiceNumber
	FROM [dbo].[Client_Master]
END