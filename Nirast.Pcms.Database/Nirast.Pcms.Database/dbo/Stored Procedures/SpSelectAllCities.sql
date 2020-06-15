CREATE PROCEDURE [dbo].[SpSelectAllCities]
(
	@Flag varchar(50),
	@Value varchar(50)
)
AS
BEGIN

	IF @Flag='*'
		BEGIN
			SELECT C.CityId,
				   CN.CountryId,
				   C.StateId,
				   C.CityName AS CityName,
				   CN.CountryName AS CountryName,
				   S.StateName AS StateName
			FROM [dbo].[Settings_City] C
			INNER JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			INNER JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			ORDER BY CN.CountryName, S.StateName, C.CityName 
		END

	ELSE IF @Flag='CityId'
		BEGIN
			SELECT C.CityId,
				   CN.CountryId,
				   C.StateId,
				   C.CityName AS CityName,
				   CN.CountryName AS CountryName,
				   S.StateName AS StateName
			FROM [dbo].[Settings_City] C
			INNER JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			INNER JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			WHERE CityId = @Value
			ORDER BY CN.CountryName, S.StateName, C.CityName 
		END
		ELSE IF @Flag='StateId'
          BEGIN
			SELECT C.CityId,
				   CN.CountryId,
				   C.StateId,
				   C.CityName AS CityName,
				   CN.CountryName AS CountryName,
				   S.StateName AS StateName
			FROM [dbo].[Settings_City] C
			INNER JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			INNER JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			WHERE C.StateId = @Value
			ORDER BY CN.CountryName, S.StateName, C.CityName 
		END
		ELSE IF @Flag='CountryId'
          BEGIN
			SELECT C.CityId,
				   CN.CountryId,
				   C.StateId,
				   C.CityName AS CityName,
				   CN.CountryName AS CountryName,
				   S.StateName AS StateName
			FROM [dbo].[Settings_City] C
			INNER JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			INNER JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			WHERE CN.CountryId = @Value
			ORDER BY CN.CountryName, S.StateName, C.CityName 
		END
	ELSE IF @Flag='Name'
		BEGIN
			SELECT C.CityId,
				   CN.CountryId,
				   C.StateId,
				   C.CityName AS CityName,
				   CN.CountryName AS CountryName,
				   S.StateName AS StateName
			FROM [dbo].[Settings_City] C
			INNER JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			INNER JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			WHERE C.CityName = @Value
			ORDER BY CN.CountryName, S.StateName, C.CityName 
		END
END