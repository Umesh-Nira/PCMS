CREATE TABLE [dbo].[UserDetails_Master] (
    [UserId]         INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]      NVARCHAR (50)  NOT NULL,
    [LastName]       NVARCHAR (50)  NULL,
    [DOB]            DATETIME       NULL,
    [Gender]         SMALLINT       NULL,
    [UserTypeId]     INT            NOT NULL,
    [UserStatus]     SMALLINT       NOT NULL,
    [IsVerified]     BIT            CONSTRAINT [DF_UserDetails_Master_IsVerified] DEFAULT ((0)) NOT NULL,
    [ProfilePicPath] NVARCHAR (MAX) NULL,
    [ProfilePic]     IMAGE          NULL,
    CONSTRAINT [PK_UserDetails_Master] PRIMARY KEY CLUSTERED ([UserId] ASC),
    CONSTRAINT [FK_UserDetails_Master_Settings_UserTypes] FOREIGN KEY ([UserTypeId]) REFERENCES [dbo].[Settings_UserTypes] ([UserTypeId])
);



GO


GO


GO


GO