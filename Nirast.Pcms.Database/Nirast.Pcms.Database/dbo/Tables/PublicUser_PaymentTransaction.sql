CREATE TABLE [dbo].[PublicUser_PaymentTransaction](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [int] NOT NULL,
	[TransactionNo] [varchar](100) NULL,
	[TransactionDateTime] [datetime] NULL,
	[Method] [nvarchar](50) NULL,
	[Amount] [numeric](18, 2) NULL,
	[Description] [nvarchar](500) NULL,
	[Status] [bit] NOT NULL,
	[Message] [varchar](max) NULL,
	[TransactionDetails] [varchar](max) NULL,
 CONSTRAINT [PK_PublicUser_PaymentTransaction] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


ALTER TABLE [dbo].[PublicUser_PaymentTransaction] ADD  CONSTRAINT [DF_PublicUser_PaymentTransaction_Status]  DEFAULT ((0)) FOR [Status]
GO

ALTER TABLE [dbo].[PublicUser_PaymentTransaction]  WITH CHECK ADD  CONSTRAINT [FK_PublicUser_PaymentTransaction_PublicUser_PaymentInvoice] FOREIGN KEY([InvoiceNo])
REFERENCES [dbo].[PublicUser_PaymentInvoice] ([InvoiceNo])
GO

ALTER TABLE [dbo].[PublicUser_PaymentTransaction] CHECK CONSTRAINT [FK_PublicUser_PaymentTransaction_PublicUser_PaymentInvoice]
GO
