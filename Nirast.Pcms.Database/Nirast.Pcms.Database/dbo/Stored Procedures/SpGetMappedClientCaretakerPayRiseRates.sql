CREATE PROCEDURE [dbo].[SpGetMappedClientCaretakerPayRiseRates] 
	(
	@ClientId int
	)
AS
BEGIN

	SELECT
    Isnull([Rate],0) AS Rate,
    SC.TypeId,
	SC.TypeName
	FROM [dbo].[Caretaker_Payroll_Rates] CCM 
	RIGHT JOIN Settings_CaretakerType SC ON  CCM.ClientId=@ClientId 
END