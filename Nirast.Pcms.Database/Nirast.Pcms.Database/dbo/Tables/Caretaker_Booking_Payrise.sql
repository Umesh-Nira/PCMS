CREATE TABLE [dbo].[Caretaker_Booking_Payrise] (
    [PayriseId]   INT  IDENTITY (1, 1) NOT NULL,
    [Payrisedate] DATE NULL,
    [CaretakerId] INT  NOT NULL,
    CONSTRAINT [PK_Caretaker_Booking_Payrise] PRIMARY KEY CLUSTERED ([PayriseId] ASC),
    CONSTRAINT [FK_Caretaker_Booking_Payrise_UserDetails_Master] FOREIGN KEY ([CaretakerId]) REFERENCES [dbo].[UserDetails_Master] ([UserId])
);



