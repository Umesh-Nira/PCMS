--[SpSelectHolidayDetails] 0,0,2,0
CREATE PROCEDURE [dbo].[SpSelectHolidayDetails]
(
	@HolidayId INT = 0, 
	@HolidayYear INT = 0,
	@CountryId INT = 0,
	@StateId INT = 0
) AS
Set NoCount ON
	Declare @SQLQuery AS NVarchar(max)
	Declare @ParamDefinition AS NVarchar(max) 

		IF(@HolidayId = 0)
				SET @HolidayId = NULL
		IF(@CountryId = 0)
				SET @CountryId = 1
		IF(@StateId = 0)
				SET @StateId = NULL

		IF(@HolidayYear = 0)
			BEGIN
				SET @HolidayYear = YEAR(GETUTCDATE())
			END
		set @SQLQuery='SELECT HolidayId, 
				HolidayName,
				HolidayDate,
				H.CountryId,
				ISNULL(S.StateId,0) as StateId,
				C.CountryName as Country,
				S.StateName as State
		FROM  [dbo].[Settings_Holidays] H
		INNER JOIN [dbo].[Settings_Country] C ON C.CountryId = H.CountryId
		LEFT JOIN [dbo].[Settings_State] S ON S.StateId = H.StateId
		WHERE HolidayId =ISNULL(@HolidayId,HolidayId) AND YEAR(HolidayDate) = @HolidayYear AND H.CountryId = @CountryId'
		IF @StateId IS NOT NULL
			BEGIN
				SET @SQLQuery = @SQLQuery + ' AND H.StateId = ISNULL(@StateId,0)'
			END
		SET @SQLQuery = @SQLQuery + ' ORDER BY HolidayDate'
		PRINT @SQLQuery
		Set @ParamDefinition = '@HolidayId INT,
							@CountryId INT,
							@StateId INT,
							@HolidayYear INT'
		Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@HolidayId,
				@CountryId,
				@StateId,
				@HolidayYear
                
    If @@ERROR <> 0
    Set NoCount OFF