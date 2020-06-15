--[SpGetPaymentReport]null,3,null,null,'12/12/2018 00:00:00','12/13/2018 00:00:00'
--[SpGetPaymentReport]null,null,null,null,null,null
CREATE PROC [dbo].[SpGetPaymentReport]--0,null,null,null,null,null,null,null
	(
	@ServiceId INT,
	@SearchDateType INT,
	@Year INT,
	@Month INT,
	@FromDate DATETIME,
	@ToDate DATETIME
	)
AS
Set NoCount ON
    /* Variable Declaration */
    Declare @SQLQuery AS NVarchar(max)
	Declare @ParamDefinition AS NVarchar(max) 

	IF @ServiceId IS NULL AND @SearchDateType IS NULL AND @Year IS NULL AND @Month IS NULL AND @FromDate IS NULL AND  @ToDate IS NULL
		SET @SQLQuery='SELECT TOP 25 '
	ELSE
		SET @SQLQuery='SELECT '

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

	SET @SQLQuery= @SQLQuery +' t1.BookingId AS Id,t1.BookingDate,t1.UserName,t1.CareTakerName, TransactionDate,t1.ServiceName AS Service,StartDate, EndDate, FromTime, EndTime,t1.DisplayRate,PayingAmount,DisplayAmount,isnull(t1.InvoiceNo,'''') AS InvoiceNo,t1.PaymentStatus,
	''' + @Currency + ''' as Currency,  
					''' +@CurrencySymbol + ''' as Symbol,
		cast(isnull(t2.HoildayHours,0)as decimal(10,2))as HoildayHours,
		cast((isnull(t2.HoildayHours,0)*t1.DisplayRate)*t2.HolidayPayValue as decimal(10,2)) as  HoildayAmount ,
		cast((((t1.TotalHours-isnull(t2.HoildayHours,0))*isnull(t1.ServiceRate,0)) + (isnull(t2.HoildayHours,0)*isnull(t1.ServiceRate,0))*isnull(t2.HolidayPayValue,0)) as decimal(10,2)) as TotalPayingAmount,
		cast((((t1.TotalHours-isnull(t2.HoildayHours,0))*isnull(t1.DisplayRate,0)) + (isnull(t2.HoildayHours,0)*isnull(t1.DisplayRate,0))*isnull(t2.HolidayPayValue,0)) as decimal(10,2)) as Amount,
		cast((DateDiff(minute,t1.FromDateTime,ToDateTime) / 60.0) as decimal(10,2))  as TotalHours
		from 
			             (SELECT  b.BookingId,
								  format(b.BookingDateTime,''dd-MMM-yyyy'') as BookingDate,
								  cs.ServiceName,
								  u.FirstName +'' '' +u.LastName as UserName, 
								  ua.Location as UserLocation,
								  cu.FirstName +'' ''+ cu.LastName as CareTakerName,
								  cua.Location as CaretakerLocation,
									isnull(dbo.getCaretakerPayingRate(b.CaretakerUserId,b.ServiceId,ToDateTime),0) as ServiceRate,
								  isnull(dbo.getCaretakerDisplayRate(b.CaretakerUserId,b.ServiceId,ToDateTime),0) as DisplayRate,
								   isnull(ppt.TransactionDateTime,'''') AS TransactionDate,
								  ppt.invoiceNo,b.FromDateTime,ToDateTime,
								  (SELECT CASE WHEN ppt.Status = 0 OR ppt.Status is null
									THEN ''Unpaid''
									ELSE ''Paid'' END )as PaymentStatus,
								  format(b.FromDateTime,''dd-MMM-yyyy'') AS StartDate,
								  format(b.ToDateTime,''dd-MMM-yyyy'') AS EndDate,
								  format(b.FromDateTime,''hh:mm tt'') as FromTime,
								  format(b.ToDateTime,''hh:mm tt'') as EndTime,
								  DateDiff(minute,b.FromDateTime,ToDateTime) / 60.0  as TotalHours,
								  (DateDiff(minute,b.FromDateTime,ToDateTime) / 60.0) * isnull(dbo.getCaretakerPayingRate(b.CaretakerUserId,b.ServiceId,ToDateTime),0) as PayingAmount,
								    (DateDiff(minute,b.FromDateTime,ToDateTime) / 60.0) * isnull(dbo.getCaretakerDisplayRate(b.CaretakerUserId,b.ServiceId,ToDateTime),0) as DisplayAmount,
								  crd.Purpose as BookingPurpose,
								  C.CityName as City,
								  S.StateName as State,
								  CN.CountryName as Country,
								 -- CN.Symbol,
								  --CN.Currency,
								  UL.EmailId as EmailAddress,
								  UA.Phone1 as PhoneNo1
						  FROM    [dbo].[PublicUser_Caretaker_Booking] b
							      INNER JOIN [dbo].[Settings_CaretakerServices] cs on cs.ServiceId = b.ServiceId
							      INNER JOIN [dbo].[UserDetails_Master] U on u.UserId = b.PublicUserId
							      INNER JOIN [dbo].[User_AddressDetails] ua on ua.UserId = b.PublicUserId
								  INNER JOIN [dbo].[User_LoginDetails] ul on ul.UserId = U.UserId
								  INNER JOIN [dbo].[UserDetails_Master] CU on cu.UserId = b.CaretakerUserId
								  INNER JOIN [dbo].[User_AddressDetails] cua on cua.UserId = b.CaretakerUserId
								  INNER JOIN [dbo].[Caretaker_Details] cd on cd.UserId = b.CaretakerUserId
								  INNER JOIN [dbo].[PublicUser_CareRecipientDetails] crd on crd.BookingId = b.BookingId
								  left JOIN	[dbo].[PublicUser_PaymentInvoice]ppi ON ppi.BookingId=b.BookingId
								  left JOIN	[dbo].[PublicUser_PaymentTransaction]ppt ON ppt.InvoiceNo=ppi.InvoiceNo
								  LEFT JOIN [dbo].[Settings_City] C ON UA.CityId = C.CityId 
								  LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
								  LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId 
								  WHERE (1=1)'

						 
			IF @ServiceId IS NULL AND @SearchDateType IS NULL AND @Year IS NULL AND @Month IS NULL AND @FromDate IS NULL AND  @ToDate IS NULL
				SET @SQLQuery = @SQLQuery +' AND ( DATEPART(MM, b.BookingDateTime) = DATEPART(MM, GETUTCDATE()))'

			IF @ServiceId IS NOT NULL
				SET @SQLQuery = @SQLQuery +' AND ( b.ServiceId = @ServiceId)'

			IF @SearchDateType > 0
				BEGIN
					IF @Year > 0
						SET @SQLQuery = @SQLQuery +' AND (YEAR(b.BookingDateTime) = @Year)'

					IF (@Year > 0) AND (@Month > 0)
						SET @SQLQuery = @SQLQuery + ' AND (YEAR(b.BookingDateTime) = @Year AND DATEPART(MM, b.BookingDateTime) = @Month)'
				END
				IF (@FromDate IS NOT NULL) AND (@ToDate IS NOT NULL)
							BEGIN
								SET @SQLQuery = @SQLQuery + ' AND (b.BookingDateTime BETWEEN  @FromDate  AND @ToDate' + ')'
							END
				set @SQLQuery= @SQLQuery + ' group by b.BookingId,b.BookingDateTime,cs.ServiceName,cu.FirstName,
								  cu.LastName,u.FirstName,u.LastName,cua.Location,ua.Location,b.CaretakerUserId,b.ServiceId,
								  ppt.Status,b.FromDateTime,b.ToDateTime,crd.Purpose,c.CityName,s.StateName,cn.CountryName,  CN.Symbol,
								  CN.Currency,ul.EmailId,ua.Phone1,TransactionDateTime,ppt.invoiceNo)  t1
								 left join 
      (select csd.BookingId,
        sum(csd.Hours) as HoildayHours,
        sum(csd.Hours * shp.HolidayPayValue)  as HolidayAmount,
        sh.CountryId,
        isnull(shp.HolidayPayValue,0) as HolidayPayValue
        from Settings_Holidays sh  
         join [dbo].[PublicUser_Booking_Dates] csd on csd.Date = sh.HolidayDate
         join Settings_HolidayPay shp on shp.HolidayPayId=shp.HolidayPayId
         join [dbo].[PublicUser_Caretaker_Booking] B on B.BookingId = csd.BookingId
         JOIN [dbo].[UserDetails_Master] CU on cu.UserId = b.CaretakerUserId
         JOIN [dbo].[User_AddressDetails] cua on cua.UserId = b.CaretakerUserId
         JOIN [dbo].[Settings_City] cuc on cuc.CityId = cua.CityId
         JOIN [dbo].[Settings_State] cus on cus.StateId = cuc.StateId and cus.CountryId = sh.CountryId
       WHERE Sh.StateId IS NULL OR Sh.StateId = cuc.StateId
        group by csd.BookingId, sh.CountryId,shp.HolidayPayValue ) t2
      on t1.BookingId=t2.BookingId'
	print @SQLQuery
	
	SET @SQLQuery = @SQLQuery + ' ORDER BY t1.BookingDate DESC'

	Set @ParamDefinition = '@ServiceId INT,
							@SearchDateType INT,
							@Year INT,
							@Month INT,
							@FromDate DATETIME,
							@ToDate DATETIME'
    /* Execute the Transact-SQL String with all parameter value's 
       Using sp_executesql Command */
    Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@ServiceId,
				@SearchDateType,
				@Year,
				@Month,
				@FromDate,
				@ToDate
                
    If @@ERROR <> 0
    Set NoCount OFF