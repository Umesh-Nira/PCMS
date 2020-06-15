-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SpInsertUpdatePublicUserInvoice] 
(
@InvoiceNo int,
@InvoicePath nvarchar(MAX)
)
AS
 BEGIN
		UPDATE [dbo].[PublicUser_PaymentInvoice]
		SET InvoicePath = @InvoicePath
		WHERE InvoiceNo = @InvoiceNo
END