
CREATE PROCEDURE [dbo].SpPaymentDetailsSearch
(
	@CareTakerId int, 
	@CategoryId int, 
	@FromDate datetime,
	@ToDate datetime,
	@Year int,
	@Month	int,
	@ServicetypeId int
)
AS
		DECLARE @Currency VARCHAR(100)
		DECLARE @CurrencySymbol VARCHAR(10)

		IF EXISTS (SELECT 1 from [Settings_Country] WHERE IsDefault = 1)
		BEGIN
			SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where IsDefault = 1
		END
		ELSE
		BEGIN
			SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where [CountryId] = 1
		END



	Declare @SQLQuery AS NVarchar(4000)
    Declare @ParamDefinition AS NVarchar(2000) 

		Set @SQLQuery ='SELECT    
			ppt.TransactionId,
			pcb.BookingDateTime AS BookingDate,
			um.FirstName +'' ''+ um.LastName AS CaretakerName,
			sct.TypeName AS CaretakerType,	
			scs.ServiceName,
			ppt.Amount AS PaidAmount,
			'+@CurrencySymbol+' as Symbol,
			ppt.TransactionDateTime AS PaidDate,
			ppt.InvoiceNo AS InvoiceNumber,
			ppt.Method,
			CASE 
				 WHEN ppt.Status = 1 THEN ''Success''
				 WHEN ppt.Status =  0 THEN ''Failed''
				 ELSE ''''
		  END as Status
		FROM
		[dbo].[PublicUser_PaymentTransaction]ppt
	    
		INNER JOIN	[dbo].[PublicUser_PaymentInvoice]ppi ON ppi.InvoiceNo = ppt.InvoiceNo
		INNER JOIN	[dbo].[PublicUser_Caretaker_Booking]pcb ON pcb.BookingId = ppi.BookingId
		INNER JOIN	[dbo].[UserDetails_Master]um   ON 	um.UserId=pcb.CaretakerUserId
		INNER JOIN [dbo].[User_AddressDetails]uad  ON 	uad.UserId=pcb.CaretakerUserId
		INNER JOIN [dbo].[Settings_CaretakerServices]scs ON 	scs.ServiceId=pcb.ServiceId
		LEFT JOIN [dbo].[Settings_City] C ON  C.CityId = uad.CityId
		LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
		LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
		INNER JOIN [dbo].[Caretaker_Details]cd  ON 	cd.UserId=pcb.CaretakerUserId
		INNER JOIN	[dbo].[Settings_CaretakerType]sct ON sct.TypeId = cd.CaretakerTypeId WHERE (1=1) '


		if @CareTakerId is not null 
					set @SQLQuery = @SQLQuery  + 'and (um.UserId=@CareTakerId)'	

			if @ServicetypeId is not null 
					set @SQLQuery = @SQLQuery  + 'and (scs.ServiceId=@ServicetypeId)'		
				
				if @CategoryId is not null 
					set @SQLQuery = @SQLQuery  + 'and (sct.TypeId=@CategoryId)'			
				if @Year is not null 
					set @SQLQuery = @SQLQuery  + 'and (year(ppt.TransactionDateTime)=@Year)'
				if @Month is not null 
					set @SQLQuery = @SQLQuery  + 'and (MONTH(ppt.TransactionDateTime)=@Month)'
				if @FromDate is not null and @ToDate is not null
					set @SQLQuery = @SQLQuery  + 'and (CAST (ppt.TransactionDateTime as DATE) between @FromDate and @ToDate)'

			set @SQLQuery = @SQLQuery  + 'ORDER BY PaidDate DESC'

		PRINT	@SQLQuery

					Set @ParamDefinition = '@CareTakerId int,
							@CategoryId int,							
							@FromDate Datetime,
							@ToDate datetime,
							@Year int,
							@Month int,
							@ServicetypeId int'

							    Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@CareTakerId,
				@CategoryId,
				@FromDate,
				@ToDate,
				@Year,
				@Month,
				@ServicetypeId
                
    If @@ERROR <> 0
    Set NoCount OFF