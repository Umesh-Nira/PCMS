-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--[GetUserInvoicePayments] 16
-- =============================================
CREATE PROCEDURE [dbo].[GetUserInvoicePayments](@UserId int)
	
AS
BEGIN
	
	SELECT upi.Amount,
			upi.Date,
			upi.InvoiceNumber,
			upi.PaidStatus
	from  
	[dbo].[UserPaymentInvoice] upi
	 INNER JOIN [dbo].[UserCareTakerBooking] ucb ON ucb.BookingId=upi.BookingId
	 WHERE ucb.BookedUserId=@UserId

	 SELECT upt.Description,
			upt.Method,
			upt.Date,
			upt.InvoiceNumber,
			upt.Status,
			upt.TransactionId,
			upt.TransactionNumber
	 FROM   [dbo].[UserPaymentTransaction] upt
	 INNER JOIN  [dbo].[UserPaymentInvoice] upi ON upi.InvoiceNumber=upt.InvoiceNumber
	 INNER JOIN [dbo].[UserCareTakerBooking] ucb ON ucb.BookingId=upi.BookingId
	  WHERE ucb.BookedUserId=@UserId
END