CREATE TABLE [dbo].[Settings_Testimonials] (
    [TestimonialId] INT            IDENTITY (1, 1) NOT NULL,
    [ClientName]    NVARCHAR (50)  NULL,
    [Designation]   NVARCHAR (50)  NULL,
    [Description]   NVARCHAR (500) NULL,
    [Url]           NVARCHAR (50)  NULL,
    [Rating]        INT            NULL,
    CONSTRAINT [PK_Settings_Testimonials] PRIMARY KEY CLUSTERED ([TestimonialId] ASC)
);



