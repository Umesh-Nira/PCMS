CREATE PROCEDURE [dbo].[SpGetCityByStateId]
(
	@StateId INT
)
AS
BEGIN
		SELECT S.CountryId,
				CN.CountryName AS CountryName,
				S.StateId, 
				S.StateName AS StateName, 
				C.CityId, 
				C.CityName AS CityName
		FROM [dbo].[Settings_City] C
			INNER JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			INNER JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
		 WHERE C.StateId=@StateId
		 ORDER BY  C.CityName
 END