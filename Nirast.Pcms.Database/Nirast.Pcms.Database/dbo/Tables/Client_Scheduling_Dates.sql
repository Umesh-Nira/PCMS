CREATE TABLE [dbo].[Client_Scheduling_Dates] (
    [SchedulingDateId] INT        IDENTITY (1, 1) NOT NULL,
    [SchedulingId]     INT        NOT NULL,
    [Date]             DATETIME   NOT NULL,
    [Hours]            FLOAT (53) NOT NULL,
    CONSTRAINT [PK_Client_Scheduling_Dates] PRIMARY KEY CLUSTERED ([SchedulingDateId] ASC),
    CONSTRAINT [FK_Client_Scheduling_Dates_Client_Scheduling] FOREIGN KEY ([SchedulingId]) REFERENCES [dbo].[Client_Scheduling] ([SchedulingId])
);



GO


GO


GO