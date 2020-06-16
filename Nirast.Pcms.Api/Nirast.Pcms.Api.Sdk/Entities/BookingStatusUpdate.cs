namespace Nirast.Pcms.Api.Sdk.Entities
{
    public class BookingStatusUpdate
    {
        public int userId { get; set; }
        public int status { get; set; }
        public string SiteUrl { get; set; }
        public string Reason { get; set; }
    }
}
