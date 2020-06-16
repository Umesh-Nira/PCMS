using System;

namespace Nirast.Pcms.Api.Sdk.Entities
{
    public class InvoicePaymentModel
    {
        /// <summary>
        /// Get or Set the invoice number
        /// </summary>
        public int InvoiceNumber { get; set; }

        /// <summary>
        /// Get or Set invoice description
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// Get or Set the date
        /// </summary>
        public DateTime Date { get; set; }

        /// <summary>
        /// Get or Set the amount
        /// </summary>
        public float Amount { get; set; }

        /// <summary>
        /// Get or Set the amount
        /// </summary>
        public float TaxAmount { get; set; }

        /// <summary>
        /// Get or Set the amount
        /// </summary>
        public float TotalAmount { get; set; }

        /// <summary>
        /// Get or Set the status
        /// </summary>
        public bool PaidStatus { get; set; }

    }
}
