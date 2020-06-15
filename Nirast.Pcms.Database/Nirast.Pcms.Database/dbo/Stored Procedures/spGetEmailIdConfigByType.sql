CREATE PROC [dbo].[spGetEmailIdConfigByType] 
	(
	@emailType INT
	) 
AS
BEGIN

SELECT * FROM [dbo].[Settings_EmailTypeConfiguration] where EmailTypeId=@emailType
  END