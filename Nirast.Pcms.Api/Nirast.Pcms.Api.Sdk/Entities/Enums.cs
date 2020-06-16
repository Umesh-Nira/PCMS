namespace Nirast.Pcms.Api.Sdk.Entities
{
    public class Enums
    {

        public enum EmailType : int
        {
            Registration = 1,
            Booking = 2,
            Scheduling = 3,
            UserPayment = 4,
            Invoice = 5
        }
        public enum AuditLogType : int
        {
            Scheduling = 1
        }
        public enum AuditLogActionType : int
        {
            Add = 1,
            Edit = 2,
            Delete = 3
        }
        public enum MapStatus : int
        {
            Map = 1,
            Unmap = 2
        }
    }
}
