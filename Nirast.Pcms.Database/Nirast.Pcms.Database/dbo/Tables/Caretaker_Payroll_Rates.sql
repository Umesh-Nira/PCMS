CREATE TABLE [dbo].[Caretaker_Payroll_Rates] (
    [PayrollRateId]    INT        IDENTITY (1, 1) NOT NULL,
    [ClientId]         INT        NOT NULL,
    [CaretakerId]      INT        NOT NULL,
    [Rate]             FLOAT (53) NOT NULL,
    [ShiftId]          INT        NOT NULL,
    [PayrollPayriseId] INT        NOT NULL,
    [MapStatus]        INT        NOT NULL,
    CONSTRAINT [PK_Caretaker_Payroll_Rates] PRIMARY KEY CLUSTERED ([PayrollRateId] ASC),
    CONSTRAINT [FK_Caretaker_Payroll_Rates_Caretaker_Payroll_Payrise] FOREIGN KEY ([PayrollPayriseId]) REFERENCES [dbo].[Caretaker_Payroll_Payrise] ([PayriseId]),
    CONSTRAINT [FK_Caretaker_Payroll_Rates_Client_Master] FOREIGN KEY ([ClientId]) REFERENCES [dbo].[Client_Master] ([ClientId]),
    CONSTRAINT [FK_Caretaker_Payroll_Rates_UserDetails_Master] FOREIGN KEY ([CaretakerId]) REFERENCES [dbo].[UserDetails_Master] ([UserId])
);



GO


GO


GO


GO


GO


GO


GO