CREATE TABLE [dbo].[Settings_WorkShift] (
    [WorkShiftId]       INT           IDENTITY (1, 1) NOT NULL,
    [WorkShiftName]     NVARCHAR (50) NOT NULL,
    [ShowResidentName]  BIT           NULL,
    [IsSeparateInvoice] BIT           NULL,
    CONSTRAINT [PK_Settings_WorkShift] PRIMARY KEY CLUSTERED ([WorkShiftId] ASC),
    CONSTRAINT [WorkShift_Unique] UNIQUE NONCLUSTERED ([WorkShiftName] ASC)
);



GO