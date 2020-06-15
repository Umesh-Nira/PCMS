/*
---------------------------------------------------------------------------------------------------------
< Add a new record or update an existing record in Categories based on user's choice >
Author  			: Sethu
Created Date		: 17-07-2018

Updated BY			: 
Updated Date		: 

  
This Stored Procedure calling from:	
-----------------------------------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpInsertUpdateCategory] (@CategoryId int = 0,
	@Name nvarchar(50),
	@Color nvarchar(20)
)
AS
BEGIN

      --=========================================================================CATEGORY INSERTION START=============================================================
      IF @CategoryId = 0
      BEGIN

        INSERT INTO [dbo].[Settings_CaretakerType]
		(
			[TypeName],
			[Color]
		)
        VALUES
		  (
			  @Name,
			  @Color
		  )
      END
      --=========================================================================CATEGORY INSERTION END===============================================================

      --=========================================================================CATEGORY UPDATE START================================================================

      ELSE
      BEGIN
        UPDATE [dbo].[Settings_CaretakerType]
        SET
            [TypeName] = @Name,
			[Color] = @Color
        WHERE [TypeId] = @CategoryId

      END
      --=========================================================================CATEGORY UPDATE END================================================================

END