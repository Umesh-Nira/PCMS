CREATE PROC [dbo].[spGetDefaultConfiguration] 

	AS
BEGIN
	SELECT * FROM [dbo].[Settings_EmailConfiguration]
    WHERE IsDefault = 'true'
		END