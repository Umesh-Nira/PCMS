Create PROCEDURE [dbo].[SpSelectIntervalHours]
AS
BEGIN

	SELECT TOP 1 IntervalHours 
	FROM [dbo].[Settings_IntervalHours]
END