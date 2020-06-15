CREATE PROCEDURE [dbo].[SpDeleteServiceDetails] (@ServiceId int = 0)
AS
BEGIN
       DELETE  FROM [dbo].[Settings_CaretakerServices] WHERE ServiceId = @ServiceId
END