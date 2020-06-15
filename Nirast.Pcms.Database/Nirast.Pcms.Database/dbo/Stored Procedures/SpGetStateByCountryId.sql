CREATE PROCEDURE [dbo].[SpGetStateByCountryId]
(
	@CountryId int
)
AS
BEGIN
	if @CountryId > 0
		BEGIN
			SELECT C.CountryId,
					 C.CountryName, 
					 S.StateId, 
					 S.StateCode As Code,
					 S.StateName AS Name,
					 C.Currency,
					 c.PhoneCode,
					 c.Symbol,
					 s.TaxPercent
			FROM  [dbo].[Settings_State] S 
				  INNER JOIN [dbo].[Settings_Country] C ON C.CountryId =  S.CountryId
			WHERE S.CountryId = @CountryId
			ORDER BY S.StateName
		END
	else
		BEGIN
			SELECT C.CountryId,
					C.CountryName, 
					S.StateId, 
					S.StateCode As Code,
					S.StateName AS Name,
					C.Currency,
					c.PhoneCode,
					c.Symbol,
					s.TaxPercent
			FROM  [dbo].[Settings_State] S 
				  INNER JOIN [dbo].[Settings_Country] C ON C.CountryId =  S.CountryId
			ORDER BY S.StateName
		END
END