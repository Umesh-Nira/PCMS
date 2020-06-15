CREATE PROCEDURE [dbo].[SpDeleteStateDetails] 
	(@StateId INT) AS
BEGIN
		DELETE FROM [dbo].[Settings_State]
		WHERE StateId = @StateId
END