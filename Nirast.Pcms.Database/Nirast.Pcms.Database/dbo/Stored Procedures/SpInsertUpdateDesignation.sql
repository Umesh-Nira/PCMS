CREATE PROCEDURE [dbo].[SpInsertUpdateDesignation] 
		(@DesignationId int = 0,
		@Designation nvarchar(50))
AS
BEGIN
      --=========================================================================DESIGNATION INSERTION START=============================================================
      IF @DesignationId = 0 
      BEGIN

        INSERT INTO [dbo].[Settings_Designations]
		(
			DesignationName
		)
        VALUES
		(
			@Designation
		)

      END
      --=========================================================================DESIGNATION INSERTION END===============================================================

      --=========================================================================DESIGNATION UPDATE START================================================================

      ELSE
      BEGIN
        UPDATE [dbo].[Settings_Designations]
        SET DesignationName = @Designation
        WHERE DesignationId = @DesignationId

      END
      --=========================================================================DESIGNATION UPDATE END================================================================

END