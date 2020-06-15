CREATE PROC [dbo].[spInsertUpdateConfigDetails] 
(
    @ConfigId INT,
	@MailHost NVARCHAR(max),
	@MailPort INT,
	@SSL bit,
	@ConfigName NVARCHAR(max),
		
	@ConfigID_OUT INT OUT) 
	AS
BEGIN
	if @ConfigId = 0
		BEGIN
		
			INSERT INTO [dbo].[Settings_EmailConfiguration] (
				  [ConfigName],
			      [MailHost],
				  [MailPort],
				  [SSL]
				  )
				
			VALUES (
			@ConfigName,
			@MailHost,
			@MailPort,
			@SSL
			)
			
			SET @ConfigID_OUT=SCOPE_IDENTITY()
		END
		
	ELSE
		BEGIN
		
			UPDATE   [dbo].[Settings_EmailConfiguration] SET
			ConfigName = @ConfigName,
			MailHost = @MailHost,
			MailPort = @MailPort,
			SSL=@SSL
			
			WHERE ConfigId = @ConfigId
			SET @ConfigID_OUT = @ConfigId
		END
		END