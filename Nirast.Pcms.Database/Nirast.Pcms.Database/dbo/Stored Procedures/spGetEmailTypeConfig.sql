CREATE PROC [dbo].[spGetEmailTypeConfig] 

	AS
BEGIN
	SELECT * FROM [dbo].[Settings_EmailTypeConfiguration]
		END