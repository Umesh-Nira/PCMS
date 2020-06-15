CREATE PROCEDURE [dbo].[spInsertQuestionnaireDetails] 
			(@BookingId int,
			 @Answer1 nvarchar(max),
			 @Answer2 nvarchar(max),
			 @Answer3 nvarchar(max),
			 @Answer4 nvarchar(max),
			 @Answer5 nvarchar(max),
			 @Answer6 nvarchar(max))
AS
BEGIN
		INSERT INTO [dbo].PublicUser_Booking_Questionnaire
				   ([BookingId]
				   ,Answer1
				   ,Answer2     
				   ,Answer3
				   ,Answer4
				   ,Answer5
				   ,Answer6)
			 VALUES
				   (@BookingId,           
				   @Answer1,
				   @Answer2,
				   @Answer3,
				   @Answer4,
				   @Answer5,
				   @Answer6)
END
