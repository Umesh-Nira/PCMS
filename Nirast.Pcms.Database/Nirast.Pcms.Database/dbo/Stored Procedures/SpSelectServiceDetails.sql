CREATE PROCEDURE [dbo].[SpSelectServiceDetails] 
	(@ServiceId INT)
AS
BEGIN
	IF(@ServiceId = 0)
		SET @ServiceId = NULL

	SELECT CS.ServiceId,
		CS.ServiceName AS Name,
		cs.ServiceOrder,
		cs.ServicePic As ServicePicture,
		cs.ServiceDescription AS ServiceDescription
	FROM [dbo].[Settings_CaretakerServices] CS
	WHERE CS.ServiceId =ISNULL(@ServiceId, CS.ServiceId) ORDER BY cs.ServiceOrder
END