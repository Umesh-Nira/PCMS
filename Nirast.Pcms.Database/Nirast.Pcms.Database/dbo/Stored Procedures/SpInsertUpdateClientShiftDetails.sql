/*
---------------------------------------------------------------------------------------------------------
< Add a new record or update an existing record in ClientShiftDetails based on user's choice >
Author  			: Sethu
Created Date		: 20-08-2018

Updated BY			:  
Updated Date		: 

Updated BY			: Sethu 
Updated Date		: 

  
This Stored Procedure calling from:	
-----------------------------------------------------------------------------------------------------------
*/

CREATE PROCEDURE [dbo].[SpInsertUpdateClientShiftDetails] 
	(@ClientId int,
     @ShiftId int
	)
AS
      --========================================================================= CLIENT SHIFT INSERTION START =============================================================
BEGIN
        INSERT INTO [dbo].[Client_ShiftDetails]
		(
		   ClientId,
		   ShiftId
		)
        VALUES
		  (
		   @ClientId,
		   @ShiftId
		  )
END
      --=========================================================================CLIENT SHIFT INSERTION END===============================================================