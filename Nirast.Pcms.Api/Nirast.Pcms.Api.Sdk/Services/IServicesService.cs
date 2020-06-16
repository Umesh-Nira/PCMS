using System.Collections.Generic;
using System.Threading.Tasks;

namespace Nirast.Pcms.Api.Sdk.Services
{
    public interface IServicesService
    {
        Task<int> AddServices(Entities.Services service);

        Task<IEnumerable<Entities.Services>> RetrieveServices(int serviceId);


    }
}
