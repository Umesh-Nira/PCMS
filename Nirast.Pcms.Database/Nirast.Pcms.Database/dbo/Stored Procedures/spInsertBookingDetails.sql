/*
---------------------------------------------------------------------------------------------------------
< Add a new record or update an existing record in UsersDetails based on user's choice >
Author  			: Renjith
Created Date		: 

Updated BY			: Sethu 
Updated Date		: 

Updated BY			:  
Updated Date		: 

  
This Stored Procedure calling from:	
-----------------------------------------------------------------------------------------------------------
*/

CREATE PROCEDURE [dbo].[spInsertBookingDetails] 
(
	@CareTakerId int,
	@ServiceRequiredId int,
	@BookedUserId INT,
	@BookingDate Datetime,
	@BookingStartTime Datetime,
	@BookingEndTime Datetime,
	@Status int,
	@BookingId_OUT INT OUT)
AS
BEGIN


	IF EXISTS  (select CaretakerUserId from PublicUser_Caretaker_Booking 							
							where status IN (1,2) and  
							FromDateTime < @BookingEndTime and @BookingStartTime < ToDateTime and CaretakerUserId=@CareTakerId )

	BEGIN
		SET @BookingId_OUT =999999
		
	END
	ELSE IF EXISTS  (select CaretakerUserId from Client_Scheduling 							
							where (@BookingStartTime BETWEEN StartDateTime AND EndDateTime							 
							OR @BookingEndTime BETWEEN  StartDateTime AND EndDateTime )and CaretakerUserId=@CareTakerId)

	BEGIN
		SET @BookingId_OUT =999999
		
	END

	ELSE
		BEGIN
			INSERT INTO PublicUser_Caretaker_Booking
			   ([CaretakerUserId]
			   ,[ServiceId]
			   ,[PublicUserId]
			   ,[BookingDateTime]
			   ,[FromDateTime]
			   ,[ToDateTime]
			   ,[Status])
			VALUES
			   (@CareTakerId,
			   @ServiceRequiredId,
			   @BookedUserId,
			   @BookingDate,
			   @BookingStartTime,
			   @BookingEndTime,
			   @Status)

			SET @BookingId_OUT=SCOPE_IDENTITY()
	END
END