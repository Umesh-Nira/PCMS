CREATE TABLE [dbo].[Settings_TimeShift] (
    [TimeShiftId]    INT             IDENTITY (1, 1) NOT NULL,
    [TimeShiftName]  NVARCHAR (50)   NOT NULL,
    [ShiftStartTime] DATETIME        NOT NULL,
    [WorkingHours]   INT             NOT NULL,
    [PayingHours]    NUMERIC (18, 2) NOT NULL,
    CONSTRAINT [PK_Settings_TimeShift] PRIMARY KEY CLUSTERED ([TimeShiftId] ASC),
    CONSTRAINT [TimeShift_Unique] UNIQUE NONCLUSTERED ([TimeShiftName] ASC)
);

