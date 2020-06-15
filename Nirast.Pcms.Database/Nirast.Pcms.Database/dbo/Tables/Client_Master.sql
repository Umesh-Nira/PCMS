CREATE TABLE [dbo].[Client_Master] (
    [ClientId]       INT            IDENTITY (1, 1) NOT NULL,
    [ClientName]     NVARCHAR (100) NOT NULL,
    [WebsiteUrl]     NVARCHAR (50)  NULL,
    [ClientStatus]   SMALLINT       DEFAULT ((1)) NOT NULL,
    [InvoicePrefix]  NVARCHAR (10)  NULL,
    [InvoiceNumber]  INT            CONSTRAINT [DF_Client_Master_InvoiceNumber] DEFAULT ((1)) NOT NULL,
    [HasMidNightCut] BIT            NULL,
    [UserId]         INT            NULL,
    CONSTRAINT [PK_Client_Master] PRIMARY KEY CLUSTERED ([ClientId] ASC)
);



GO