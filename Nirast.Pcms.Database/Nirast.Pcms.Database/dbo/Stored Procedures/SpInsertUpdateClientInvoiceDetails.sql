
CREATE PROCEDURE [dbo].[SpInsertUpdateClientInvoiceDetails] 
	(
	@InvoiceSearchInputId int = 0,
	@InvoiceNumber int,
	@InvoicePrefix nvarchar (500),
	@ClientId int,
	@StartDate date,
	@EndDate date,
	@Mode int,
	@Year int,
	@Month int,
	@Seperateinvoice bit,
	@Category nvarchar(500),
	@Description nvarchar (500),
	@PdfFilePath nvarchar(MAX),
    @InvoiceSearchInputId_Out INT OUT
	)
	
AS
BEGIN
	
 
      IF @InvoiceSearchInputId = 0
      BEGIN	 
        INSERT INTO [dbo].Client_Invoice_Details
		(
		    InvoiceNumber,
			InvoicePrefix,
			ClientId,
			StartDate,
			EndDate,
			Mode,
			Seperateinvoice,
			Category,
			Description,
			Year, 
			Month,
			InvoiceDate,
			PdfFilePath
		)
        VALUES
		  (
		    @InvoiceNumber,
			@InvoicePrefix,
			@ClientId,
			@StartDate,
			@EndDate,
			@Mode,
			@Seperateinvoice,
			@Category,
			@Description,
			@Year, 
			@Month,
			GETDATE(),
			@PdfFilePath     
		  )
		SET @InvoiceSearchInputId_Out=SCOPE_IDENTITY()
      END


      ELSE
      BEGIN
        UPDATE [dbo].Client_Invoice_Details
        SET 

			StartDate 					= @StartDate ,			      
			EndDate						= @EndDate ,
			Mode						= @Mode,
			Seperateinvoice 			= @Seperateinvoice ,			      
			Description					= @Description ,
			Year						= @Year, 
			Month                       = @Month,
			InvoiceDate					= GETDATE(),	 
			PdfFilePath					=@PdfFilePath
			where InvoiceSearchInputId	= @InvoiceSearchInputId

			SET @InvoiceSearchInputId_Out=@InvoiceSearchInputId

      END
	  
END

select * from Client_Invoice_Details