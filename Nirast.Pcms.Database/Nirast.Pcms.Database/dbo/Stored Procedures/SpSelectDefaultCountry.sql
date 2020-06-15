CREATE PROC [dbo].[SpSelectDefaultCountry]
AS
BEGIN

	IF EXISTS (SELECT 1 from [Settings_Country] WHERE IsDefault = 1)
	BEGIN
		SELECT TOP 1
			CountryId, 
			CountryCode AS Code, 
			CountryName AS Name, 
			PhoneCode, 
			Currency, 
			ISNULL(Symbol,'$') AS CurrencySymbol
		FROM [dbo].[Settings_Country] c
		Where IsDefault = 1
	END
	ELSE
	BEGIN
		SELECT TOP 1
			CountryId, 
			CountryCode AS Code, 
			CountryName AS Name, 
			PhoneCode, 
			Currency, 
			ISNULL(Symbol,'$') AS CurrencySymbol
		FROM [dbo].[Settings_Country] c
		Where [CountryId] = 1
	END
END