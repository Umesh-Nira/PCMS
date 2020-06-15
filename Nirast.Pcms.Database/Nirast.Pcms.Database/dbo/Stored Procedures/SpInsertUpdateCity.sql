CREATE PROCEDURE [dbo].[SpInsertUpdateCity] (@CityId int = 0,
	@StateId int,
	@Name nvarchar(30)
)
AS
BEGIN
      --=========================================================================CITY INSERTION START=============================================================
      IF @CityId = 0
      BEGIN
			INSERT INTO [dbo].[Settings_City]
			(
				StateId,
				CityName
			)
			VALUES
			  (
				  @StateId, 
				  @Name
			  )
      END
      --=========================================================================CITY INSERTION END===============================================================
      --=========================================================================CITY UPDATE START================================================================

      ELSE
      BEGIN
			UPDATE [dbo].[Settings_City]
			SET StateId = @StateId,
				CityName = @Name
			WHERE CityId = @CityId

      END
      --=========================================================================CITY UPDATE END================================================================
END