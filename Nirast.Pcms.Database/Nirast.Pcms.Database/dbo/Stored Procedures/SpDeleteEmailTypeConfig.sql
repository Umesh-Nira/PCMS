CREATE PROCEDURE [dbo].[SpDeleteEmailTypeConfig]
	(@ConfigId int)
AS
BEGIN
	
		DELETE [dbo].[Settings_EmailTypeConfiguration]
		WHERE  ConfigId = @ConfigId
END