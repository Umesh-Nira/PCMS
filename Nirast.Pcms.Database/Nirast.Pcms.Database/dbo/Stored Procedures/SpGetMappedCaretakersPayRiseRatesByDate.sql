--[SpGetMappedCaretakersPayRiseRatesByDate] 14,103,'2019-08-07 00:00:00.000'
CREATE PROCEDURE [dbo].[SpGetMappedCaretakersPayRiseRatesByDate] 
	(
	@ClientId int,
	@CaretakerId int,
	@Date datetime
	)
AS
BEGIN

	DECLARE @payriseId int

	SELECT @payriseId=[PayriseId] from [dbo].[Caretaker_Payroll_Payrise] WHERE [CaretakerId]=@CaretakerId AND [ClientId]=@ClientId AND [PayriseDate]=@date

	SELECT
    Isnull([Rate],0) AS Rate,
    cpr.[ShiftId] AS WorkShiftId,
	SW.WorkShiftName,
	cpr.[MapStatus] AS MapStatus,
	cpp.[PayriseDate] AS EffectiveFrom
	FROM [dbo].[Caretaker_Payroll_Rates]cpr
	RIGHT JOIN Settings_WorkShift SW ON SW.WorkShiftId = cpr.ShiftId 
	INNER JOIN [dbo].[Caretaker_Payroll_Payrise]cpp ON cpr.[PayrollPayriseId] = cpp.[PayriseId] 
	WHERE cpp.[PayriseId]=@payriseId
	END