CREATE TABLE [dbo].[Settings_Resident] (
    [ResidentId]   INT            IDENTITY (1, 1) NOT NULL,
    [ClientId]     INT            NOT NULL,
    [ResidentName] NVARCHAR (100) NOT NULL,
    [OtherInfo]    NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_Settings_Resident] PRIMARY KEY CLUSTERED ([ResidentId] ASC),
    CONSTRAINT [ResidentName_unique] UNIQUE NONCLUSTERED ([ClientId] ASC, [ResidentName] ASC)
);


