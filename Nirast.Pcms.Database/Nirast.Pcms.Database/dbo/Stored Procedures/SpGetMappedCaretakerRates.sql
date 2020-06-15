--  [dbo].[SpGetMappedCaretakerRates] 14,103
CREATE PROCEDURE [dbo].[SpGetMappedCaretakerRates]
	(
	@ClientId int,
	@CaretakerId int
	)
AS
BEGIN

	DECLARE @LatestDate date
	DECLARE @payriseId int
	SELECT @LatestDate = MAX([PayriseDate]) FROM [dbo].[Caretaker_Payroll_Payrise] WHERE [CaretakerId]=@CaretakerId AND [ClientId]=@ClientId AND [PayriseDate]<= GETDATE()

	SELECT @payriseId = [PayriseId] from [dbo].[Caretaker_Payroll_Payrise] where [PayriseDate]=@LatestDate AND [CaretakerId]=@CaretakerId

	SELECT
    Isnull([Rate],0) AS Rate,
    cpr.[ShiftId] AS WorkShiftId,
	SW.WorkShiftName,
	cpr.[MapStatus] AS MapStatus,
	cpp.[PayriseDate] AS EffectiveFrom
	FROM [dbo].[Caretaker_Payroll_Rates]cpr
	RIGHT JOIN Settings_WorkShift SW ON SW.WorkShiftId = cpr.ShiftId 
	INNER JOIN [dbo].[Caretaker_Payroll_Payrise]cpp ON cpr.[PayrollPayriseId] = cpp.[PayriseId] AND cpr.ClientId=@ClientId AND cpr.[CaretakerId]=@CaretakerId
	WHERE cpp.[PayriseId]=@payriseId
END