CREATE TABLE [dbo].[Client_Scheduling] (
    [SchedulingId]    INT            IDENTITY (1, 1) NOT NULL,
    [ClientId]        INT            NOT NULL,
    [CaretakerUserId] INT            NOT NULL,
    [WorkShiftId]     INT            NOT NULL,
    [TimeShiftId]     INT            NULL,
    [StartDateTime]   DATETIME       NOT NULL,
    [EndDateTime]     DATETIME       NOT NULL,
    [Description]     NVARCHAR (100) NULL,
    [IsConfirmed]     BIT            CONSTRAINT [DF_Client_Scheduling_IsConfirmed] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Client_Scheduling] PRIMARY KEY CLUSTERED ([SchedulingId] ASC),
    CONSTRAINT [FK_Client_Scheduling_Client_Master] FOREIGN KEY ([ClientId]) REFERENCES [dbo].[Client_Master] ([ClientId]),
    CONSTRAINT [FK_Client_Scheduling_Settings_TimeShift] FOREIGN KEY ([TimeShiftId]) REFERENCES [dbo].[Settings_TimeShift] ([TimeShiftId]),
    CONSTRAINT [FK_Client_Scheduling_Settings_WorkShift] FOREIGN KEY ([WorkShiftId]) REFERENCES [dbo].[Settings_WorkShift] ([WorkShiftId]),
    CONSTRAINT [FK_Client_Scheduling_UserDetails_Master] FOREIGN KEY ([CaretakerUserId]) REFERENCES [dbo].[UserDetails_Master] ([UserId])
);



GO


GO


GO


GO


GO


GO


GO


GO


GO


