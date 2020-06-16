using Nirast.Pcms.Api.Sdk.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Nirast.Pcms.Api.Sdk.Repositories
{
    public interface ICategoryRepository : IGenericRepository<CategoryModel>
    {
        Task<int> AddCategory(CategoryModel Category);

        Task<IEnumerable<CategoryModel>> RetrieveCategory(string flag, string value);
        Task<int> DeleteCategory(int id);
    }
}
