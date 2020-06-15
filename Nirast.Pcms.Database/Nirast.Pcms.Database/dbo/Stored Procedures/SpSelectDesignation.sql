CREATE PROCEDURE [dbo].[SpSelectDesignation]
(
	@DesignationId int = 0
)
AS
BEGIN

	IF(@DesignationId = 0)
		SET @DesignationId = NULL
	
		
	SELECT D.DesignationId,
			D.DesignationName AS Designation
	FROM  [dbo].[Settings_Designations] D
	WHERE D.DesignationId = ISNULL(@DesignationId,D.DesignationId)
	ORDER BY D.DesignationName 
		
END