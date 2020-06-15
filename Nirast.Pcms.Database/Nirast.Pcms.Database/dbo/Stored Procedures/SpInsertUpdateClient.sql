
CREATE PROCEDURE [dbo].[SpInsertUpdateClient] 
	(@ClientId int = 0,
	@ClientName nvarchar(100),
	@BuildingName1 nvarchar (500),
	@CityId1 int,
	@PrimaryPhone1 nvarchar(20),
	@BuildingName2 nvarchar (500),
	@CityId2 int = null,
	@PrimaryPhone2 nvarchar(20),
	@EmailAddress nvarchar (50),
	@WebsiteAddress nvarchar(50),
	@SecondaryPhone1 nvarchar(500),
	@SecondaryPhone2 nvarchar(500),
	@InvoiceNumber INT,
	@HasMidnightCut BIT,
	@InvoicePrefix nvarchar(10),
	@UserId int,
    @ClientId_OUT INT OUT)
	
AS
BEGIN
	
      --========================================================================= CLIENT INSERTION START =============================================================
      IF @ClientId = 0
      BEGIN	 
        INSERT INTO [dbo].Client_Master
		(
		    ClientName,
			WebsiteUrl,
			InvoiceNumber,
			HasMidNightCut,
			InvoicePrefix,
			UserId
		)
        VALUES
		  (
			@ClientName,
			@WebsiteAddress,
			@InvoiceNumber 	,	
			@HasMidnightCut ,
			@InvoicePrefix,
			@UserId	        
		  )
		SET @ClientId_OUT=SCOPE_IDENTITY()
      END
      --=========================================================================CLIENT INSERTION END===============================================================

      --=========================================================================CLIENT UPDATE START================================================================

      ELSE
      BEGIN
        UPDATE [dbo].Client_Master
        SET ClientName = @ClientName,
			WebsiteUrl= @WebsiteAddress,
			InvoiceNumber 	 =  @InvoiceNumber ,			      
			HasMidNightCut  =  @HasMidnightCut ,			      
			InvoicePrefix =  @InvoicePrefix	 
			where ClientId=@ClientId

			SET @ClientId_OUT=@ClientId

      END
      --=========================================================================CLIENT UPDATE END================================================================
	  --=========================================================================CLIENT Address Delete Insert================================================================

	  DELETE FROM [Client_AddressDetails] WHERE ClientId = @ClientId_OUT
	  INSERT INTO [dbo].[Client_AddressDetails]
			(
				ClientId,
				BuildingName,
				[CityId],
				[Phone1],
				[Phone2]
			)
			VALUES
			(
				@ClientId_OUT,
				@BuildingName1,
				@CityId1,
				@PrimaryPhone1,
				@PrimaryPhone2
			
			)
		INSERT INTO [dbo].[Client_AddressDetails]
			(
				ClientId,
				BuildingName,
				[CityId],
				[Phone1],
				[Phone2]
			)
			VALUES
			(
				@ClientId_OUT,
				@BuildingName2,
				@CityId2,
				@SecondaryPhone1,
				@SecondaryPhone2
				
			)
END