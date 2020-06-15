--SpSelectCountryDetails 0
CREATE PROCEDURE [dbo].[SpSelectCountryDetails] 
	(@CountryId INT = 0) AS
BEGIN
	IF(@CountryId = 0)
		SET @CountryId = NULL	
	
	SELECT CountryId, 
			CountryCode AS Code, 
			CountryName AS Name, 
			PhoneCode, 
			Currency, 
			Symbol AS CurrencySymbol,
			ISNULL(IsDefault,0) as IsDefault
	FROM  [dbo].[Settings_Country]
	WHERE CountryId =ISNULL( @CountryId,CountryId)
	ORDER BY CountryName

END