CREATE PROCEDURE [dbo].[SpPaymentReportSearch]
(
@CareTakerId int, 
@CategoryId int, 
@FromDate datetime,
@ToDate datetime,
@Year int,
@Month	int,
@TransactionStatus int,
@ServicetypeId int
)
AS

Declare @SQLQuery AS NVarchar(4000)
    Declare @ParamDefinition AS NVarchar(2000) 

		Set @SQLQuery ='SELECT		
		format(pcb.FromDateTime,''dd/MM/yyyy'') as StartDate,
		ppt.TransactionDateTime AS TransactionDate,
		format(pcb.ToDateTime,''dd/MM/yyyy'')as EndDate,
		format(pcb.FromDateTime,''HH:mm'') as FromTime,
		format(pcb.ToDateTime,''HH:mm'')as EndTime,
		um.FirstName + '' ''+ um.LastName as	CareTakerName,
		udm.FirstName + '' ''+  udm.LastName as UserName,
		scs.ServiceName AS Service,
		sct.TypeName AS CareTakerType,
		ppt.Amount,
		CN.Symbol		
		FROM  [dbo].[PublicUser_Caretaker_Booking]pcb
			INNER JOIN	[dbo].[Settings_CaretakerServices]scs ON scs.ServiceId = pcb.ServiceId
			INNER JOIN	[dbo].[Caretaker_Details]cd ON cd.UserId = pcb.CaretakerUserId
			INNER JOIN	[dbo].[UserDetails_Master]um ON um.UserId = pcb.CaretakerUserId
			INNER JOIN	[dbo].[UserDetails_Master]udm ON udm.UserId = pcb.PublicUserId
			INNER JOIN [dbo].[User_AddressDetails]uad  ON 	uad.UserId=pcb.CaretakerUserId
			LEFT JOIN [dbo].[Settings_City] C ON  C.CityId = uad.CityId
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			INNER JOIN	[dbo].[Settings_CaretakerType]sct ON sct.TypeId = cd.CaretakerTypeId
			INNER JOIN	[dbo].[PublicUser_PaymentInvoice]ppi ON ppi.BookingId=pcb.BookingId
			INNER JOIN	[dbo].[PublicUser_PaymentTransaction]ppt ON ppt.InvoiceNo=ppi.InvoiceNo
			WHERE pcb.CaretakerUserId = ISNULL (@CareTakerId,pcb.CaretakerUserId)
		and ppt.Status=ISNULL (@TransactionStatus,ppt.Status)'

			if @ServicetypeId is not null 
					set @SQLQuery = @SQLQuery  + 'and (pcb.ServiceId=@ServicetypeId)'		
				
				if @CategoryId is not null 
					set @SQLQuery = @SQLQuery  + 'and (sct.TypeId=@CategoryId)'			
				if @Year is not null 
					set @SQLQuery = @SQLQuery  + 'and (year(pcb.FromDateTime)=@Year)'
				if @Month is not null 
					set @SQLQuery = @SQLQuery  + 'and (MONTH(pcb.FromDateTime)=@Month)'
				if @FromDate is not null and @ToDate is not null
					set @SQLQuery = @SQLQuery  + 'and (pcb.FromDateTime between @FromDate and @ToDate)'

					Set @ParamDefinition = '@CareTakerId int,
							@CategoryId int,							
							@FromDate Datetime,
							@ToDate datetime,
							@Year int,
							@Month int,
							@TransactionStatus int,
@ServicetypeId int'

							    Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@CareTakerId,
				@CategoryId,
				@FromDate,
				@ToDate,
				@Year,
				@Month,
				@TransactionStatus,
				@ServicetypeId
                
    If @@ERROR <> 0
    Set NoCount OFF