CREATE TABLE [dbo].[Caretaker_Rejected_Schedulings] (
    [RejectedId]   INT           IDENTITY (1, 1) NOT NULL,
    [CareTakerId]  INT           NULL,
    [Datetime]     DATETIME      NULL,
    [Description]  VARCHAR (100) NULL,
    [ClientId]     INT           NULL,
    [Workshift]    INT           NULL,
    [ScheduleDate] DATETIME      NULL,
    CONSTRAINT [PK_Caretaker_Rejected_Schedulings] PRIMARY KEY CLUSTERED ([RejectedId] ASC)
);



