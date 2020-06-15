CREATE PROCEDURE [dbo].[SpInsertScheduleRejectedCaretakers] (
	 @CareTakerId int,
	 @ClientId int,
    
	 @Description varchar(max),
	 @Workshift int,
	 @ScheduleDate datetime
	)
AS
BEGIN
      --========================================================================= CLIENT CARETAKER INSERTION START =============================================================
      
  

        INSERT INTO [dbo].[Caretaker_Rejected_Schedulings]
		(
		   CareTakerId,
		   Datetime,
		   Description,
		   ClientId,
		   Workshift,
		   ScheduleDate
		)
        VALUES
		  (
		   @CareTakerId,
			GETUTCDATE(),
		   @Description,
		   @ClientId,
		   @Workshift,
		   @ScheduleDate
		  )
     
      --=========================================================================CLIENT CARETAKER INSERTION END===============================================================

 END