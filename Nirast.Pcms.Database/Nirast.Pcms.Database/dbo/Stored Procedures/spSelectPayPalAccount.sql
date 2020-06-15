
CREATE PROC [dbo].[spSelectPayPalAccount](@paypalId INT)AS
BEGIN
SELECT * FROM Settings_PayPalAccount WHERE PaypalId = @paypalId		
END