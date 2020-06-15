CREATE PROCEDURE [dbo].[SpAddEditClientScheduleOneToOneTable] 
(
    @ClientId int ,
	@ScheduleId int,
	@SubDescription NVARCHAR(100)
)
AS
BEGIN
	Declare @Id INT
	
		IF EXISTS(SELECT 1 FROM [dbo].[Client_OneToOne_Details] WITH(NOLOCK)
          WHERE [SchedulingId] = @ScheduleId)
		 BEGIN
       			UPDATE [dbo].[Client_OneToOne_Details]
				SET [Description] = @SubDescription
				WHERE [SchedulingId] = @ScheduleId

				SELECT [OneToOneDetailId] 
				FROM [Client_OneToOne_Details] 
				WHERE [SchedulingId] = @ScheduleId
				SET @Id = @ScheduleId
		  END
		ELSE
		BEGIN
			INSERT INTO [dbo].[Client_OneToOne_Details]
			   (
					[SchedulingId],
					[Description]
				)
			VALUES
			   (
					@ScheduleId,
					@SubDescription
				)
				SET @Id = CAST(SCOPE_IDENTITY() AS int)
		END	

		--Insert into [dbo].[Settings_Resident]
		IF NOT EXISTS(SELECT 1 FROM [dbo].[Settings_Resident] WITH(NOLOCK)
		WHERE LOWER([ResidentName]) = LOWER(@SubDescription))
		BEGIN
			INSERT INTO [dbo].[Settings_Resident]
			
			(ResidentName,
			ClientId
			)
			
			VALUES
			(@SubDescription,
			@ClientId
			)
		END
		SELECT @Id	
END
