CREATE PROCEDURE [dbo].spGetAllCaretakerDocuments
AS
BEGIN
	
			SELECT [DocumentId] as CaretakerDocumentId,[DocumentContent] as DocumentContent,[DocumentName]
			FROM [dbo].[Caretaker_Documents]
END