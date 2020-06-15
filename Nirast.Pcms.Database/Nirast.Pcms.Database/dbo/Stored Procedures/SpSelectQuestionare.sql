CREATE PROCEDURE [dbo].[SpSelectQuestionare]
(
	@QuestionId int = 0
)
AS
BEGIN

	IF(@QuestionId = 0)
		SET @QuestionId = NULL

	SELECT C.QuestionId,
		   C.Question AS Questions,
		   C.QuestionOrder AS SortOrder 
	FROM [dbo].[Settings_Questionnaire] C
	WHERE QuestionId = ISNULL(@QuestionId,QuestionId)
	ORDER BY C.QuestionOrder
END