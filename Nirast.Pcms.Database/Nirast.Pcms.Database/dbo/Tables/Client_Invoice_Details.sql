CREATE TABLE [dbo].[Client_Invoice_Details] (
    [InvoiceSearchInputId] INT             IDENTITY (1, 1) NOT NULL,
    [InvoiceNumber]        INT             NULL,
    [InvoicePrefix]        NVARCHAR (500)  NULL,
    [ClientId]             INT             NULL,
    [StartDate]            DATE            NULL,
    [EndDate]              DATE            NULL,
    [Mode]                 INT             NULL,
    [Seperateinvoice]      BIT             NULL,
    [Description]          NVARCHAR (500)  NULL,
    [PdfFile]              VARBINARY (MAX) NULL,
    [Year]                 INT             NULL,
    [Month]                INT             NULL,
    [InvoiceDate]          DATE            NULL,
    [Category]             NVARCHAR (50)   NULL,
    [PdfFilePath]          NVARCHAR (MAX)  NULL,
    CONSTRAINT [PK_Client_Invoice_Details] PRIMARY KEY CLUSTERED ([InvoiceSearchInputId] ASC)
);







