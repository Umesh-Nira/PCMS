CREATE PROCEDURE [dbo].[SpInsertUpdateQualification] 
	(@QualificationId int = 0,
	@Qualification nvarchar(50))
AS
BEGIN

      --=========================================================================QUALIFICATION INSERTION START=============================================================
      IF @QualificationId = 0 
      BEGIN

        INSERT INTO [dbo].[Settings_Qualifications]
		(
				QualificationName
		)
        VALUES
		  (
				@Qualification		  
		  )
      END
      --=========================================================================QUALIFICATION INSERTION END===============================================================

      --=========================================================================QUALIFICATION UPDATE START================================================================

      ELSE
      BEGIN
        UPDATE [dbo].[Settings_Qualifications]
        SET QualificationName = @Qualification
        WHERE QualificationId = @QualificationId

      END
      --=========================================================================QUALIFICATION UPDATE END================================================================

END