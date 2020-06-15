/*
--------------------------------------------------------------------------------------
< Select Caretakers For Search >

Author				: Ranjit
Created Date		: 

Last Updated BY		: NOWFAL S R
Last Updated Date	: 02-AUGUST-2018
Updation			: Avoid duplicate caretakers

Last Updated BY		: NOWFAL S R
Last Updated Date	: 03-AUGUST-2018
Updation			: Need not check CaretakerNonAvailability table if there is no data

Last Updated BY		: NOWFAL S R
Last Updated Date	: 20-AUGUST-2018
Updation			: Location wise search using LIKE operator

Last Updated BY		: NOWFAL S R
Last Updated Date	: 21-AUGUST-2018
Updation			: Joined CaretakerService with Service table, added service name

Last Updated BY		: RANJIT
Last Updated Date	: 30-AUGUST-2018
Updation			: Ambiguos name ServiceId

Last Updated BY		: RANJIT
Last Updated Date	: 06-September-2018
Updation			: Search location in Address and Location
-----------------------------------------------------------------------------------------
*/
--[dbo].[spSelectCaretakersForSearch] null,null,null,null,null,null,null,null,null,null,null,'12/22/2018 8:00:00 PM','12/22/2018 8:30:00 PM'
-- [dbo].[spSelectCaretakersForSearch] null,null,null,null,null,null,null,null,null,null,null,'08/21/2018','08/21/2018'
CREATE PROCEDURE [dbo].[spSelectCaretakersForSearch]-- null,null,null,null,null,null,null,null,null,null,null,'12/22/2018 8:00:00 AM','12/22/2018 8:30:00 PM'
(
		@CategoryId int,
		@ServiceId int,
		@ServiceRate numeric(18,2),
		@MinExperience numeric(18,2),
		@MaxExperience numeric(18,2),
		@ProfileId nvarchar(30),
		@GenderId int,
		@CountryId int,
		@StateId int,
		@CityId int,
		@Location nvarchar(50),
		@fromdate datetime,
		@todate datetime)
        
AS
    Set NoCount ON
    /* Variable Declaration */

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
   	
    Set @SQLQuery = '	SELECT DISTINCT U.FirstName AS CareTakerFirstName, 
								U.LastName AS CareTakerLastName, 
								CAST(U.ProfilePic AS VARBINARY(MAX)) AS ProfilePicture,
								U.ProfilePicPath,
								U.Gender, 
								C.TotalExperience, 
								b.DisplayRate, 
								b.ServiceId,
								cat.TypeName AS Category,
								C.UserId AS CaretakerId, 
								S.ServiceName AS ServiceName,
								'''+@Currency+''' as Currency,
								'''+@CurrencySymbol+''' as CurrencySymbol,
								UA.Location,
								ST.StateName as State
							FROM 
							   (select [CaretakerId],max(Payrisedate) as [Payrisedate],[PayriseId] from [dbo].[Caretaker_Booking_Payrise]
								where [Payrisedate]<=GETUTCDATE() 
								group by [CaretakerId],[PayriseId]) a,[Caretaker_Booking_Rates]b,[dbo].[UserDetails_Master] U,[dbo].[Caretaker_Details] C,[dbo].[Settings_CaretakerType]cat,[dbo].[Settings_CaretakerServices] S,
								[dbo].[User_AddressDetails] UA,[dbo].[Settings_City] CT,[dbo].[Settings_State] ST
								where a.CaretakerId=b.CaretakerId and a.[PayriseId]=b.BookingPayRiseId and a.CaretakerId=u.UserId and a.CaretakerId=C.UserId
								and cat.TypeId = C.CaretakerTypeId and b.ServiceId=S.ServiceId and UA.UserId = U.UserId and CT.CityId = UA.CityId and ST.StateId = CT.StateId
								and C.CaretakerStatus = 2 AND U.UserStatus = 1 AND C.IsPrivate = ''False''' 

    /* check for the condition and build the WHERE clause accordingly */
    If @CategoryId Is Not Null 
         Set @SQLQuery = @SQLQuery + ' And (C.CaretakerTypeId = @CategoryId)'

    If @ServiceId Is Not Null  
         Set @SQLQuery = @SQLQuery + ' And (b.ServiceId = @ServiceId)' 

    If @ServiceRate Is Not Null
         Set @SQLQuery = @SQLQuery + ' And (b.DisplayRate = @ServiceRate)'
  
    If @MinExperience Is Not Null AND @MaxExperience Is Not Null
         Set @SQLQuery = @SQLQuery + ' And (C.TotalExperience BETWEEN @MinExperience AND @MaxExperience)'
  
    If @ProfileId Is Not Null
         Set @SQLQuery = @SQLQuery + ' And (C.ProfileId = @ProfileId)'

	If @GenderId Is Not Null
         Set @SQLQuery = @SQLQuery + ' And (U.Gender = @GenderId)'
  
    If @StateId Is Not Null
         Set @SQLQuery = @SQLQuery + ' And (CT.StateId = @StateId)'

    If @CountryId Is Not Null 
         Set @SQLQuery = @SQLQuery + ' And (ST.CountryId = @CountryId)'

	If @CityId Is Not Null
         Set @SQLQuery = @SQLQuery + ' And (UA.CityId = @CityId)'

    If @Location Is Not Null
			Set @SQLQuery = @SQLQuery + 'AND (UA.Location LIKE ''%' + @Location +'%'')'

   if  @fromdate is not null
             set @SQLQuery =@SQLQuery + ' And c.UserId not in (select CaretakerUserId from PublicUser_Caretaker_Booking 
							where status = 1 and 
							 FromDateTime < @todate
						and @fromdate < ToDateTime) And c.UserId not in (select CaretakerUserId from Client_Scheduling 
							where (@fromdate BETWEEN StartDateTime AND EndDateTime
							 OR @todate BETWEEN  StartDateTime AND EndDateTime  ))'
	
    Set @ParamDefinition = '@CategoryId int,
							@ServiceId int,
							@ServiceRate numeric(18,2),
							@MinExperience numeric(18,2),
							@MaxExperience numeric(18,2),
							@ProfileId nvarchar(30),
							@GenderId int,
							@CountryId int,
							@StateId int,
							@CityId int,
							@Location nvarchar(50),
							@fromdate datetime,
							@todate datetime'
    /* Execute the Transact-SQL String with all parameter value's 
       Using sp_executesql Command */
 Execute sp_Executesql @SQLQuery,
                @ParamDefinition,
				@CategoryId,
				@ServiceId,
				@ServiceRate,
				@MinExperience,
				@MaxExperience,
				@ProfileId,
				@GenderId,
				@CountryId,
				@StateId,
				@CityId,
				@Location,
				@fromdate,
				@todate
                
    If @@ERROR <> 0
    Set NoCount OFF