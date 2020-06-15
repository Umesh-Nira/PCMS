CREATE TABLE [dbo].[Settings_PayPalAccount] (
    [PaypalId]  INT            IDENTITY (1, 1) NOT NULL,
    [ClientId]  NVARCHAR (500) NULL,
    [SecretKey] NVARCHAR (500) NULL
);

