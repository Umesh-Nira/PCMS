CREATE PROCEDURE [dbo].[SpGetSchedulingLogDetailsById]
(@LogId int)
AS
BEGIN
SELECT		ALS.FeatureId,
			ALS.ClientId,
			ALS.UserID,
			ALS.ActionType,
			ALS.MessageContent,
			ALS.OldData,
			ALS.NewData,
			ALS.UpdatedDate,
			UM.FirstName,
			UM.LastName,
			CM.ClientName
			
--
				
			FROM [dbo].[AuditLog_Scheduling] ALS
			INNER JOIN [dbo].[UserDetails_Master] UM ON ALS.UserId = UM.UserId
			INNER JOIN [dbo].[Client_Master] CM ON ALS.ClientId = CM.ClientId
			WHERE LogId=@LogId 

END