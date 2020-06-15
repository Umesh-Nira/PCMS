CREATE PROC spInsertUpdateCompanySettings(@CompanyId INT = 0,
	@CompanyName NVARCHAR(100),
	@TagLine NVARCHAR(200),
	@AddressLine NVARCHAR(250),
	@CityId INT,
  @ZipCode NVARCHAR(10),
	@PhoneNo1 NVARCHAR(25),
	@PhoneNo2 NVARCHAR(25),
	@EmailAddress NVARCHAR(100),
	@Website NVARCHAR(100),
	@Logo VARBINARY(MAX),
	@Description1 NVARCHAR(500),
	@Description2 NVARCHAR(500),
	@Description3 NVARCHAR(500),
	@CompanyID_OUT INT OUT) AS
BEGIN
	if @CompanyId = 0
		BEGIN
			INSERT INTO Settings_CompanyProfile ([CompanyName]
				   ,[TagLine]
				   ,[AddressLine]
				   ,[CityId]
					,[ZipCode]
				   ,[PhoneNo1]
				   ,[PhoneNo2]
				   ,[EmailAddress]
				   ,[Website]
				   ,[Logo]
				   ,[Description1]
				   ,[Description2]
				   ,[Description3])
			VALUES (@CompanyName,
			@TagLine,
			@AddressLine,
			@CityId,
			@ZipCode,
			@PhoneNo1,
			@PhoneNo2,
			@EmailAddress,
			@Website,
			@Logo,
			@Description1,
			@Description2,
			@Description3)
			SET @CompanyID_OUT=SCOPE_IDENTITY()
		END
	ELSE
		BEGIN
			UPDATE Settings_CompanyProfile SET

			CompanyName = @CompanyName,
			TagLine = @TagLine,
			AddressLine = @AddressLine,
			CityId = @CityId,
			ZipCode = @ZipCode,
			PhoneNo1 = @PhoneNo1,
			PhoneNo2 = @PhoneNo2,
			EmailAddress = @EmailAddress,
			Website = @Website,
			Logo = @Logo,
			Description1 = @Description1,
			Description2 = @Description2,
			Description3 = @Description3

			WHERE CompanyId = @CompanyId

			SET @CompanyID_OUT = @CompanyId
		END
END