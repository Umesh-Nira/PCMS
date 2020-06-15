--[SpSelectBookingHistory]0,null,null,null,2019,2,null,null
CREATE PROC [dbo].[SpSelectBookingHistory] --0,null,null,null,2019,5,null,null
	(
	@StatusId INT,
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


	IF @StatusId = 0
		SET @StatusId = NULL
	IF @Caretaker IS NULL AND @ServiceId IS NULL AND @SearchDateType IS NULL AND @Year IS NULL AND @Month IS NULL AND @FromDate IS NULL AND  @ToDate IS NULL
		SET @SQLQuery='SELECT TOP 25 '
	ELSE
		SET @SQLQuery='SELECT '

	set @SQLQuery= @SQLQuery + ' t1.BookingId,
					BookingDate,
					InvoiceNo,
					ServiceName,
					BookedUser,
					UserLocation,
					Caretaker,
					CaretakerLocation,										
					ServiceRate,
					BookingStatus,
					BookingStartTime,
					BookingEndTime,
					StatusModifiedDate,
					Type,
					TotalHours,
					RestTime,
					InvoicePath,
					PayingAmount,
					'''+@Currency+''' as Currency,
					'''+@CurrencySymbol+''' as CurrencySymbol,
					cast(isnull(t2.HoildayHours,0)as decimal(10,2))as HoildayHours ,
					cast((isnull(t2.HoildayHours,0)*t1.DisplayRate)*t2.HolidayPayValue as decimal(10,2)) as  HoildayAmout ,			
					cast(isnull(((t1.TotalHours- t1.RestTime)*t1.ServiceRate)+((isnull(t2.HoildayHours,0)*t1.DisplayRate)*t2.HolidayPayValue),t1.PayingAmount) as  decimal(10,2)) as Total
					from 
			        (SELECT	    b.BookingId,
								b.BookingDateTime as BookingDate,
								cs.ServiceName,
								u.FirstName +'' '' +u.LastName as BookedUser, 
								ua.Location as UserLocation,
								cu.FirstName +'' ''+ cu.LastName as Caretaker,
								cua.Location as CaretakerLocation,
								isnull(cps.PayingRate,0) as ServiceRate,
								cps.DisplayRate,
								b.Status as BookingStatus,
								b.FromDateTime as BookingStartTime,
								b.ToDateTime as BookingEndTime,
								StatusModifiedDate,
								ct.TypeName as Type,
								cast((DateDiff(minute,b.FromDateTime,ToDateTime) / 60.0) as decimal(10,2))  as TotalHours,	
								(select case when cast((DateDiff(minute,b.FromDateTime,ToDateTime) / 60.0) as decimal(10,2)) >=8 
								then ''.5''
								else ''0''
								end as timed) as RestTime,								 
								cast((DateDiff(minute,b.FromDateTime,ToDateTime) / 60.0) * cps.PayingRate as decimal(10,2)) as PayingAmount,
								pay.InvoiceNo,
								pay.InvoicePath
							  FROM [dbo].[PublicUser_Caretaker_Booking] b
						      LEFT JOIN  [dbo].[PublicUser_Booking_Dates] pbd on pbd.BookingId=b.BookingId
							  INNER JOIN [dbo].[Settings_CaretakerServices] cs on cs.ServiceId = b.ServiceId
							  INNER JOIN [dbo].[UserDetails_Master] U on u.UserId = b.PublicUserId
							  INNER JOIN [dbo].[User_AddressDetails] ua on ua.UserId = b.PublicUserId
							  INNER JOIN [dbo].[UserDetails_Master] CU on cu.UserId = b.CaretakerUserId
							  INNER JOIN [dbo].[User_AddressDetails] cua on cua.UserId = b.CaretakerUserId
							  INNER JOIN [dbo].[Caretaker_Details] cd on cd.UserId = b.CaretakerUserId
							  INNER JOIN [dbo].[Settings_CaretakerType] ct on ct.TypeId = cd.CaretakerTypeId
							  LEFT JOIN [dbo].[Caretaker_PublicUser_Service] cps on cps.UserId = b.CaretakerUserId AND cps.ServiceId = b.ServiceId
							  LEFT JOIN [dbo].[PublicUser_PaymentInvoice]pay on pay.BookingId = b.BookingId
						  WHERE (1=1) AND b.Status = ISNULL(@StatusId,b.Status)'


			

			IF @Caretaker IS NOT NULL
				SET @SQLQuery = @SQLQuery + ' AND CU.UserId=@Caretaker'

			IF @ServiceId IS NOT NULL
				SET @SQLQuery = @SQLQuery +' AND ( b.ServiceId = @ServiceId)'

			IF (@FromDate IS NULL) AND (@ToDate IS NULL)
				BEGIN
					IF @Year > 0
						SET @SQLQuery = @SQLQuery +' AND (YEAR(b.BookingDateTime) = @Year)'

					IF (@Year > 0) AND (@Month > 0)
						SET @SQLQuery = @SQLQuery + ' AND (YEAR(b.BookingDateTime) = @Year AND DATEPART(MM, b.BookingDateTime) = @Month)'

						
				END
				if @StatusId = 3 
					BEGIN
					IF (@FromDate IS NOT NULL) AND (@ToDate IS NOT NULL)
						BEGIN
							SET @SQLQuery = @SQLQuery + ' AND (StatusModifiedDate BETWEEN  @FromDate  AND @ToDate' + ')'
						END
					END
				ELSE
					BEGIN
						IF (@FromDate IS NOT NULL) AND (@ToDate IS NOT NULL)
						BEGIN
							SET @SQLQuery = @SQLQuery + ' AND (b.BookingDateTime BETWEEN  @FromDate  AND @ToDate' + ')'
						END
					END

				set @SQLQuery= @SQLQuery + ' group by b.BookingId,b.BookingDateTime,cs.ServiceName,cu.FirstName,
						  cu.LastName,u.FirstName,u.LastName,cua.Location,ua.Location,cps.PayingRate,cps.DisplayRate,
						  b.Status,b.FromDateTime,b.ToDateTime,ct.TypeName,StatusModifiedDate,InvoiceNo,InvoicePath)  t1

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
	
	if @StatusId = 3 
		SET @SQLQuery = @SQLQuery + ' ORDER BY t1.StatusModifiedDate DESC'
	ELSE
		SET @SQLQuery = @SQLQuery + ' ORDER BY t1.BookingDate DESC'

	Set @ParamDefinition = '@StatusId INT,
							@Caretaker NVARCHAR(50),
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
				@StatusId,
				@Caretaker,
				@ServiceId,
				@SearchDateType,
				@Year,
				@Month,
				@FromDate,
				@ToDate
                
    If @@ERROR <> 0
    Set NoCount OFF