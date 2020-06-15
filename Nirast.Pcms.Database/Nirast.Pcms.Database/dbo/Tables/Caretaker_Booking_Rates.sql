CREATE TABLE [dbo].[Caretaker_Booking_Rates] (
    [BookingRateId]    INT             IDENTITY (1, 1) NOT NULL,
    [CaretakerId]      INT             NOT NULL,
    [PayingRate]       NUMERIC (18, 2) NULL,
    [DisplayRate]      NUMERIC (18, 2) NULL,
    [ServiceId]        INT             NOT NULL,
    [BookingPayRiseId] INT             NULL,
    CONSTRAINT [PK_Caretaker_Booking_Rates] PRIMARY KEY CLUSTERED ([BookingRateId] ASC),
    CONSTRAINT [FK_Caretaker_Booking_Rates_Caretaker_Booking_Payrise] FOREIGN KEY ([BookingPayRiseId]) REFERENCES [dbo].[Caretaker_Booking_Payrise] ([PayriseId]),
    CONSTRAINT [FK_Caretaker_Booking_Rates_Settings_CaretakerServices] FOREIGN KEY ([ServiceId]) REFERENCES [dbo].[Settings_CaretakerServices] ([ServiceId]),
    CONSTRAINT [FK_Caretaker_Booking_Rates_UserDetails_Master] FOREIGN KEY ([CaretakerId]) REFERENCES [dbo].[UserDetails_Master] ([UserId])
);



GO


GO


GO


GO


GO


GO


GO
