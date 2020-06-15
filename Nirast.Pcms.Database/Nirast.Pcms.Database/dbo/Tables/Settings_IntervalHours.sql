CREATE TABLE [dbo].[Settings_IntervalHours] (
    [IntervalId]    INT        IDENTITY (1, 1) NOT NULL,
    [IntervalHours] FLOAT (53) NULL,
    CONSTRAINT [PK_Settings_IntervalHours] PRIMARY KEY CLUSTERED ([IntervalId] ASC)
);

