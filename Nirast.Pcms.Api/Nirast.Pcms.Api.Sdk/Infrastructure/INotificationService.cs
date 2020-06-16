using Nirast.Pcms.Api.Sdk.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Nirast.Pcms.Api.Sdk.Infrastructure
{
    public interface INotificationService
    {
        Task<bool> SendEMail(EmailInput data, List<string> ccAddress = null, List<string> emailIdList = null);
    }
}
