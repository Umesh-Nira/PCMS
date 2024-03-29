﻿using System;

namespace Nirast.Pcms.Api.Sdk.Entities
{
    public class PaymentHistory
    {
        /// <summary>
        /// Get or Set PaymentId
        /// </summary>
        public int TransactionId { get; set; }

        /// <summary>
        /// Get or Set BookingDate 
        /// </summary>
        public DateTime BookingDate { get; set; }

        /// <summary>
        /// Get or Set Caretaker Name
        /// </summary>
        public string CaretakerName { get; set; }

        /// <summary>
        /// Get or Set care taker user id
        /// </summary>
        public string CaretakerType { get; set; }

        /// <summary>
        /// Get or Set service id
        /// </summary>
        public string ServiceName { get; set; }

        /// <summary>
        /// Get or Set Paid Amount
        /// </summary>
        public float PaidAmount { get; set; }


        /// <summary>
        /// Get or Set Symbol
        /// </summary>
        public string Symbol { get; set; }


        /// <summary>
        /// Get or Set Currency
        /// </summary>
        public string Currency { get; set; }

        /// <summary>
        /// Get or Set Paid Date
        /// </summary>
        public DateTime PaidDate { get; set; }

        /// <summary>
        /// Get or Set Invoice Number
        /// </summary>
        public int InvoiceNumber { get; set; }

        /// <summary>
        /// Get or Set care taker user id
        /// </summary>
        public string Method { get; set; }

        /// <summary>
        /// Get or Set care taker user id
        /// </summary>
        public string Status { get; set; }
    }
}
