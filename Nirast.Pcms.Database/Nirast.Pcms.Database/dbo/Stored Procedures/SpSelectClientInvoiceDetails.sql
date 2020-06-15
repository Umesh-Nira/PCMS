--[SpSelectClientInvoiceDetails] null,null,null,null,null,null,1
CREATE PROCEDURE [dbo].[SpSelectClientInvoiceDetails] 
(
	@InvoiceNumber nvarchar(25),
	@ClientId int,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@year int,
	@month int,
	@InvoiceSearchInputId int
)
AS
BEGIN
	Declare @SQLQuery AS NVarchar(4000)
    Declare @ParamDefinition AS NVarchar(2000) 
	Set @SQLQuery = 'SELECT 
			cid.InvoiceSearchInputId,
			cid.InvoiceDate,  
			cid.InvoiceNumber,
			cid.InvoicePrefix AS InvoicePrefix,
			cid.ClientId AS ClientId,
			cm.ClientName AS ClientName,
			L.EmailId AS ClientEmail,
			cid.StartDate AS StartDate,
			cid.EndDate AS EndDate,
			cid.Mode AS Mode, 
			cid.Year,
			cid.Month,
			cid.Seperateinvoice AS Seperateinvoice,
			cid.Description AS Description,
			cid.PdfFile AS PdfFile,
			cid.Year AS Year,
			cid.Month AS Month,
			cid.Category AS Category
			FROM
			[dbo].[Client_Invoice_Details] cid
			INNER JOIN [dbo].[Client_Master] cm on cm.[ClientId] = cid.ClientId
			LEFT JOIN [dbo].[User_LoginDetails] L ON L.UserId = cm.UserId
			where (1=1) '

				IF(@InvoiceSearchInputId IS NOT NULL)
		Set @SQLQuery=@SQLQuery + ' AND (cid.[InvoiceSearchInputId] = @InvoiceSearchInputId)'

			IF(@InvoiceNumber IS NULL AND @ClientId IS NULL AND @FromDate IS NULL AND @ToDate IS NULL AND @Year IS NULL AND @Month IS NULL AND @InvoiceSearchInputId IS NOT NULL)
		Set @SQLQuery=@SQLQuery + ' AND (cid.[InvoiceSearchInputId] = @InvoiceSearchInputId)'
	
	IF(@InvoiceNumber IS NULL AND @ClientId IS NULL AND @FromDate IS NULL AND @ToDate IS NULL AND @Year IS NULL AND @Month IS NULL AND @InvoiceSearchInputId IS  NULL)
		Set @SQLQuery=@SQLQuery + ' AND (YEAR(cid.[InvoiceDate]) = YEAR(GETDATE()) AND DATEPART(MM, cid.[InvoiceDate]) = DATEPART(MM, GETDATE()))'

		

	IF(@InvoiceNumber IS NOT NULL)
		Set @SQLQuery=@SQLQuery + 'AND (cid.[InvoicePrefix]  = @InvoiceNumber)'

	IF(@ClientId IS NOT NULL)
		Set @SQLQuery=@SQLQuery + ' AND (cid.[ClientId] = @ClientId)'
	
	IF(@FromDate IS NOT NULL AND @ToDate IS NOT NULL)
		Set @SQLQuery = @SQLQuery + ' AND (cid.[InvoiceDate] between @FromDate AND @ToDate )'
		
	IF @Year > 0
		SET @SQLQuery = @SQLQuery +' AND (cid.[Year] = @Year)'

	IF (@Year > 0) AND (@Month > 0)
		SET @SQLQuery = @SQLQuery + ' AND (YEAR(cid.[InvoiceDate]) = @Year AND DATEPART(MM, cid.[InvoiceDate]) = @Month)'

	Set @SQLQuery = @SQLQuery + ' ORDER BY cid.[InvoiceDate] DESC'


	Set @ParamDefinition = '@InvoiceNumber nvarchar(25),
							@ClientId int,
							@FromDate DATETIME,
							@ToDate DATETIME,
							@year int,
							@month int,
							@InvoiceSearchInputId int'
	PRINT @SQLQuery
	Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@InvoiceNumber,
				@ClientId,
				@FromDate,
				@ToDate,
				@year,
				@month,
				@InvoiceSearchInputId
                
    If @@ERROR <> 0
    Set NoCount OFF
END