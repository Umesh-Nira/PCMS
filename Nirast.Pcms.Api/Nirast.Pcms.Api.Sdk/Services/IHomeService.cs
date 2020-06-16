using Nirast.Pcms.Api.Sdk.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Nirast.Pcms.Api.Sdk.Services
{

    public interface IHomeService
    {
        #region public methods


        /// <summary>
        /// To get caretaker details by advanced searching
        /// </summary>
        /// <returns></returns>
        Task<IEnumerable<SearchedCareTakers>> RetrievecareTakerDetails(AdvancedSearchInputModel inputs);

        Task<IEnumerable<CareTakerRegistrationModel>> KeywordCareTakerSearchDetail(string keyword);

        /// <summary>
        /// To get approved rate
        /// </summary>
        /// <returns></returns>
        Task<IEnumerable<CareTakerServices>> RetrievedApprovedRate();

        #endregion
    }
}
