CREATE PROCEDURE [dbo].[SpGetScheduleLogDetails]
AS
BEGIN
SELECT		
			ALS.LogId,
			ALS.UserID,
			ALS.ActionType AS AuditLogActionType,
			ALS.MessageContent,
			ALS.OldData,
			ALS.NewData,
			ALS.UpdatedDate,
			UM.FirstName,
			UM.LastName,
			CM.ClientName,
			ALS.CaretakerName 

				
			FROM [dbo].[AuditLog_Scheduling] ALS
			INNER JOIN [dbo].[UserDetails_Master] UM ON ALS.UserId = UM.UserId
			INNER JOIN [dbo].[Client_Master] CM ON CM.ClientId = ALS.ClientId
			ORDER BY UpdatedDate  desc

END