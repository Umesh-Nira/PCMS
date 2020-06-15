/*
-----------------------------------------------------------------------------------
< Activate/deactivate a user record by the user registration id >
@RecordStatus=1 ==> Activate, @RecordStatus=1 ==> De-activate

Author				: NOWFAL S R
Created Date		: 08-AUGUST-2018

Last Updated BY		: 
Last Updated Date	: 
Updation			: 
-----------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[spVerifyUserByUserId]
(
	@UserVerified BIT,
	@UserRegistrationId INT
)
AS
BEGIN
	DECLARE @IsVerified AS INT
	IF (SELECT COUNT(UserId) FRom [UserDetails_Master] WHERE UserId=@UserRegistrationId) > 0
		BEGIN
		SET @IsVerified = (SELECT Count(UserId) FROM [UserDetails_Master] WHERE UserId = @UserRegistrationId AND IsVerified = 1) 
		IF @IsVerified > 0
			BEGIN
				SELECT 2
			END
		ELSE
			BEGIN
				UPDATE [dbo].[UserDetails_Master] 
				SET IsVerified = @UserVerified 
				WHERE UserId = @UserRegistrationId
				SELECT 1
			END
		END
	ELSE
		BEGIN 
			SELECT 3
		END
END