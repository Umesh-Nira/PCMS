CREATE TABLE [dbo].[Settings_Holidays] (
    [HolidayId]   INT           IDENTITY (1, 1) NOT NULL,
    [HolidayName] NVARCHAR (50) NOT NULL,
    [HolidayDate] DATETIME      NOT NULL,
    [CountryId]   INT           NOT NULL,
    [StateId]     INT           NULL,
    CONSTRAINT [PK_Settings_Holidays] PRIMARY KEY CLUSTERED ([HolidayId] ASC),
    CONSTRAINT [FK_Settings_Holidays_Settings_Country] FOREIGN KEY ([CountryId]) REFERENCES [dbo].[Settings_Country] ([CountryId]),
    CONSTRAINT [FK_Settings_Holidays_Settings_State] FOREIGN KEY ([StateId]) REFERENCES [dbo].[Settings_State] ([StateId]),
    CONSTRAINT [Holiday_Unique] UNIQUE NONCLUSTERED ([CountryId] ASC, [StateId] ASC, [HolidayDate] ASC, [HolidayName] ASC)
);



GO


GO


GO


GO


GO