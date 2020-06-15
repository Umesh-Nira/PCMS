CREATE TYPE [dbo].[CaretakerDocumentDataType] AS TABLE (
    [DocumentTypeId]  INT             NULL,
    [DocumentName]    NVARCHAR (100)  NULL,
    [ContentType]     NVARCHAR (200)  NULL,
    [DocumentContent] VARBINARY (MAX) NULL,
    [DocumentPath]    NVARCHAR (MAX)  NULL,
    [CareTakerUserId] INT             NULL);


GO
