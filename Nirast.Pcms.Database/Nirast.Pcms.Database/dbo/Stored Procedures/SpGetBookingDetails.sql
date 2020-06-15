--[SpGetBookingDetails]1006,'12/11/2018  00:01:00 AM', '12/12/2018  11:59:00 PM'
CREATE PROCEDURE [dbo].[SpGetBookingDetails]
(
	@CaretakerId int,
	@FromDate DATETIME,
	@ToDate DATETIME
)
AS
BEGIN
	Declare @SQLQuery AS NVarchar(4000)
    Declare @ParamDefinition AS NVarchar(2000) 
	Set @SQLQuery = 'SELECT    
		pcb.BookingId,
		 format(pcb.BookingDateTime,''dd/MMM/yyyy'') AS BookingDate,
		um.FirstName + '' '' + um.LastName  AS ''BookedUser'',
		scs.ServiceName AS ''Service'',
		uad.Location,
		pcb.FromDateTime,
		pcb.ToDateTime
		FROM
	    [dbo].[PublicUser_Caretaker_Booking]pcb
		INNER JOIN	[dbo].[UserDetails_Master]um	     ON 	um.UserId=pcb.PublicUserId
		INNER JOIN [dbo].[Settings_CaretakerServices]scs ON 	scs.ServiceId=pcb.ServiceId
		INNER JOIN [dbo].[User_AddressDetails]uad        ON 	uad.UserId=pcb.PublicUserId
		WHERE pcb.CaretakerUserId = @CaretakerId'

	IF(@FromDate IS NOT NULL AND @ToDate IS NOT NULL)
	BEGIN
		Set @SQLQuery = @SQLQuery + ' And (pcb.FromDateTime >= @FromDate AND pcb.FromDateTime <= @ToDate )'
	END
		Set @SQLQuery = @SQLQuery + ' ORDER BY pcb.FromDateTime ASC'
	Set @ParamDefinition = '@CaretakerId int,
							@FromDate DATETIME,
							@ToDate DATETIME'
	PRINT @SQLQuery
	Execute sp_Executesql @SQLQuery, 
                @ParamDefinition,
				@CaretakerId,
				@FromDate,
				@ToDate
                
    If @@ERROR <> 0
    Set NoCount OFF
END