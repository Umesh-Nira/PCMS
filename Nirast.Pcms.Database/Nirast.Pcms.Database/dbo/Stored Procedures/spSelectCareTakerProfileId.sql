
CREATE PROCEDURE [dbo].[spSelectCareTakerProfileId] AS
BEGIN
	IF (SELECT MAX([CaretakerDetailId])FROM [dbo].[Caretaker_Details]) IS NULL
		BEGIN
			SELECT 1 AS ProfileId
		END
	ELSE
		BEGIN
			SELECT MAX([CaretakerDetailId])+1 AS ProfileId FROM [Caretaker_Details]
		END
END