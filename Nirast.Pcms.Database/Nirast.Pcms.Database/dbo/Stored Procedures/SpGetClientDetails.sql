CREATE PROCEDURE [dbo].[SpGetClientDetails]
AS
BEGIN

DECLARE @Currency VARCHAR(100)
	DECLARE @CurrencySymbol VARCHAR(10)

	IF EXISTS (SELECT 1 from [Settings_Country] WHERE IsDefault = 1)
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where IsDefault = 1
	END
	ELSE
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where [CountryId] = 1
	END

    SELECT	CL.*,
			CA.BuildingName AS Address1,
			CA.Phone1 AS PhoneNo1,
			CA.CityId, 
			C.CityName AS City1, 
			S.StateName AS State1,
			CN.CountryName AS Country1,
			@Currency as Currency,
			@CurrencySymbol as CurrencySymbol
	FROM [dbo].[Client_Master] CL 
	INNER JOIN [dbo].[Client_AddressDetails] CA ON CA.ClientId = CL.ClientId AND CA.AddressId = 
																						(SELECT MIN(AddressId) 
																						FROM [Client_AddressDetails] 
																						WHERE ClientId = CL.ClientId)
	LEFT JOIN [dbo].[Settings_City] C ON CA.CityId = C.CityId 
	LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
	LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
	ORDER BY Cl.ClientName
END