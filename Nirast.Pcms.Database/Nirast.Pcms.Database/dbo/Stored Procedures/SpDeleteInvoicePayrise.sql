/*a
--------------------------------------------------------------------------------------------------
Author				: SETHU
Created Date		: 17-07-2018

Last Updated BY		: 
Last Updated Date	: 

This Stored Procedure calling from:	
----------------------------------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpDeleteInvoicePayrise]
(
	@InvoicePayriseId int
)
AS
BEGIN
		DELETE [dbo].[Client_Invoice_Rates]
		WHERE  [InvoicePayriseId] = @InvoicePayriseId
			DELETE [dbo].[Client_Invoice_Payrise]
		WHERE [PayriseId]   = @InvoicePayriseId
END