CREATE PROC [dbo].[spInsertUpdateResidentDetails] 
(
    @ResidentId INT,
	@ClientId INT,
	@ResidentName NVARCHAR(100),
	@OtherInfo NVARCHAR(MAX),
	@ResidentID_OUT INT OUT) 
	AS
BEGIN
	if @ResidentId = 0
		BEGIN
			INSERT INTO  [dbo].[Settings_Resident](
				   [ClientId],
			       [ResidentName],
	               [OtherInfo])

				
			VALUES (
			@ClientId,
			@ResidentName,
	        @OtherInfo)
			
			SET @ResidentID_OUT=SCOPE_IDENTITY()
		END
	ELSE
		BEGIN
			UPDATE   [dbo].[Settings_Resident] SET

			ClientId = @ClientId,
			ResidentName = @ResidentName,
			OtherInfo = @OtherInfo
			WHERE ResidentId = @ResidentId
			SET @ResidentID_OUT = @ResidentId
		END
END

