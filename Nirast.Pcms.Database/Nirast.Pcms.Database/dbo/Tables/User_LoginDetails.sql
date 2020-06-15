CREATE TABLE [dbo].[User_LoginDetails](
	[EmailId] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_User_LoginDetails] PRIMARY KEY CLUSTERED 
(
	[EmailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[User_LoginDetails]  WITH CHECK ADD  CONSTRAINT [FK_User_LoginDetails_UserDetails_Master] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserDetails_Master] ([UserId])
GO

ALTER TABLE [dbo].[User_LoginDetails] CHECK CONSTRAINT [FK_User_LoginDetails_UserDetails_Master]
GO

