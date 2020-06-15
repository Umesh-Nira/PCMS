CREATE PROCEDURE [dbo].[SpModifyClientStatusById] 
(
	 @ClientId int,
	 @status int
	)
AS
BEGIN
	UPDATE [dbo].[Client_Master]
	SET ClientStatus = @status 
	WHERE ClientId = @ClientId
 END
