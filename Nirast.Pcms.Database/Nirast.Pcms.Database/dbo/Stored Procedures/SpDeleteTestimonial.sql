CREATE PROCEDURE [dbo].[SpDeleteTestimonial]
(
	@TestimonialId int
)
AS
BEGIN
	
		DELETE [dbo].[Settings_Testimonials]
		WHERE  TestimonialId = @TestimonialId
END