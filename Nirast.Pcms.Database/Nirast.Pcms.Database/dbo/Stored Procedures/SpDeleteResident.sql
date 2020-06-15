CREATE PROCEDURE [dbo].[SpDeleteResident]
	(@ResidentId int)
AS
BEGIN
	
		DELETE [dbo].[Settings_Resident]
		WHERE  ResidentId = @ResidentId
END
