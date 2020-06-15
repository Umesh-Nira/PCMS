CREATE TYPE [dbo].[CaretakerPayRiseRates] AS TABLE (
    [ServiceId]        INT             NOT NULL,
    [PayingRate]       NUMERIC (18, 2) NULL,
    [DisplayRate]      NUMERIC (18, 2) NULL,
    [CaretakerId]      INT             NOT NULL,
    [BookingPayRiseId] INT             NOT NULL);

