CREATE PROCEDURE [dbo].[spInsertCareReceipentDetails] (@BookingId INT,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@HouseName nvarchar(100),
	@Location nvarchar(50),
	@CityId int,
	@ZipCode nvarchar(15),
	@PrimaryPhoneNo nvarchar(20),
	@SecondaryPhoneNo nvarchar(20),
	@EmailAddress nvarchar(50),
	@Purpose nvarchar(max)
)
AS
BEGIN
INSERT INTO [dbo].PublicUser_CareRecipientDetails
           ([BookingId]
           ,[FirstName]
           ,[LastName]
           ,[HouseName]
           ,[Location]
           ,[CityId]
           ,[Zipcode]
           ,Phone1
           ,Phone2
           ,[EmailId]
           ,Purpose)
     VALUES
           (@BookingId,
           @FirstName, 
           @LastName,
           @HouseName,
           @Location,
           @CityId,
           @ZipCode,
           @PrimaryPhoneNo,
           @SecondaryPhoneNo,
           @EmailAddress,
           @Purpose)
END