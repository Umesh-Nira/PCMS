CREATE PROCEDURE [dbo].[SpUpdateHolidayPay]
	(@HolidayPay float)
AS
 BEGIN
        UPDATE [dbo].[Settings_HolidayPay]
        SET 
         HolidayPayValue  = @HolidayPay
 END