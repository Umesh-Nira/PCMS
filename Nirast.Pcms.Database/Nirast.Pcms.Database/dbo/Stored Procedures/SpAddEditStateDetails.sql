/*
-----------------------------------------------------------------------------------
< Save and Update state details, including tax amount >

Author				: 
Created Date		: 

Last Updated BY		: Nowfal S R
Last Updated Date	: 09-August-2018
Updation			: Included tax amount
-----------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpAddEditStateDetails] 
(
	@StateId INT = 0,
	@CountryId INT = 0,
	@Code NVARCHAR(50),
	@Name NVARCHAR(50),
	@TaxPercent NUMERIC(18, 2)
)
AS
BEGIN
	IF @StateId = 0
		BEGIN
			INSERT INTO [dbo].Settings_State
			   ([CountryId]
			   ,[StateCode]
			   ,[StateName]
			   ,[TaxPercent])
			VALUES
			   (@CountryId,
				@Code,
			    @Name,
			   @TaxPercent)
		END
	ELSE
		BEGIN
			UPDATE [dbo].Settings_State
			SET
				CountryId = @CountryId,
				StateCode = @Code,
				StateName = @Name,
				TaxPercent = @TaxPercent
			WHERE StateId = @StateId
		END
END