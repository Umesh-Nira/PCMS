CREATE TABLE [dbo].[PublicUser_Booking_Dates](
 [BookingDateId] [int] IDENTITY(1,1) NOT NULL,
 [BookingId] [int] NOT NULL,
 [Date] [datetime] NOT NULL,
 [Hours] [float] NOT NULL,
 CONSTRAINT [PK_PublicUser_Booking_Dates] PRIMARY KEY CLUSTERED 
(
 [BookingDateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[PublicUser_Booking_Dates]  WITH CHECK ADD  CONSTRAINT [FK_PublicUser_Booking_Dates_PublicUser_Caretaker_Booking] FOREIGN KEY([BookingId])
REFERENCES [dbo].[PublicUser_Caretaker_Booking] ([BookingId])
GO

ALTER TABLE [dbo].[PublicUser_Booking_Dates] CHECK CONSTRAINT [FK_PublicUser_Booking_Dates_PublicUser_Caretaker_Booking]
GO