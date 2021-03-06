﻿CREATE PROCEDURE [dbo].[SpGetClientInvoicePayRiseRatesonDateChange]
	(
		@ClientId int,
		@date date
	)
AS
BEGIN

declare @payRiseId int
declare @payRiseDate datetime


	SELECT @payRiseId =  [PayriseId],
			@payRiseDate = [PayriseDate]
	FROM [dbo].[Client_Invoice_Payrise]
	WHERE [ClientId] = @ClientId
	and [PayriseDate] = @date

	SELECT
		Isnull([Rate],0) AS Rate,
		cp.TypeId as CategoryId,
		cp.[TypeName] as CategoryName,
		@payRiseDate as EffectiveFrom,
		@ClientId as ClientId,
		[IsTaxApplicable]
	FROM [dbo].[Settings_CaretakerType] cp
	Left JOIN [dbo].[Client_Invoice_Rates] cir  on cp.[TypeId] = cir.[CaretakerTypeId] and [InvoicePayriseId] = @payRiseId and [ClientId] = @ClientId order by CategoryName
	
	
END