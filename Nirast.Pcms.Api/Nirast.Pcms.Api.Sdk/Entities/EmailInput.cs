﻿using System.Net.Mail;
using static Nirast.Pcms.Api.Sdk.Entities.Enums;

namespace Nirast.Pcms.Api.Sdk.Entities
{
    public class EmailInput
    {
        public string Name
        {
            get;
            set;
        }
        public string UserName
        {
            get;
            set;
        }
        public string Password
        {
            get;
            set;
        }
        public string EmailId
        {
            get;
            set;
        }

        public string Subject
        {
            get;
            set;
        }

        public string Body
        {
            get;
            set;
        }
        public string Attachments
        {
            get;
            set;
        }
        public Attachment Attachment
        {
            get;
            set;
        }

        public EmailType EmailType
        {
            get;
            set;
        }

        public EmailConfiguration EmailConfig
        {
            get;
            set;
        }

        public EmailTypeConfiguration EmailIdConfig
        {
            get;
            set;
        }
    }
}
