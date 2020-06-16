using System;
using System.Collections.Generic;

namespace Nirast.Pcms.Api.Sdk.Entities
{
    public class CaretakerScheduling : ClientDetails
    {
        public int CaretakerId { get; set; }

        public string CaretakerName { get; set; }

        public List<string> ServicesByCaretaker { get; set; }

        public string CaretakerCategory { get; set; }
    }

    public class ScheduleDetailModel : CaretakerScheduling
    {
        public string CareShift { get; set; }

        public string WorkShift { get; set; }

        public DateTime FromDate { get; set; }

        public DateTime ToDate { get; set; }

        public String TimeIn { get; set; }

        public string TimeOut { get; set; }
    }
}
