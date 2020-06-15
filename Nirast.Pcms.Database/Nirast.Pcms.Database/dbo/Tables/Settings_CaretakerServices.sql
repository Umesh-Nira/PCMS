CREATE TABLE [dbo].[Settings_CaretakerServices] (
    [ServiceId]          INT             IDENTITY (1, 1) NOT NULL,
    [ServiceName]        NVARCHAR (50)   NOT NULL,
    [ServicePic]         VARBINARY (MAX) NULL,
    [ServiceOrder]       INT             NULL,
    [ServiceDescription] NVARCHAR (500)  NULL,
    CONSTRAINT [PK_Settings_CaretakerServices] PRIMARY KEY CLUSTERED ([ServiceId] ASC),
    CONSTRAINT [CaretakerServices_Unique] UNIQUE NONCLUSTERED ([ServiceName] ASC),
    CONSTRAINT [IX_Settings_CaretakerServices] UNIQUE NONCLUSTERED ([ServiceOrder] ASC)
);
GO