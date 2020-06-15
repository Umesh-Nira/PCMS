


CREATE FUNCTION [dbo].[getClientInvoiceRate] (@ClientId int, @CaretakerType int, @Date datetime)
RETURNS float
AS
BEGIN
DECLARE @Rate as float;
DECLARE @MaxDate as datetime;
		select @MaxDate = MAX(p.PayriseDate) from Client_Invoice_Rates r
		INNER JOIN [dbo].[Client_Invoice_Payrise] p on p.PayriseId = r.InvoicePayriseId
		where r.ClientId = @ClientId 
					and r.CaretakerTypeId = @CaretakerType
					and cast(p.PayriseDate as date) <= cast(@Date as date)

		SELECT @Rate = ISNULL(r.Rate,0) from Client_Invoice_Rates r
		INNER JOIN [dbo].[Client_Invoice_Payrise] p on p.PayriseId = r.InvoicePayriseId
		where r.ClientId = @ClientId 
			and r.CaretakerTypeId = @CaretakerType
			and cast(p.PayriseDate as date) = cast(@MaxDate as date)

return @Rate
END