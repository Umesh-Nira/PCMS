CREATE TABLE [dbo].[Settings_Questionnaire] (
    [QuestionId]    INT            IDENTITY (1, 1) NOT NULL,
    [Question]      NVARCHAR (500) NOT NULL,
    [QuestionOrder] INT            NULL,
    CONSTRAINT [PK_Settings_Questionnaire] PRIMARY KEY CLUSTERED ([QuestionId] ASC),
    CONSTRAINT [Questionnaire_Unique] UNIQUE NONCLUSTERED ([Question] ASC)
);



GO

