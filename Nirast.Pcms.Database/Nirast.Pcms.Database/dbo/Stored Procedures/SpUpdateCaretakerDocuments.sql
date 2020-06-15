--[SpSelectClientInvoiceDetails] null,null,null,null,null,null,1
CREATE PROCEDURE [dbo].SpUpdateCaretakerDocuments 
(
	@DocId int,
	@DocPath nvarchar(MAX)
)
AS
BEGIN
	Update [dbo].[Caretaker_Documents]
	SET [DocumentPath]=@DocPath,[DocumentContent]=null
	where [DocumentId]=@DocId
	
END