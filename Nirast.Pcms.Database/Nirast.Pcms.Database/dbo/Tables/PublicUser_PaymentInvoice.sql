CREATE TABLE [dbo].[PublicUser_PaymentInvoice] (
    [InvoiceNo]   INT             IDENTITY (1, 1) NOT NULL,
    [BookingId]   INT             NOT NULL,
    [Amount]      NUMERIC (18, 2) NOT NULL,
    [TaxAmount]   NUMERIC (18, 2) NULL,
    [TotalAmount] NUMERIC (18, 2) NOT NULL,
    [InvoiceDate] DATETIME        NOT NULL,
    [PayStatus]   BIT             CONSTRAINT [DF_PublicUser_PaymentInvoice_PayStatus] DEFAULT ((0)) NOT NULL,
    [InvoicePath] NVARCHAR (MAX)  NULL,
    CONSTRAINT [PK_PublicUser_PaymentInvoice] PRIMARY KEY CLUSTERED ([InvoiceNo] ASC),
    CONSTRAINT [FK_PublicUser_PaymentInvoice_PublicUser_Caretaker_Booking] FOREIGN KEY ([BookingId]) REFERENCES [dbo].[PublicUser_Caretaker_Booking] ([BookingId])
);



GO


GO


GO


GO

