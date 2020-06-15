CREATE TABLE [dbo].[Client_Invoice_Payrise] (
    [PayriseId]   INT  IDENTITY (1, 1) NOT NULL,
    [PayriseDate] DATE NULL,
    [ClientId]    INT  NOT NULL,
    CONSTRAINT [PK_Client_Invoice_Payrise] PRIMARY KEY CLUSTERED ([PayriseId] ASC),
    CONSTRAINT [FK_Client_Invoice_Payrise_Client_Master] FOREIGN KEY ([ClientId]) REFERENCES [dbo].[Client_Master] ([ClientId])
);



