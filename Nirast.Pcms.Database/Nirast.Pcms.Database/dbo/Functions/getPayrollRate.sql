


CREATE FUNCTION [dbo].[getPayrollRate] (@ClientId int, @CaretakerId int, @ShiftId int, @Date datetime)
RETURNS float
AS
BEGIN
DECLARE @Rate as float;
DECLARE @MaxDate as datetime;
		select @MaxDate = MAX(p.PayriseDate) from [dbo].[Caretaker_Payroll_Rates] r
			INNER JOIN [dbo].[Caretaker_Payroll_Payrise] p on p.PayriseId = r.PayrollPayriseId
		where r.ClientId = @ClientId 
					and r.CaretakerId = @CaretakerId
					and r.ShiftId = @ShiftId
					and cast(p.PayriseDate as date) <= cast(@Date as date)

		SELECT @Rate = ISNULL(r.Rate,0) from [Caretaker_Payroll_Rates] r
		INNER JOIN [dbo].[Caretaker_Payroll_Payrise] p on p.PayriseId = r.PayrollPayriseId
		where r.ClientId = @ClientId 
			and r.CaretakerId = @CaretakerId
			and r.ShiftId = @ShiftId
			and cast(p.PayriseDate as date) = cast(@MaxDate as date)

return @Rate
END