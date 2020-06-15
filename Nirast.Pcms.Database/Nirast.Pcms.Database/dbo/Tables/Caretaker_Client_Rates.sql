CREATE TABLE [dbo].[Caretaker_Client_Rates] (
    [ClientRateId]    INT             IDENTITY (1, 1) NOT NULL,
    [ClientId]        INT             NOT NULL,
    [CaretakerUserId] INT             NOT NULL,
    [PayingRate]      NUMERIC (18, 2) NULL,
    [DisplayRate]     NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_Caretaker_Client_Rates] PRIMARY KEY CLUSTERED ([ClientRateId] ASC)
);



GO


GO


GO


