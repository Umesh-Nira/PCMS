CREATE PROCEDURE [dbo].[SpInsertUpdateCaretakerDetails] (
	@Id int = 0,
	@CaretakerUserId INT,
	@CareTakerTypeId INT,
	@ProfileId NVARCHAR(30),
	@SSID NVARCHAR(50),
	@TotalExperience NUMERIC(18,2),
	@KeySkills NVARCHAR(MAX),
	@AboutMe NVARCHAR(MAX),
	@ConsentForm nvarchar(MAX) = NULL,
	@IsPrivate BIT,
	@ConsentDocPath nvarchar(MAX) = NULL,
	@CaretakerDetailId_OUT  INT OUT)

AS
BEGIN
      --=========================================================================CARETAKER INSERTION START=============================================================
      IF @Id = 0
      BEGIN

        INSERT INTO [dbo].[Caretaker_Details]
		(
			UserId,
			[CaretakerTypeId],
			ProfileId,
			TotalExperience,
			KeySkills,
			AboutMe,
			SSID
		)
        VALUES
		(
			@CaretakerUserId,
			@CareTakerTypeId,
			@ProfileId,
			@TotalExperience,
			@KeySkills,
			@AboutMe,
			@SSID
		)

		SET @CaretakerDetailId_OUT=SCOPE_IDENTITY()

      END
      --=========================================================================CARETAKER INSERTION END===============================================================

      --=========================================================================CARETAKER UPDATE START================================================================

      ELSE
      BEGIN
        UPDATE [Caretaker_Details]
        SET 
			  [CaretakerTypeId] = @CaretakerTypeId,
			  [ProfileId]=@ProfileId,
			  [TotalExperience]=@TotalExperience,
			  [KeySkills]=@KeySkills,
			  [SSID] = @SSID,
			  [AboutMe]=@AboutMe,
			  [IsPrivate]=@IsPrivate,
			  [ConsentForm] = @ConsentForm,
			  [ConsentDocPath] = @ConsentDocPath
			WHERE [UserId] = @Id

			Select @CaretakerDetailId_OUT= c.CaretakerDetailId from [Caretaker_Details] c WHERE [UserId] = @Id

      END
      --=========================================================================CARETAKER UPDATE END================================================================
      
END