
--[SpGetMappedCaretakerPayRiseRates]  11,103

CREATE PROCEDURE [dbo].[SpGetMappedCaretakerPayRiseRates]
	(
	@ClientId int,
	@CaretakerId int
	)
AS
BEGIN

declare @payRiseId int
declare @payRiseDate datetime

	SELECT @payRiseId =  [PayriseId],
			@payRiseDate = PayriseDate
	FROM [dbo].[Caretaker_Payroll_Payrise]
	WHERE CaretakerId= @CaretakerId
	and [PayriseDate] = (select MAX([PayriseDate]) from  [dbo].[Caretaker_Payroll_Payrise] where CaretakerId = @CaretakerId and ClientId =@ClientId)

	SELECT @payRiseId as PayriseId, @payRiseDate as EffectiveFrom,@ClientId as ClientId

	SELECT
		Isnull(cpr.[Rate],0) AS Rate,
		wp.WorkShiftId AS WorkShiftId,
		cpr.CaretakerId,
		wp.WorkShiftName
		FROM [dbo].[Settings_WorkShift] wp
	--FROM [dbo].[Caretaker_Payroll_Rates] cpr 
	LEFT JOIN [dbo].[Caretaker_Payroll_Rates] cpr on wp.WorkShiftId = cpr.ShiftId
		AND [ClientId] = @ClientId and PayrollPayriseId = @payRiseId
	
END