CREATE TYPE [dbo].[CaretakerCategoryPayRiseRates] AS TABLE (
    [TypeId]        INT             NOT NULL,
    [Rate]          NUMERIC (18, 2) NULL,
    [EffectiveFrom] DATETIME        NOT NULL,
    [ClientId]      INT             NOT NULL);

