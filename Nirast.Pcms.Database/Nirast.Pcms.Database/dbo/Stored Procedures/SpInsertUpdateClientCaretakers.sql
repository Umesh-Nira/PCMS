CREATE PROCEDURE [dbo].[SpInsertUpdateClientCaretakers] 
	(
		@ClientId int,
		@CaretakerId int,
		@MappedRate  AS [dbo].[MappedCaretakerRates] READONLY
	)
AS
BEGIN
      --========================================================================= CLIENT CARETAKER INSERTION START =============================================================
	DELETE FROM [dbo].[Client_Caretaker_Mapping] WHERE ClientId = @ClientId AND CaretakerUserId = @CaretakerId

	INSERT INTO [Client_Caretaker_Mapping]
				(
				[ClientId],
				[CaretakerUserId],
				[Rate],
				[ShiftId]	
				)
				SELECT  ClientId,
						CaretakerId,
						Rate,
						WorkShiftId
				FROM @MappedRate
	END