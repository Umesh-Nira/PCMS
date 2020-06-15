
CREATE PROCEDURE [dbo].[SpSelectStateDetails] 
	(@StateId INT = 0) 
AS
BEGIN
		IF(@StateId = 0)
			SET @StateId = NULL

		SELECT S.StateId, 
				s.StateCode AS Code, 
				s.StateName AS Name, 
				s.CountryId, 
				c.CountryName,
				S.TaxPercent
		FROM [dbo].[Settings_State] S
		INNER JOIN [dbo].[Settings_Country] c ON s.CountryId = c.CountryId 
		WHERE S.StateId = ISNULL(@StateId,S.StateId)
END