--[SpSelectClientInvoiceDetails] null,null,null,null,null,null,1
CREATE PROCEDURE [dbo].SpUpdateClientInvoice 
(
	@ClientId int,
	@InvoiceId int,
	@PdfFilePath nvarchar(MAX)
)
AS
BEGIN
	Update [dbo].[Client_Invoice_Details]
	SET PdfFilePath=@PdfFilePath,PdfFile=null
	where [ClientId]=@ClientId and [InvoiceSearchInputId]=@InvoiceId
	
END