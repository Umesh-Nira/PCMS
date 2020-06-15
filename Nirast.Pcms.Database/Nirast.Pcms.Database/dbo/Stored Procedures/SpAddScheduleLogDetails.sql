-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SpAddScheduleLogDetails]
(
        @FeatureId int, 
		@UserId Int,
        @Action varchar(50),
        @Message varchar(50), 
        @OldData varchar(MAX), 
        @NewData varchar(MAX) ,
		@UpdatedDate Datetime,
		@CareTakerName varchar(50),
		@LogId_OUT int out,
		@ClientId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN
			INSERT INTO [dbo].[AuditLog_Scheduling]
			   ( 
					FeatureId, 
					UserID,
					ActionType,
					MessageContent , 
					OldData , 
					NewData ,
					UpdatedDate,
					CareTakerName,
					ClientId
				)
			VALUES
			   ( 
					@FeatureId, 
					@UserId,
					@Action ,
					@Message , 
					@OldData , 
					@NewData ,
					@UpdatedDate,
					@CareTakerName,
					@ClientId
				)
				SET @LogId_OUT = SCOPE_IDENTITY()
	
   END
END