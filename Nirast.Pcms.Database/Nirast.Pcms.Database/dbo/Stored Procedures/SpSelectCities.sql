CREATE PROCEDURE [dbo].[SpSelectCities]
(
	@CountryId INT = 0, 
	@StateId INT = 0
) AS
Set NoCount ON
	Declare @SQLQuery AS NVarchar(max)
	Declare @ParamDefinition AS NVarchar(max) 

		IF(@CountryId = 0)
				SET @CountryId = NULL
		IF(@StateId = 0)
				SET @StateId = NULL

		set @SQLQuery='SELECT C.CityId,
				   CN.CountryId,
				   C.StateId,
				   C.CityName AS CityName,
				   CN.CountryName AS CountryName,
				   S.StateName AS StateName
			FROM [dbo].[Settings_City] C
			INNER JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			INNER JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
		WHERE (1=1)'
		IF @CountryId IS NOT NULL
			BEGIN
				SET @SQLQuery = @SQLQuery + ' AND CN.CountryId = ISNULL(@CountryId,0)'
			END
		IF @StateId IS NOT NULL
			BEGIN
				SET @SQLQuery = @SQLQuery + ' AND S.StateId = ISNULL(@StateId,0)'
			END
		SET @SQLQuery = @SQLQuery + ' ORDER BY CN.CountryName, S.StateName, C.CityName '
		PRINT @SQLQuery
		Set @ParamDefinition = '@CountryId INT,
							@StateId INT'
		Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@CountryId,
				@StateId
                
    If @@ERROR <> 0
    Set NoCount OFF