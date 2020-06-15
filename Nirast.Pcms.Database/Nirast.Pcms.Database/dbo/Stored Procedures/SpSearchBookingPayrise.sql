--[SpSearchBookingPayrise]  
CREATE PROCEDURE [dbo].[SpSearchBookingPayrise]  (
	
	@CaretakerId int,
	@ServiceId int,
	@EffectiveFrom datetime
	
)
AS
BEGIN

	Declare @SQLQuery AS NVarchar(4000)
    Declare @ParamDefinition AS NVarchar(2000) 
	

	
	Set @SQLQuery = '
	  DECLARE @Currency VARCHAR(100)
	DECLARE @CurrencySymbol VARCHAR(10)
						   IF EXISTS (SELECT 1 from [Settings_Country] WHERE IsDefault = 1)
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,$)	FROM [dbo].[Settings_Country] c	Where IsDefault = 1
	END
	ELSE
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,$)	FROM [dbo].[Settings_Country] c	Where [CountryId] = 1
	END
		
	                SELECT
					  cbp.PayriseId AS BookingPayriseId,
					  cbp.Payrisedate AS EffectiveFromDate,
					  cbp.CaretakerId,
					  udm.FirstName+  + udm.LastName AS CaretakerName,
					  cbr.ServiceId,
					  scs.ServiceName AS Service,
					  cbr.DisplayRate,
					  cbr.PayingRate,
			          @Currency as Currency,
				      @CurrencySymbol as CurrencySymbol
					  FROM [dbo].[Caretaker_Booking_Payrise] cbp 
					  LEFT JOIN [dbo].[Caretaker_Booking_Rates] cbr on cbr.BookingPayRiseId = cbp.PayriseId
					  LEFT JOIN  [dbo].[Caretaker_Details]cd on cd.UserId = cbp.CaretakerId
					  LEFT JOIN [dbo].[UserDetails_Master]udm on udm.UserId = cd.UserId
					  LEFT JOIN [dbo].[Settings_CaretakerServices]scs on scs.ServiceId = cbr.ServiceId
					    where (1=1)
					 '

		IF(@CaretakerId IS NOT NULL)
		Set @SQLQuery=@SQLQuery + ' AND (cbr.[CaretakerId] = @CaretakerId)'

		IF(@ServiceId IS NOT NULL)
		Set @SQLQuery=@SQLQuery + ' AND (cbr.[ServiceId] = @ServiceId)'

		IF(@EffectiveFrom IS NOT NULL)
		Set @SQLQuery=@SQLQuery + ' AND (cbp.[Payrisedate] = @EffectiveFrom)'


	    Set @ParamDefinition = '@CaretakerId int,
							@ServiceId int,
							@EffectiveFrom datetime'
		PRINT @SQLQuery
		Execute sp_Executesql @SQLQuery, 
					@ParamDefinition,
					@CaretakerId,
					@ServiceId,
					@EffectiveFrom
			
                
		If @@ERROR <> 0
		Set NoCount OFF
END