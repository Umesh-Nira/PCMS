CREATE PROCEDURE [dbo].[SpGetClientDetailsById] 
(
	@clientID int
)
AS
BEGIN
	DECLARE @Currency VARCHAR(100)
	DECLARE @CurrencySymbol VARCHAR(10)
	declare @payRiseId int
	declare @payRiseDate datetime
	DECLARE @LatestDate date
	DECLARE @maxDate datetime

	IF EXISTS (SELECT 1 from [Settings_Country] WHERE IsDefault = 1)
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where IsDefault = 1
	END
	ELSE
	BEGIN
		SELECT TOP 1 @Currency = Currency, @CurrencySymbol = ISNULL(Symbol,'$')	FROM [dbo].[Settings_Country] c	Where [CountryId] = 1
	END


				select cm.ClientId,
					cm.ClientName,
					cm.ClientStatus,
					L.EmailId,
					cm.UserId,
					cm.WebsiteUrl as WebsiteAddress,
					cm.InvoiceNumber,
					cm.InvoicePrefix,
					cm.HasMidNightCut,
					@Currency as Currency,
					@CurrencySymbol as CurrencySymbol
				from [dbo].[Client_Master] cm
				LEFT JOIN [dbo].[User_LoginDetails] L ON L.UserId = cm.UserId
				where cm.ClientId=@clientID

				select ca.*, c.CityId, c.CityName, s.StateId,s.StateName, cn.CountryId, cn.CountryName from Client_AddressDetails ca
				LEFT JOIN [dbo].[Settings_City] C ON CA.CityId = C.CityId 
				LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
				LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
				where ca.ClientId = @clientID

				
			SELECT  @maxDate=MAX([Payrisedate]) FROM [Client_Invoice_Payrise] WHERE Payrisedate<=(SELECT GETDATE()) AND  [ClientId] = @ClientId	
			IF @maxDate IS NULL
			begin
			SELECT TOP 1 @payRiseId=[PayriseId],@payRiseDate = [Payrisedate] FROM [Client_Invoice_Payrise] WHERE Payrisedate IS NULL  AND   [ClientId] = @ClientId	
			END
			ELSE
			begin
			SELECT top 1 @payRiseId=[PayriseId],@payRiseDate = [Payrisedate] FROM [Client_Invoice_Payrise] WHERE Payrisedate = @maxDate  AND  [ClientId] = @ClientId			
			END

	SELECT @payRiseId =  [PayriseId],
			@payRiseDate = [PayriseDate]
	FROM [dbo].[Client_Invoice_Payrise]
	WHERE [ClientId] = @ClientId
	and [PayriseDate] = (select MAX([PayriseDate]) from [Client_Invoice_Payrise] where [ClientId] = @ClientId and Payrisedate<=(SELECT GETDATE()))

		SELECT
		Isnull([Rate],0) AS Rate,
		cir.[CaretakerTypeId] as CategoryId,
		cp.[TypeName] as CategoryName,
		@payRiseDate as EffectiveFrom,
		@ClientId as ClientId,
		[IsTaxApplicable]
	FROM [dbo].[Client_Invoice_Rates] cir 
	Right JOIN [dbo].[Settings_CaretakerType] cp on cp.[TypeId] = cir.[CaretakerTypeId]
		WHERE [ClientId] = @ClientId and [InvoicePayriseId] = @payRiseId and Rate!=0
	


				 --select tr.ClientRateId,
					--	tr.CaretakerTypeId as CategoryId,
					--	tr.Rate,
					--	tr.IsTaxApplicable,
					--	ct.TypeName as CategoryName
				 --from [dbo].[Client_CaretakerType_Rate] tr
				 --inner join [dbo].[Settings_CaretakerType] ct on ct.TypeId = tr.CaretakerTypeId
				 --where tr.ClientId = @clientID
				
				 select distinct cpr.[CaretakerId] as CaretakerId,
					u.FirstName + ' '+ u.LastName as CareTakerName,
					cd.CaretakerTypeId as CategoryTypeId,
					ct.TypeName as CategoryName,
					cd.ProfileId as CaretakerProfileId,
					cd.TotalExperience,
					CN.CountryName as CareTakerCountryName
				 from [dbo].[Caretaker_Payroll_Rates] cpr 
				 inner join [dbo].[Caretaker_Details] cd on cd.UserId=cpr.[CaretakerId]
				 inner join [dbo].[UserDetails_Master] u on cd.UserId = u.UserId
				 inner join [dbo].[Settings_CaretakerType] ct on ct.TypeId = cd.CaretakerTypeId
				 inner join [dbo].[User_AddressDetails] ud on ud.UserId = cpr.[CaretakerId]
					LEFT JOIN [dbo].[Settings_City] C ON C.CityId = Ud.CityId 
					LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
					LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
				 where cpr.ClientId = @clientID AND cpr.[MapStatus]=1

		 
;WITH CTE AS 
(
	select cpr.[CaretakerId] as CaretakerId,
		 u.FirstName + ' '+ u.LastName as CareTakerName,
		 ct.TypeName as CategoryName,
		 cpr.[Rate] as Rate,
		 cpr.[ShiftId] as WorkShiftId,
		 cpp.[PayriseDate] as EffectiveFrom,
		 ws.WorkShiftName as WorkShiftName,
		 RANK() OVER(PARTITION BY cpr.[CaretakerId] ORDER BY cpp.[PayriseDate] DESC) AS RANK
		 from [dbo].[Caretaker_Payroll_Rates] cpr 
		 inner join [dbo].[Settings_WorkShift] ws ON ws.WorkShiftId=cpr.ShiftId
		 inner join [dbo].[Caretaker_Details] cd on cd.UserId=cpr.[CaretakerId]
		 inner join [dbo].[UserDetails_Master] u on cd.UserId = u.UserId
		 inner join [dbo].[Settings_CaretakerType] ct on ct.TypeId = cd.CaretakerTypeId
		 inner join [dbo].[Caretaker_Payroll_Payrise] cpp on cpr.[PayrollPayriseId] = cpp.[PayriseId]
		 where cpr.ClientId = @clientID AND cpr.[MapStatus]=1
)

select CaretakerId,CareTakerName,CategoryName,Rate,WorkShiftId,EffectiveFrom,WorkShiftName from CTE where RANK=1

				 select cs.ClientShiftId,
					cs.ShiftId as TimeShiftId,
					st.TimeShiftName
				 from [dbo].[Client_ShiftDetails] cs
				 INNER JOIN [dbo].[Settings_TimeShift] st ON st.TimeShiftId = cs.ShiftId
				 where cs.ClientId = @clientID
END