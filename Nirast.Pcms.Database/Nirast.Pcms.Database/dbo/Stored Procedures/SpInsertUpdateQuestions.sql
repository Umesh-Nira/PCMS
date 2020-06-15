CREATE PROCEDURE [dbo].[SpInsertUpdateQuestions]
	 (@QuestionId int = 0,
	  @Questions nvarchar(50),
	  @SortOrder int)
AS
BEGIN

      --=========================================================================Questions INSERTION START=============================================================
      IF @QuestionId = 0 
      BEGIN
        INSERT INTO [dbo].Settings_Questionnaire
		(
			Question,
			QuestionOrder
		)
        VALUES
		(
		  @Questions, 
		  @SortOrder
		)

      END
      --=========================================================================Questions INSERTION END===============================================================

      --=========================================================================Questions UPDATE START================================================================

      ELSE
      BEGIN
        UPDATE [dbo].Settings_Questionnaire

        SET Question = @Questions,
			QuestionOrder = @SortOrder          
        WHERE QuestionId = @QuestionId

      END
      --=========================================================================Questions UPDATE END================================================================
END