CREATE PROCEDURE [dbo].[SpSelectCaretakerType] 
AS
SELECT TypeName,
Color
FROM [dbo].[Settings_CaretakerType] order by TypeName ASC