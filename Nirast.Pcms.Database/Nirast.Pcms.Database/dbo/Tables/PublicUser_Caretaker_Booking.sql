
CREATE TABLE [dbo].[PublicUser_Caretaker_Booking] (
    [BookingId]          INT      IDENTITY (1, 1) NOT NULL,
    [CaretakerUserId]    INT      NOT NULL,
    [PublicUserId]       INT      NOT NULL,
    [ServiceId]          INT      NOT NULL,
    [FromDateTime]       DATETIME NOT NULL,
    [ToDateTime]         DATETIME NOT NULL,
    [BookingDateTime]    DATETIME NOT NULL,
    [Status]             INT      NOT NULL,
    [IsConfirmed]        BIT      CONSTRAINT [DF_PublicUser_Caretaker_Booking_IsConfirmed] DEFAULT ((0)) NOT NULL,
    [StatusModifiedDate] DATETIME NULL,
    CONSTRAINT [PK_PublicUser_Caretaker_Booking] PRIMARY KEY CLUSTERED ([BookingId] ASC),
    CONSTRAINT [FK_PublicUser_Caretaker_Booking_Settings_CaretakerServices] FOREIGN KEY ([ServiceId]) REFERENCES [dbo].[Settings_CaretakerServices] ([ServiceId]),
    CONSTRAINT [FK_PublicUser_Caretaker_Booking_UserDetails_Master] FOREIGN KEY ([CaretakerUserId]) REFERENCES [dbo].[UserDetails_Master] ([UserId]),
    CONSTRAINT [FK_PublicUser_Caretaker_Booking_UserDetails_Master1] FOREIGN KEY ([PublicUserId]) REFERENCES [dbo].[UserDetails_Master] ([UserId])
);



GO


GO


GO


GO


GO


GO


GO


