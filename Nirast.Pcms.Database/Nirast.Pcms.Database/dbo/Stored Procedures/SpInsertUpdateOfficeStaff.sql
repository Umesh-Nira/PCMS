CREATE PROCEDURE [dbo].[SpInsertUpdateOfficeStaff]
	(@Id int = 0,
	@DesignationId int,
	@UserId int)

AS
BEGIN
      --=========================================================================USER INSERTION START=============================================================
      IF @Id = 0
		BEGIN
			INSERT INTO [dbo].OfficeStaff_Details
			(
				DesignationId,
				UserId
			)
			VALUES
			(
				@DesignationId ,
				@UserId
			)
		END
	      --=========================================================================USER INSERTION END===============================================================

		  --==========================================================================USER UPDATION START=============================================================
	ELSE
		BEGIN
			UPDATE OfficeStaff_Details
			SET DesignationId = @DesignationId            
			WHERE UserId = @UserId
		END
	  --================================================================================UPDATION END==================================================================
END