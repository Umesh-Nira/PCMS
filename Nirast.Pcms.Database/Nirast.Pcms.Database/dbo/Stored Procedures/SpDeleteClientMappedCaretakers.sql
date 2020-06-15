CREATE PROCEDURE [dbo].[SpDeleteClientMappedCaretakers] 
	(
	 @ClientId int,
     @CaretakerId int
	)
AS
BEGIN   

	UPDATE  [dbo].[Caretaker_Payroll_Rates]
			SET [MapStatus] = 2
			WHERE
			[ClientId] = @ClientId AND [CaretakerId] = @CaretakerId


 END