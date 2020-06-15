CREATE TABLE [dbo].[Client_CaretakerType_Rate] (
    [ClientRateId]    INT             IDENTITY (1, 1) NOT NULL,
    [ClientId]        INT             NOT NULL,
    [CaretakerTypeId] INT             NOT NULL,
    [Rate]            NUMERIC (18, 2) NOT NULL,
    [IsTaxApplicable] BIT             NOT NULL,
    CONSTRAINT [PK_Client_CaretakerType_Rate] PRIMARY KEY CLUSTERED ([ClientRateId] ASC)
);



GO


GO


GO


GO


GO
