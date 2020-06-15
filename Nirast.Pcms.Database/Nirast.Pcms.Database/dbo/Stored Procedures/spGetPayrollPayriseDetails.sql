
CREATE PROC [dbo].[spGetPayrollPayriseDetails]
AS
BEGIN

	DECLARE @Currency VARCHAR(100)
	DECLARE @CurrencySymbol VARCHAR(10)

	IF EXISTS (SELECT 1 from [Settings_Country] WHERE IsDefault = 1)
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where IsDefault = 1
	END
	ELSE
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where [CountryId] = 1
	END
			SELECT
				  cip.PayriseId AS PayrollPayriseId,
				  cip.Payrisedate AS EffectiveFromDate,
				  cir.Rate,
				  cir.ClientId,
				  cm.ClientName,
				 cir.CaretakerId,
				 udm.FirstName+''+udm.LastName AS CaretakerName,
				 sw.WorkShiftName,
				 @Currency as Currency,
				@CurrencySymbol as CurrencySymbol
				
				
				  

				  FROM [dbo].[Caretaker_Payroll_Payrise]cip 
				   LEFT JOIN [dbo].[Caretaker_Payroll_Rates]cir on cir.PayrollPayriseId = cip.PayriseId
				   LEFT JOIN  [dbo].[Caretaker_Details]ccd on ccd.UserId = cir.CaretakerId
				    LEFT JOIN [dbo].[Client_Master]cm on cm.ClientId = cir.ClientId
					LEFT JOIN [dbo].[UserDetails_Master]udm on udm.UserId = ccd.UserId
					LEFT JOIN  [dbo].[Settings_WorkShift]sw on sw.WorkShiftId  = cir.ShiftId
				
					
					
				  
		
	
END