CREATE TABLE [dbo].[AuditLog_Scheduling] (
    [LogId]          INT            IDENTITY (1, 1) NOT NULL,
    [FeatureId]      INT            NOT NULL,
    [ClientId]       INT            NOT NULL,
    [UserID]         INT            NOT NULL,
    [ActionType]     VARCHAR (50)   NOT NULL,
    [MessageContent] NVARCHAR (50)  NULL,
    [OldData]        NVARCHAR (MAX) NULL,
    [NewData]        NVARCHAR (MAX) NULL,
    [UpdatedDate]    DATETIME       NOT NULL,
    [CaretakerName]  VARCHAR (50)   NULL,
    CONSTRAINT [PK_AuditLog_Scheduling] PRIMARY KEY CLUSTERED ([LogId] ASC)
);

