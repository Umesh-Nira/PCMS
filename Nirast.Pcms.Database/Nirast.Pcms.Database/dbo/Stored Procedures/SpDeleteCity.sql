CREATE PROCEDURE [dbo].[SpDeleteCity]
(
	@CityId int
)
AS
BEGIN
	
		DELETE [dbo].[Settings_City]
		WHERE  CityId=@CityId
END