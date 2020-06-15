CREATE PROC SpOverrideHoliday AS
BEGIN
SELECT HolidayName,HolidayDate,CountryId, StateId INTO #NewHoliday FROM [dbo].[Settings_Holidays] WHERE YEAR(HolidayDate) = YEAR(GETUTCDATE())
UPDATE #NewHoliday SET HolidayDate = DATEADD(YEAR,1,HolidayDate)
INSERT INTO [Settings_Holidays] (HolidayName,HolidayDate,CountryId,StateId)
SELECT HolidayName,HolidayDate,CountryId,StateId FROM #NewHoliday
IF OBJECT_ID('tempdb..#NewHoliday') IS NOT NULL DROP Table #NewHoliday
SELECT @@ROWCOUNT
END