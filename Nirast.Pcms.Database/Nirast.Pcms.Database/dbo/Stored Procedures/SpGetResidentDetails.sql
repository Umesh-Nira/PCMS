CREATE PROCEDURE [dbo].[SpGetResidentDetails] 

AS

BEGIN
SELECT             R.ResidentId,
				   R.ClientId,
			       R.ResidentName,
				   CM.ClientName,
				   R.OtherInfo

			FROM [dbo].[Settings_Resident] R
			LEFT JOIN Dbo.Client_Master CM ON R.ClientId = CM.ClientId
			
			--WHERE R.ClientId = ClientId
			ORDER BY ResidentName

END
