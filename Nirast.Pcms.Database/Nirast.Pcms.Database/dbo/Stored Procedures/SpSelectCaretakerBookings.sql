--SpSelectCaretakersByCaretakerStatus 2
--[SpSelectCaretakerBookings]null,null,null,2019,8,null,null
CREATE PROC [dbo].[SpSelectCaretakerBookings]
	(
	@Caretaker NVARCHAR(50),
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

	IF @Caretaker IS NULL AND @ServiceId IS NULL AND @SearchDateType IS NULL AND @Year IS NULL AND @Month IS NULL AND @FromDate IS NULL AND  @ToDate IS NULL
		SET @SQLQuery='SELECT TOP 25 '
	ELSE
		SET @SQLQuery='SELECT '

	SET @SQLQuery= @SQLQuery +' t1.BookingId AS Id,t1.BookingDate,t1.UserName,t1.CareRecipient,UserLocation, t1.ServiceName AS Service,StartDate, EndDate, FromTime, EndTime,t1.ServiceRate,t1.DisplayRate,PayingAmount,DisplayAmount,t1.CareTakerName,
	''' + @Currency + ''' as Currency,  
					''' +@CurrencySymbol + ''' as Symbol,
		cast(isnull(t2.HoildayHours,0)as decimal(10,2))as HoildayHours,
		cast((isnull(t2.HoildayHours,0)*t1.DisplayRate)*t2.HolidayPayValue as decimal(10,2)) as  HoildayAmount ,
		cast((((t1.TotalHours-isnull(t2.HoildayHours,0))*isnull(t1.ServiceRate,0)) + (isnull(t2.HoildayHours,0)*isnull(t1.ServiceRate,0))*isnull(t2.HolidayPayValue,0)) as decimal(10,2)) as Amount,
		cast((((t1.TotalHours-isnull(t2.HoildayHours,0))*isnull(t1.DisplayRate,0)) + (isnull(t2.HoildayHours,0)*isnull(t1.DisplayRate,0))*isnull(t2.HolidayPayValue,0)) as decimal(10,2)) as TotalPayingAmount,
		cast((DateDiff(minute,t1.FromDateTime,ToDateTime) / 60.0) as decimal(10,2))  as TotalHours
		from 
			             (SELECT  b.BookingId,
								  format(b.BookingDateTime,''dd-MMM-yyyy'') as BookingDate,
								  crd.FirstName +'' '' + crd.LastName as CareRecipient,
								  cs.ServiceName,
								  u.FirstName +'' '' +u.LastName as UserName, 
								  ua.Location as UserLocation,
								  cu.FirstName +'' ''+ cu.LastName as CareTakerName,
								  cua.Location as CaretakerLocation,
								  isnull(dbo.getCaretakerPayingRate(CU.UserId,cs.ServiceId,b.ToDateTime),0.00) as ServiceRate,
								  isnull(dbo.getCaretakerDisplayRate(CU.UserId,cs.ServiceId,b.ToDateTime),0.00) as DisplayRate,b.FromDateTime,ToDateTime,
								  format(b.FromDateTime,''dd-MMM-yyyy'') AS StartDate,
								  format(b.ToDateTime,''dd-MMM-yyyy'') AS EndDate,
								  format(b.FromDateTime,''hh:mm tt'') as FromTime,
								  format(b.ToDateTime,''hh:mm tt'')as EndTime,
								  DateDiff(minute,b.FromDateTime,ToDateTime) / 60.0  as TotalHours,
								  (DateDiff(minute,b.FromDateTime,ToDateTime) / 60.0) * isnull(dbo.getCaretakerPayingRate(CU.UserId,cs.ServiceId,b.ToDateTime),0.00) as PayingAmount,
								    (DateDiff(minute,b.FromDateTime,ToDateTime) / 60.0) * isnull(dbo.getCaretakerDisplayRate(CU.UserId,cs.ServiceId,b.ToDateTime),0.00) as DisplayAmount
						  FROM    [dbo].[PublicUser_Caretaker_Booking] b
							      INNER JOIN [dbo].[Settings_CaretakerServices] cs on cs.ServiceId = b.ServiceId
							      INNER JOIN [dbo].[UserDetails_Master] U on U.UserId = b.PublicUserId
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


			--IF @Caretaker IS NOT NULL
			--SET @SQLQuery = @SQLQuery + ' AND ((CU.FirstName LIKE ''%' + @Caretaker + '%'') OR  (CU.LastName LIKE ''%' + @Caretaker +'%'') OR ((cu.FirstName +'' ''+ cu.LastName) LIKE ''%' + @Caretaker + '%''))'

			IF @Caretaker IS NOT NULL
			SET @SQLQuery = @SQLQuery +' AND ( CU.UserId = @Caretaker)'

			IF @ServiceId IS NOT NULL
				SET @SQLQuery = @SQLQuery +' AND ( b.ServiceId = @ServiceId)'

			IF (@FromDate IS NULL) AND (@ToDate IS NULL)
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

				set @SQLQuery= @SQLQuery + ' group by b.BookingId,b.BookingDateTime,cs.ServiceName,cu.FirstName,U.UserId,cs.ServiceId,CU.UserId,
						  cu.LastName,u.FirstName,u.LastName,cua.Location,ua.Location,crd.FirstName,crd.LastName,
						  b.Status,b.FromDateTime,b.ToDateTime,StatusModifiedDate)  t1

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
								 JOIN [dbo].[Settings_State] cus on cus.StateId = cuc.StateId
								 and cus.CountryId = sh.CountryId
							WHERE Sh.StateId IS NULL OR Sh.StateId = cuc.StateId
							 group by csd.BookingId, sh.CountryId,shp.HolidayPayValue ) t2
					 on t1.BookingId=t2.BookingId'
	print @SQLQuery
	SET @SQLQuery = @SQLQuery + ' ORDER BY t1.BookingDate DESC'

	Set @ParamDefinition = '@Caretaker NVARCHAR(50),
							@ServiceId INT,
							@SearchDateType INT,
							@Year INT,
							@Month INT,
							@FromDate DATETIME,
							@ToDate DATETIME'
    /* Execute the Transact-SQL String with all parameter value's 
       Using sp_executesql Command */
    Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@Caretaker,
				@ServiceId,
				@SearchDateType,
				@Year,
				@Month,
				@FromDate,
				@ToDate
                
    If @@ERROR <> 0
    Set NoCount OFF