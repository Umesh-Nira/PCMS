CREATE PROC [dbo].[SpSearchCaretakerBookingHistory]-- null,null,null,null,null
	(@ServiceId INT,
	@Year INT,
	@Month INT,
	@FromDate DATETIME,
	@ToDate DATETIME) AS
Set NoCount ON
    /* Variable Declaration */
    Declare @SQLQuery AS NVarchar(4000)
	Declare @ParamDefinition AS NVarchar(2000) 
	SET @SQLQuery = 'SELECT	    format(b.BookingDateTime,''dd-MMM-yyyy'') as BookingDate,
								cs.ServiceName AS Service,
								u.FirstName +'' '' +u.LastName as BookedBy, 
								ua.Location as UserLocation,
								cu.FirstName +'' ''+ cu.LastName as Caretaker,
								cua.Location as CaretakerLocation,
								b.Status as BookingStatus,
								format(b.FromDateTime,''hh:mm tt'') as FromTime,
								format(b.ToDateTime,''hh:mm tt'') as ToTime,
								b.FromDateTime,
								ToDateTime,
								cast((DateDiff(minute,b.FromDateTime,ToDateTime) / 60.0) as decimal(10,2))  as TotalHours
							  FROM [dbo].[PublicUser_Caretaker_Booking] b
						      --LEFT JOIN  [dbo].[PublicUser_Booking_Dates] pbd on pbd.BookingId=b.BookingId
							  INNER JOIN [dbo].[Settings_CaretakerServices] cs on cs.ServiceId = b.ServiceId
							  INNER JOIN [dbo].[UserDetails_Master] U on u.UserId = b.PublicUserId
							  INNER JOIN [dbo].[User_AddressDetails] ua on ua.UserId = b.PublicUserId
							  INNER JOIN [dbo].[UserDetails_Master] CU on cu.UserId = b.CaretakerUserId
							  INNER JOIN [dbo].[User_AddressDetails] cua on cua.UserId = b.CaretakerUserId
						  WHERE (1=1) '


	print @SQLQuery

			IF @ServiceId IS NOT NULL
				SET @SQLQuery = @SQLQuery +' AND ( b.ServiceId = @ServiceId)'

			IF @Year > 0
				SET @SQLQuery = @SQLQuery +' AND (YEAR(b.BookingDateTime) = @Year)'

			IF (@Year > 0) AND (@Month > 0)
				SET @SQLQuery = @SQLQuery + ' AND (YEAR(b.BookingDateTime) = @Year AND DATEPART(MM, b.BookingDateTime) = @Month)'

			IF (@FromDate IS NOT NULL) AND (@ToDate IS NOT NULL)
				SET @SQLQuery = @SQLQuery + ' AND (b.BookingDateTime BETWEEN  @FromDate AND @ToDate' + ')'

				--set @SQLQuery= @SQLQuery + ' group by b.BookingId,b.BookingDateTime,cs.ServiceName,cu.FirstName,
				--		  cu.LastName,u.FirstName,u.LastName,cua.Location,ua.Location,
				--		  b.Status,b.FromDateTime,b.ToDateTime)'
	
	
	SET @SQLQuery = @SQLQuery + ' ORDER BY BookingDate DESC'

	Set @ParamDefinition = '@ServiceId INT,
							@Year INT,
							@Month INT,
							@FromDate DATETIME,
							@ToDate DATETIME'
    /* Execute the Transact-SQL String with all parameter value's 
       Using sp_executesql Command */
    Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@ServiceId,
				@Year,
				@Month,
				@FromDate,
				@ToDate
                
    If @@ERROR <> 0
    Set NoCount OFF