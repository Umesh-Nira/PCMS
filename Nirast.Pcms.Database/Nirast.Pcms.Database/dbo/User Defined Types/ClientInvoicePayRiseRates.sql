CREATE TYPE [dbo].[ClientInvoicePayRiseRates] AS TABLE (
    [CategoryId]       INT             NOT NULL,
    [Rate]             NUMERIC (18, 2) NULL,
    [IsTaxApplicable]  BIT             NOT NULL,
    [ClientId]         INT             NOT NULL,
    [InvoicePayRiseId] INT             NOT NULL);

