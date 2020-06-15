


CREATE FUNCTION [dbo].[getIsTaxApplicable] (@ClientId int, @CaretakerType int)
RETURNS bit
AS
BEGIN
DECLARE @IsTaxApplicable as bit;

IF EXISTS(SELECT 1 FROM Client_Invoice_Rates r where r.ClientId = @ClientId and r.CaretakerTypeId = @CaretakerType and r.IsTaxApplicable = 1)
	set @IsTaxApplicable = 1
else
	set @IsTaxApplicable = 0

return  @IsTaxApplicable

END