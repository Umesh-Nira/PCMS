
CREATE PROCEDURE [dbo].[SpInsertPayriseDates]--'16-Feb-2019',5
	-- Add the parameters for the stored procedure here
	@Payrisedate Datetime,
	@CaretakerId int,
	@PayriseId_OUT INT OUT
AS
BEGIN

	INSERT INTO [dbo].[Caretaker_Booking_Payrise]
	([Payrisedate],
     [CaretakerId]
	)
	values (@Payrisedate,@CaretakerId)
	SET @PayriseId_OUT=SCOPE_IDENTITY()
END