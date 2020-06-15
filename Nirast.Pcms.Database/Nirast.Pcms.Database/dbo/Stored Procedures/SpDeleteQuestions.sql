CREATE PROCEDURE [dbo].[SpDeleteQuestions]
(
	@QuestionId int
)
AS
BEGIN
	
		DELETE [dbo].[Settings_Questionnaire]
		WHERE  QuestionId = @QuestionId
END