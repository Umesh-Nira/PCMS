 CREATE PROCEDURE [dbo].[SpSelectQualification]
(
	@QualificationId int
)
AS
BEGIN
	IF(@QualificationId = 0)
		SET @QualificationId = NULL
			
	SELECT Q.QualificationId,
			Q.QualificationName AS Qualification
	FROM dbo.Settings_Qualifications Q
	WHERE QualificationId =ISNULL(@QualificationId,QualificationId)
	ORDER BY Q.QualificationName 
END