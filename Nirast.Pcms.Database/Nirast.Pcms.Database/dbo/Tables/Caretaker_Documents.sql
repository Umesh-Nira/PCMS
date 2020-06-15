CREATE TABLE [dbo].[Caretaker_Documents] (
    [DocumentId]       INT             IDENTITY (1, 1) NOT NULL,
    [UserId]           INT             NOT NULL,
    [DocumentType]     INT             NOT NULL,
    [DocumentName]     NVARCHAR (100)  NOT NULL,
    [ContentType]      NVARCHAR (200)  NOT NULL,
    [DocumentContent]  VARBINARY (MAX) NULL,
    [IsSendThroughFax] BIT             CONSTRAINT [DF_Caretaker_Documents_IsSendThroughFax] DEFAULT ((0)) NOT NULL,
    [DocumentPath]     NVARCHAR (MAX)  NULL,
    CONSTRAINT [PK_Caretaker_Documents] PRIMARY KEY CLUSTERED ([DocumentId] ASC),
    CONSTRAINT [FK_Caretaker_Documents_UserDetails_Master] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserDetails_Master] ([UserId])
);



GO



GO


GO


GO