--[spInsertUpdateTestimonials] 0,'Raj','K',null,'Hai','youtube.com',3
CREATE PROCEDURE [dbo].[spInsertUpdateTestimonials] (
		@TestimonialId int = 0,
		@ClientName nvarchar(50),
		@Designation nvarchar(50),
		@Description nvarchar(500),
		@Url nvarchar(50),
		@Rating int)
AS
BEGIN

    IF @TestimonialId = 0
      BEGIN

        INSERT INTO [dbo].[Settings_Testimonials]
		(
			[ClientName],
			[Designation],
			[Description],
			[Url],
			[Rating]
		)
		VALUES
		(
			@ClientName,
			@Designation,
			@Description,
			@Url,
			@Rating
		)

      END
      --======= INSERT END =======

      --======= UPDATE START =======

      ELSE
      BEGIN

        UPDATE [dbo].[Settings_Testimonials]
        SET [ClientName] = @ClientName,
		[Designation] = @Designation,
		[Description] = @Description,
		[Url] = @Url,
		[Rating] = @Rating
        WHERE TestimonialId = @TestimonialId

      END
END