CREATE TYPE [dbo].[MappedCaretakerRates] AS TABLE (
    [WorkShiftId] INT             NOT NULL,
    [Rate]        NUMERIC (18, 2) NULL,
    [ClientId]    INT             NOT NULL,
    [CaretakerId] INT             NOT NULL);

