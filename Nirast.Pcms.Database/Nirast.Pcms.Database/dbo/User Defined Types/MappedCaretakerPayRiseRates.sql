CREATE TYPE [dbo].[MappedCaretakerPayRiseRates] AS TABLE (
    [WorkShiftId]      INT             NOT NULL,
    [Rate]             NUMERIC (18, 2) NULL,
    [ClientId]         INT             NOT NULL,
    [MapStatus]        INT             NOT NULL,
    [CaretakerId]      INT             NOT NULL,
    [PayrollPayriseId] INT             NOT NULL);

