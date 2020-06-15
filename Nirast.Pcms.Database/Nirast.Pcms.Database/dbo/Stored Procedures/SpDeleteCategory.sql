/*
--------------------------------------------------------------------------------------------------
Author				: SETHU
Created Date		: 17-07-2018

Last Updated BY		: 
Last Updated Date	: 

This Stored Procedure calling from:	
----------------------------------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpDeleteCategory]
(
	@CategoryId int
)
AS
BEGIN
	
		DELETE [dbo].[Settings_CaretakerType]
		WHERE  [TypeId] = @CategoryId
END