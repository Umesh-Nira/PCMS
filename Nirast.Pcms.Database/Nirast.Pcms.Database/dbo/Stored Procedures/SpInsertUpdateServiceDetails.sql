CREATE PROCEDURE [dbo].[SpInsertUpdateServiceDetails] (
		@Id int = 0,
		@Name nvarchar(500),@ServiceDescription nvarchar(MAX),@ServicePic image,
		@ServiceOrder int)
AS
BEGIN

    IF @Id = 0
      BEGIN

        INSERT INTO [dbo].[Settings_CaretakerServices]
		(
			[ServiceName],[ServiceDescription],[ServicePic],[ServiceOrder]
		)
		VALUES
		(
			@Name,@ServiceDescription,@ServicePic,@ServiceOrder
		)

      END
      --======= INSERT END =======

      --======= UPDATE START =======

      ELSE
      BEGIN

        UPDATE [dbo].[Settings_CaretakerServices]
        SET [ServiceName] = @Name,
		[ServiceDescription] = @ServiceDescription,
		[ServicePic]=@ServicePic,
		[ServiceOrder]=@ServiceOrder
        WHERE ServiceId = @Id

      END
END