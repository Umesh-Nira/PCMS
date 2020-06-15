CREATE PROCEDURE [dbo].[SpInsertUpdateClientInvoice](
    @ClientId int = 0,
	@ClientName nvarchar(100),
	@InvoicePrefix nvarchar(10),
	@InvoiceNumber int
)
AS
BEGIN
      --=========================================================================CITY INSERTION START=============================================================
      IF @ClientId = 0
      BEGIN
			INSERT INTO [dbo].[Client_Master]
			(
				ClientId,
				ClientName,
				InvoicePrefix,
				InvoiceNumber
			)
			VALUES
			  (
				 @ClientId,
				 @ClientName,
				 @InvoicePrefix,
				 @InvoiceNumber
			  )
      END
      --=========================================================================CITY INSERTION END===============================================================
      --=========================================================================CITY UPDATE START================================================================

      ELSE
      BEGIN
			UPDATE [dbo].[Client_Master]
			SET 
			    ClientName = @ClientName,
				InvoicePrefix = @InvoicePrefix,
				InvoiceNumber = @InvoiceNumber
				
			WHERE ClientId  = @ClientId

      END
      --=========================================================================CITY UPDATE END================================================================
END
