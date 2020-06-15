/*
---------------------------------------------------------------------------------------------------------
< Select record/s from Categoriesa based on user's choice >
< Pass Flag = * and Value = '' for select all records>
< Pass Flag = CategoryId and Value = any CategoryId, for select records based on a particular CategoryId>
< Pass Flag = Name and Value = any Category Name, for select records based on a particular Category>

Author				: Sethu
Created Date		: 17-07-2018

Updated BY			: 
Updated Date		: 


This Stored Procedure calling from:	
-----------------------------------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpSelectAllCategories]
(
	@Flag varchar(50),
	@Value varchar(50)
)
AS
BEGIN
	IF @Flag='*'
		BEGIN
			SELECT C.TypeId AS CategoryId,
				   C.TypeName AS Name,
				   C.Color
			FROM  [dbo].[Settings_CaretakerType] C
			ORDER BY C.TypeName 
		END
	ELSE IF @Flag='TypeId'
		BEGIN
			SELECT C.TypeId AS CategoryId,
				   C.TypeName AS Name,
				    C.Color
			FROM  [dbo].[Settings_CaretakerType] C
			WHERE C.TypeId = @Value
			ORDER BY C.TypeName 
		END
END