/*
-----------------------------------------------------------------------------------
< Insert/Update work shift details >

Author				: Nowfal S R
Created Date		: 10-August-2018

Last Updated BY		: 
Last Updated Date	: 
Updation			: 
-----------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpAddEditWorkShiftDetails] 
(
	@WorkShiftId INT = 0,
	@WorkShift NVARCHAR(50),
	@ShowResidentName BIT,
	@IsSeparateInvoice BIT
)
AS
BEGIN
	IF @WorkShiftId = 0
		BEGIN
			INSERT INTO [dbo].[Settings_WorkShift]
			    (
				   [WorkShiftName],
				   ShowResidentName,
				   IsSeparateInvoice
				)
			VALUES
			    (
				   @WorkShift,
				   @ShowResidentName,
				   @IsSeparateInvoice
				)
				SELECT CAST(SCOPE_IDENTITY() AS INT)
		END
	ELSE
		BEGIN
			UPDATE [dbo].[Settings_WorkShift]
			SET

				 [WorkShiftName] = @WorkShift,
				 ShowResidentName = @ShowResidentName,
				 IsSeparateInvoice = @IsSeparateInvoice
			WHERE WorkShiftId = @WorkShiftId
		END	
END