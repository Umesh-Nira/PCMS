using Nirast.Pcms.Api.Sdk.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Nirast.Pcms.Api.Sdk.Repositories
{
    public interface ILoggedInUserRepository : IGenericRepository<LoggedInUser>
    {
        Task<LoggedInUser> CheckLoginCredentialsCheckLoginCredentials(UserCredential userCredential);
        Task<LoggedInUser> GetLoggedInUserDetails(int userId);
        Task<bool> AddLoginLog(int userId);
    }
}
