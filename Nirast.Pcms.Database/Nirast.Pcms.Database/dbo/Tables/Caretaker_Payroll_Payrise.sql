CREATE TABLE [dbo].[Caretaker_Payroll_Payrise] (
    [PayriseId]   INT      IDENTITY (1, 1) NOT NULL,
    [PayriseDate] DATETIME NOT NULL,
    [CaretakerId] INT      NOT NULL,
    [ClientId]    INT      NOT NULL,
    CONSTRAINT [PK_Caretaker_Payroll_Payrise] PRIMARY KEY CLUSTERED ([PayriseId] ASC),
    CONSTRAINT [FK_Caretaker_Payroll_Payrise_UserDetails_Master] FOREIGN KEY ([CaretakerId]) REFERENCES [dbo].[UserDetails_Master] ([UserId])
);


