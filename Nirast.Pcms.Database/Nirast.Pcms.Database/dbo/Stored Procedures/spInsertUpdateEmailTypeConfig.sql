CREATE PROC [dbo].[spInsertUpdateEmailTypeConfig] 
(
    @ConfigId INT,
	@EmailTypeId INT,
	@FromEmail NVARCHAR(50),
	@Password NVARCHAR(max),
		
	@ConfigID_OUT INT OUT) 
	AS
BEGIN
	if @ConfigId = 0
		BEGIN
		
			INSERT INTO [dbo].[Settings_EmailTypeConfiguration] (
				  [EmailTypeId],
			      [FromEmail],
				  [Password]
				  )
				
			VALUES (
			@EmailTypeId,
			@FromEmail,
			@Password
			)
			
			SET @ConfigID_OUT=SCOPE_IDENTITY()
		END
		
	ELSE
		BEGIN
		
			UPDATE   [dbo].[Settings_EmailTypeConfiguration] SET
			EmailTypeId = @EmailTypeId,
			FromEmail = @FromEmail,
			Password = @Password
			
			WHERE ConfigId = @ConfigId
			SET @ConfigID_OUT = @ConfigId
		END
		END