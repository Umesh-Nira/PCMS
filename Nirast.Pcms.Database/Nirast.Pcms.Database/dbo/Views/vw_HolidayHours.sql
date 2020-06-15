
CREATE view [dbo].[vw_HolidayHours] as
		select csd.SchedulingId,
			sum(csd.Hours) as HoildayHours,
			case when sum(csd.Hours) >=8 
					then (SELECT TOP 1 IntervalHours FROM [dbo].[Settings_IntervalHours])
					else '0' end as HolidayRestTime,
			sum(Hours*shp.HolidayPayValue)  as HolidayAmount,
			isnull(shp.HolidayPayValue,0) as HolidayPayValue,
			sh.CountryId
		from Settings_Holidays sh
		 JOIN Client_Scheduling_Dates csd on cast(csd.Date as date)=sh.HolidayDate
		 JOIN Settings_HolidayPay shp on shp.HolidayPayId=shp.HolidayPayId
		 join [dbo].[Client_Scheduling] B on B.SchedulingId = csd.SchedulingId
		 JOIN [dbo].[UserDetails_Master] CU on cu.UserId = b.CaretakerUserId
		 JOIN [dbo].[User_AddressDetails] cua on cua.UserId = b.CaretakerUserId
		 JOIN [dbo].[Settings_City] cuc on cuc.CityId = cua.CityId
		 JOIN [dbo].[Settings_State] cus on cus.StateId = cuc.StateId and cus.CountryId = sh.CountryId
		 WHERE Sh.StateId IS NULL OR Sh.StateId = cuc.StateId
		 group by csd.SchedulingId,sh.CountryId,shp.HolidayPayValue