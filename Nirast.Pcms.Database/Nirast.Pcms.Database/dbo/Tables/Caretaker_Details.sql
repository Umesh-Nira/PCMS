CREATE TABLE [dbo].[Caretaker_Details] (
    [CaretakerDetailId] INT             IDENTITY (1, 1) NOT NULL,
    [UserId]            INT             NOT NULL,
    [CaretakerTypeId]   INT             NULL,
    [ProfileId]         NVARCHAR (30)   NOT NULL,
    [CaretakerStatus]   SMALLINT        CONSTRAINT [DF_Caretaker_Details_CaretakerStatus] DEFAULT ((1)) NOT NULL,
    [TotalExperience]   NUMERIC (18, 2) CONSTRAINT [DF_Caretaker_Details_TotalExperience] DEFAULT ((0)) NOT NULL,
    [KeySkills]         NVARCHAR (MAX)  NULL,
    [AboutMe]           NVARCHAR (MAX)  NULL,
    [IsPrivate]         BIT             CONSTRAINT [DF_Caretaker_Details_IsPrivate] DEFAULT ((0)) NOT NULL,
    [SSID]              NVARCHAR (50)   NULL,
    [ConsentForm]       NVARCHAR (MAX)  NULL,
    [ConsentDocPath]    NVARCHAR (MAX)  NULL,
    CONSTRAINT [PK_Caretaker_Details] PRIMARY KEY CLUSTERED ([CaretakerDetailId] ASC),
    CONSTRAINT [FK_Caretaker_Details_Settings_CaretakerType] FOREIGN KEY ([CaretakerTypeId]) REFERENCES [dbo].[Settings_CaretakerType] ([TypeId]),
    CONSTRAINT [FK_Caretaker_Details_UserDetails_Master] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserDetails_Master] ([UserId])
);



GO



GO


GO


GO


GO

