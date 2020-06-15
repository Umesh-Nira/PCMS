/*
--------------------------------------------------------------------------------------------------
Author				: Geethu
Created Date		: 27-09-2018

Last Updated BY		: 
Last Updated Date	: 

This Stored Procedure calling from:	
----------------------------------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpDeleteHoliday]
(
	@HolidayId int
)
AS
BEGIN
	
		DELETE [dbo].Settings_Holidays
		WHERE  HolidayId = @HolidayId
END