CREATE PROC [dbo].[spGetConfigDetails] 

	AS
BEGIN
	SELECT * FROM [dbo].[Settings_EmailConfiguration]
		END