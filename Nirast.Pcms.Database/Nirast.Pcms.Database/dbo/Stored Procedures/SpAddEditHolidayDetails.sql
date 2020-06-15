/*
-----------------------------------------------------------------------------------
< Insert/Update holiday details >

Author				: Nowfal S R
Created Date		: 10-August-2018

Last Updated BY		: 
Last Updated Date	: 
Updation			: 
-----------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpAddEditHolidayDetails] 
(
	@HolidayId INT = 0,
	@Holiday NVARCHAR(50),
	@HolidayDate DATETIME,
	@CountryId INT,
	@StateId INT
)
AS
BEGIN
	IF @HolidayId = 0
		BEGIN
			INSERT INTO [dbo].Settings_Holidays
			   (
				   [HolidayName],
				   [HolidayDate],
				   CountryId,
				   StateId
				)
			VALUES
			   (
				   @Holiday,
				   @HolidayDate,
				   @CountryId,
				   @StateId
				)
				SELECT CAST(SCOPE_IDENTITY() AS INT)
		END
	ELSE
		BEGIN
			UPDATE [dbo].Settings_Holidays
			SET
				HolidayName = @Holiday,
				HolidayDate = @HolidayDate,
				CountryId = @CountryId,
				StateId = @StateId
			WHERE HolidayId = @HolidayId
		END	
END