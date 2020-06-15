CREATE PROCEDURE [dbo].[SpDeleteConfiguration]
	(@ConfigId int)
AS
BEGIN
	
		DELETE [dbo].[Settings_EmailConfiguration]
		WHERE  ConfigId = @ConfigId
END