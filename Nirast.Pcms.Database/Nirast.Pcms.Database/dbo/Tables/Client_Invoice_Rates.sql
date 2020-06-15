CREATE TABLE [dbo].[Client_Invoice_Rates] (
    [InvoiceRateId]    INT             IDENTITY (1, 1) NOT NULL,
    [ClientId]         INT             NOT NULL,
    [CaretakerTypeId]  INT             NOT NULL,
    [Rate]             NUMERIC (18, 2) NOT NULL,
    [IsTaxApplicable]  BIT             NULL,
    [InvoicePayriseId] INT             NOT NULL,
    CONSTRAINT [PK_Client_Invoice_Rates2] PRIMARY KEY CLUSTERED ([InvoiceRateId] ASC),
    CONSTRAINT [FK_Client_Invoice_Rates_Client_Invoice_Payrise] FOREIGN KEY ([InvoicePayriseId]) REFERENCES [dbo].[Client_Invoice_Payrise] ([PayriseId]),
    CONSTRAINT [FK_Client_Invoice_Rates_Client_Master] FOREIGN KEY ([ClientId]) REFERENCES [dbo].[Client_Master] ([ClientId]),
    CONSTRAINT [FK_Client_Invoice_Rates_Settings_CaretakerType] FOREIGN KEY ([CaretakerTypeId]) REFERENCES [dbo].[Settings_CaretakerType] ([TypeId])
);



GO


GO


GO


GO


GO


GO

