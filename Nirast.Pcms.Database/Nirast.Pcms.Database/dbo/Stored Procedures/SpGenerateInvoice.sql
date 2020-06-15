  
CREATE PROCEDURE [dbo].[SpGenerateInvoice]	
(
	@BookingId int,
	@Amount float
)
AS
BEGIN
	DECLARE @Tax float;
	DECLARE @TotalAmount float;
	SELECT @Tax =	 @Amount * (ISNULL(ss.TaxPercent,0)/100)
					 FROM [dbo].[PublicUser_Caretaker_Booking] pcb
					 INNER JOIN  [dbo].[User_AddressDetails] uad ON uad.UserId=pcb.PublicUserId
					 LEFT JOIN  [dbo].[Settings_City] sc ON sc.CityId=uad.CityId
					 LEFT JOIN [dbo].[Settings_State] ss ON ss.StateId=sc.StateId
					 WHERE pcb.BookingId = @BookingId

	SET @TotalAmount = (@Amount+@Tax)

		INSERT INTO [dbo].[PublicUser_PaymentInvoice] 
				(
					BookingId,
					Amount,
					TaxAmount,
					TotalAmount,
					InvoiceDate
				)
				VALUES
				  (
					 @BookingId,
					 @Amount,
					 @Tax,
					@TotalAmount,
					 GetDate()
				  )

		SELECT SCOPE_IDENTITY()

		UPDATE PublicUser_Caretaker_Booking SET [Status]= 5
					WHERE BookingId=@BookingId

END