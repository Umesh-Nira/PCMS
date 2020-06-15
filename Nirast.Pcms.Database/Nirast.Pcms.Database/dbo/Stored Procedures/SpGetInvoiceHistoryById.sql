CREATE PROCEDURE [dbo].[SpGetInvoiceHistoryById] 
(
	@InvId int
)
AS
BEGIN
	SELECT 
			cid.InvoiceSearchInputId,
			cid.InvoiceDate,  
			cid.InvoicePrefix AS InvoicePrefix,
			cid.ClientId AS ClientId,
			cm.ClientName AS ClientName,
			L.EmailId AS ClientEmail,
			cid.StartDate AS StartDate,
			cid.EndDate AS EndDate,
			cid.Mode AS Mode, 
			cid.Year,
			cid.Month,
			cid.Seperateinvoice AS Seperateinvoice,
			cid.Description AS Description,
			cid.PdfFilePath AS PdfFilePAth,
			cid.Year AS Year,
			cid.Month AS Month
			FROM
			[dbo].[Client_Invoice_Details] cid
			INNER JOIN [dbo].[Client_Master] cm on cm.[ClientId] = cid.ClientId
			LEFT JOIN [dbo].[User_LoginDetails] L ON L.UserId = cm.UserId
			WHERE cid.InvoiceSearchInputId = @InvId  
END