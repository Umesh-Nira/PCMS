using Dapper;
using Nirast.Pcms.Api.Sdk.Entities;
using Nirast.Pcms.Api.Sdk.Infrastructure;
using Nirast.Pcms.Api.Sdk.Logger;
using Nirast.Pcms.Api.Sdk.Repositories;
using System;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace Nirast.Pcms.Api.Data.Repositories
{
    public class LoggedInUserRepository : GenericRepository<LoggedInUser>, ILoggedInUserRepository
    {
        IConnectionFactory _connectionFactory;
        IPCMSLogger _logger;
        IDbConnection _dbConnection;

        public LoggedInUserRepository(IConnectionFactory connectionFactory, IPCMSLogger logger)
        {
            _connectionFactory = connectionFactory;
            _logger = logger;
            _dbConnection = connectionFactory.GetConnection();
        }

        public async Task<LoggedInUser> CheckLoginCredentialsCheckLoginCredentials(UserCredential userCredential)
        {
            var param = new DynamicParameters();
            try
            {
                _connectionFactory.OpenConnection();
                string checkCredential = "SpCheckCredentials";
                param.Add("@EmailId", userCredential.LoginName);
                var result = await SqlMapper.QueryFirstOrDefaultAsync<LoggedInUser>(_dbConnection, checkCredential, param, commandType: CommandType.StoredProcedure);
                return await Task.FromResult(result);
            }
            catch (Exception ex)
            {
                _logger.Error(ex, "DB error occured while CheckLoginCredentialsCheckLoginCredentials");
                return null;
            }
            finally
            {
                _connectionFactory.CloseConnection();
            }
        }

        public async Task<LoggedInUser> GetLoggedInUserDetails(int userId)
        {
            var param = new DynamicParameters();
            try
            {
                _connectionFactory.OpenConnection();
                string checkCredential = "SpGetLoggedInUserDetails";
                param.Add("@UserId", userId);
                var result = await SqlMapper.QueryFirstOrDefaultAsync<LoggedInUser>(_dbConnection, checkCredential, param, commandType: CommandType.StoredProcedure);
                return await Task.FromResult(result);
            }
            catch (Exception ex)
            {
                _logger.Error(ex, "DB error occured while GetLoggedInUserDetails");
                return null;
            }
            finally
            {
                _connectionFactory.CloseConnection();
            }
        }

        public async Task<bool> AddLoginLog(int userID)
        {
            try
            {
                _connectionFactory.OpenConnection();
                var query = "SpAuditLog_Login_Insert";
                var param = new DynamicParameters();
                param.Add("@UserID", userID);
                param.Add("@LoginDate", DateTime.Now);
                param.Add("@LoginIP", "");
                var result = SqlMapper.QueryAsync<int>(_dbConnection, query, param, commandType: CommandType.StoredProcedure).Result.SingleOrDefault();
                return true;
            }
            catch (Exception ex)
            {
                _logger.Error(ex, "DB error occured while add country");

                if (ex.InnerException.Message.Contains("UNIQUE KEY"))
                    return false;

                return false;
            }
            finally
            {
                _connectionFactory.CloseConnection();
            }
        }
    }
}
