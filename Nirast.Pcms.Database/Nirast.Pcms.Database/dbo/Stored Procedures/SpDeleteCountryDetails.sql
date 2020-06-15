CREATE PROCEDURE [dbo].[SpDeleteCountryDetails] (@CountryId INT) AS
BEGIN
	DELETE FROM [dbo].[Settings_Country]
		WHERE CountryId = @CountryId
END