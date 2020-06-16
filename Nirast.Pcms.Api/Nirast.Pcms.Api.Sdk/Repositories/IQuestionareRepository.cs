using Nirast.Pcms.Api.Sdk.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Nirast.Pcms.Api.Sdk.Repositories
{
    public interface IQuestionareRepository : IGenericRepository<QuestionareModel>
    {
        Task<int> AddQuestions(QuestionareModel questions);
        Task<IEnumerable<QuestionareModel>> RetrieveQuestions(int id);
        Task<int> DeleteQuestions(int id);
    }

}
