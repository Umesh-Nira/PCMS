CREATE PROCEDURE [dbo].[SpDeleteQualification]
(
	@QualificationId int
)
AS
BEGIN
	
		DELETE [dbo].Settings_Qualifications
		WHERE  QualificationId=@QualificationId
END