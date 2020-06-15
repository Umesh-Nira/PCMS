--SpAddEditCountryDetails 0,'AU','AUSTRAILIA',7,7
CREATE PROCEDURE [dbo].[SpAddEditCountryDetails] 
(
	@CountryId INT = 0,
	@Code NVARCHAR(50),
	@Name NVARCHAR(50),
	@PhoneCode VARCHAR(10),
	@Currency VARCHAR(50),
	@Symbol NVARCHAR(50),
	@IsDefault BIT
)
AS
BEGIN
	IF(@IsDefault = 'True')
				BEGIN
					UPDATE [Settings_Country]
					SET [IsDefault] = 'False'
				END
	IF @CountryId = 0
		BEGIN			
			INSERT INTO [dbo].[Settings_Country]
			   (
				   [CountryCode]
				   ,[CountryName]
				   ,[PhoneCode]
				   ,[Currency]
				   ,[Symbol]
				   ,[IsDefault]
				)
			VALUES
			   (
				   @Code,
				   @Name,
				   @PhoneCode,
				   @Currency,
				   @Symbol,
				   @IsDefault
				)
				SELECT CAST(scope_identity() AS int)				
		END
	ELSE
		BEGIN
			UPDATE [dbo].[Settings_Country]
			SET
				[CountryCode] = @Code,
				[CountryName] = @Name,
				[PhoneCode] = @PhoneCode,
				[Currency] = @Currency,
				Symbol = @Symbol,
				[IsDefault] = @IsDefault
			WHERE CountryId = @CountryId
			SELECT @CountryId
		END	
END