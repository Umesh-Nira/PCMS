using Nirast.Pcms.Api.Sdk.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Nirast.Pcms.Api.Sdk.Repositories
{
    public interface ICityRepository : IGenericRepository<Cities>
    {
        Task<int> AddCity(Cities city);

        Task<IEnumerable<Cities>> RetrieveCities(string flag, string value);
        Task<int> DeleteCity(int id);

        /// <summary>
        /// To get city details by state id
        /// </summary>
        /// <param name="stateId"></param>
        /// <returns></returns>
        Task<IEnumerable<Cities>> GetCityByStateId(int stateId);
    }
}
