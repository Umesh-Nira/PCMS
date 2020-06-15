CREATE TABLE [dbo].[Settings_City] (
    [CityId]   INT           IDENTITY (1, 1) NOT NULL,
    [CityCode] NVARCHAR (10) NULL,
    [CityName] NVARCHAR (30) NOT NULL,
    [StateId]  INT           NOT NULL,
    CONSTRAINT [PK_Settings_City] PRIMARY KEY CLUSTERED ([CityId] ASC),
    CONSTRAINT [FK_Settings_City_Settings_State] FOREIGN KEY ([StateId]) REFERENCES [dbo].[Settings_State] ([StateId]),
    CONSTRAINT [city_unique] UNIQUE NONCLUSTERED ([StateId] ASC, [CityName] ASC)
);



GO


GO


GO

