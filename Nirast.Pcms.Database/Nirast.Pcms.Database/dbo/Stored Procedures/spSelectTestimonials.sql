CREATE PROCEDURE [dbo].[spSelectTestimonials]
	(@TestimonialId INT)
AS
BEGIN
	IF(@TestimonialId = 0)
		SET @TestimonialId = NULL

	SELECT [TestimonialId],
			[ClientName],
			[Designation],
			[Description],
			[Url],
			[Rating]
	FROM [dbo].[Settings_Testimonials]
	WHERE [TestimonialId] =ISNULL(@TestimonialId, [TestimonialId])
END