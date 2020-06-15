CREATE PROC [dbo].[SetDefaultConfiguration] 
(
@ConfigId INT
)
	AS
BEGIN
	UPDATE [dbo].[Settings_EmailConfiguration]
	SET IsDefault = 'false'
	WHERE ConfigId != @ConfigId
	UPDATE [dbo].[Settings_EmailConfiguration]
	SET IsDefault = 'true'
	WHERE ConfigId = @ConfigId
		END