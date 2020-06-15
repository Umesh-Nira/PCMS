CREATE PROCEDURE [dbo].[SpInsertOfficeStaffRegistration]
		(
		@Id int = 0,
		@DesignationId int,
		@RoleId int,
		@UserId int,
		@QualificationId int
		)
AS
BEGIN
      --=========================================================================USER INSERTION START=============================================================
      IF @Id = 0
      BEGIN

        INSERT INTO [dbo].[OfficeStaff_Details]
					(
						DesignationId,
						RoleId,
						UserId,
						QualificationId
					)
					VALUES
					(
						@DesignationId ,
						@RoleId,
						@UserId,
						@QualificationId
					)

      END
	      --=========================================================================USER INSERTION END===============================================================

		  --==========================================================================USER UPDATION START=============================================================
	ELSE
	BEGIN
			UPDATE [OfficeStaff_Details]
			SET DesignationId = @DesignationId,QualificationId= @QualificationId,
				RoleId = RoleId
			WHERE UserId = @UserId
	END
	  --================================================================================UPDATION END==================================================================
	  END
