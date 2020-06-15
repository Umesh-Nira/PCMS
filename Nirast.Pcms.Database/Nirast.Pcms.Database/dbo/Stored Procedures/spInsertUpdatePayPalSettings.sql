CREATE PROC [dbo].[spInsertUpdatePayPalSettings](@PaypalId INT = 0,
	@ClientId NVARCHAR(500),
	@SecretKey NVARCHAR(500)) 
	AS
BEGIN
	if @PaypalId = 0
		BEGIN
			INSERT INTO Settings_PayPalAccount ([ClientId]
				   ,[SecretKey])
			VALUES (@ClientId,
			@SecretKey)
		END
	ELSE
		BEGIN
			UPDATE Settings_PayPalAccount SET

			ClientId = @ClientId,
			SecretKey = @SecretKey

			WHERE PaypalId = @PaypalId
		END
END