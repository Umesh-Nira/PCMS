CREATE PROCEDURE [dbo].[SpInsertUserPaymentTransaction]
	(@InvoiceNumber int,
	@Date datetime,
	@Description varchar(max),
	@Method varchar(50),
	@Status bit,
	@Message varchar(max),
	@TransactionNumber varchar(50),
	@Amount float,
	@TransactionDetails varchar(max))
AS
BEGIN
	
	 INSERT INTO [dbo].PublicUser_PaymentTransaction
	(
	 [InvoiceNo],
	 [TransactionDateTime],
	 [Description],
	 [Method],
	 [Status],
	 [Message],
	 [TransactionNo],
	 Amount,
	 TransactionDetails
	 )

	 VALUES(
	 @InvoiceNumber,
	 @Date,
	 @Description,
	 @Method,
	 @Status,
	 @Message,
	 @TransactionNumber,
	 @Amount,
	 @TransactionDetails)

	 IF(@Status ='true')
	 BEGIN
		UPDATE [dbo].PublicUser_PaymentInvoice
		SET PayStatus = 1
		WHERE InvoiceNo = @InvoiceNumber

		UPDATE [dbo].[PublicUser_Caretaker_Booking]
		SET [Status] = 2 
		WHERE [BookingId] = (SELECT BookingId
								FROM [dbo].[PublicUser_PaymentInvoice]
								WHERE InvoiceNo = @InvoiceNumber)

	 END
END