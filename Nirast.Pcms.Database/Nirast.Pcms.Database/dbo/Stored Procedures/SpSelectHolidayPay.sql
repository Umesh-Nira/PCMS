CREATE PROCEDURE [dbo].[SpSelectHolidayPay]
AS
BEGIN

	SELECT TOP 1 HolidayPayValue 
	FROM [dbo].[Settings_HolidayPay]
END