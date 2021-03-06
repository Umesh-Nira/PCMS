﻿using System;
using System.ComponentModel.DataAnnotations;

namespace Nirast.Pcms.Web.Models
{
    public class InvoiceHistory
    {
        public string InvoiceNumber { get; set; }

        public int? ClientId { get; set; }

        /// <summary>
        /// Get or Set from date
        /// </summary>

        public DateTime? FromDate { get; set; }

        /// <summary>
        /// Get or Set to date
        /// </summary>

        public DateTime? ToDate { get; set; }

        /// <summary>
        /// Get or Set the Year
        /// </summary>
        public int? Year { get; set; }

        /// <summary>
        /// Get or Set the Month
        /// </summary>
        public int? Month { get; set; }
        [RegularExpression(@"(?!^ +$)^.+$", ErrorMessage = " Blank Spaces are not allowed")]
        public int? InvoiceSearchInputId { get; set; }
    }
}