using System;
using System.Data;

namespace Nirast.Pcms.Api.Sdk.Infrastructure
{
    public interface IConnectionFactory : IDisposable
    {
        IDbTransaction BeginTransaction(IDbConnection dbConnection);
        void Commit(IDbTransaction dbTransaction);
        void Rollback(IDbTransaction dbTransaction);
        void OpenConnection();
        void CloseConnection();
        IDbConnection GetConnection();
    }
}
