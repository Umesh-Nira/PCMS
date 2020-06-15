CREATE PROCEDURE [dbo].[SpDeleteDesignation]
(
	@DesignationId int
)
AS
BEGIN
	
		DELETE [dbo].[Settings_Designations]
		WHERE  DesignationId = @DesignationId
END