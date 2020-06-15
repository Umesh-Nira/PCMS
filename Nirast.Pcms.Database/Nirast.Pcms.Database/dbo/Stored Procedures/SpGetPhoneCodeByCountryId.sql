CREATE PROCEDURE [dbo].[SpGetPhoneCodeByCountryId] 
(
	@CountryId int
)
AS
BEGIN
select
PhoneCode
FROM [dbo].[Settings_Country]
WHERE
CountryId = @CountryId
END
