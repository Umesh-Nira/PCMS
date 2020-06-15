/*a
--------------------------------------------------------------------------------------------------
Author				: SETHU
Created Date		: 17-07-2018

Last Updated BY		: 
Last Updated Date	: 

This Stored Procedure calling from:	
----------------------------------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[SpDeletePayrollPayrise]
(
	@PayrollPayriseId int
)
AS
BEGIN
	
		DELETE [dbo].[Caretaker_Payroll_Rates]
		WHERE   [PayrollPayriseId]= @PayrollPayriseId

		DELETE [dbo].[Caretaker_Payroll_Payrise]
		WHERE [PayriseId] = @PayrollPayriseId
END