CREATE PROCEDURE [dbo].[SpGetDisplayRate]
AS
BEGIN
	SELECT  DISTINCT  DisplayRate 
	FROM [dbo].[Caretaker_PublicUser_Service]
END