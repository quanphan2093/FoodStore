using FoodStoreAPI.DTO;
using FoodStoreAPI.Models;
using Microsoft.EntityFrameworkCore;
using System.Text;

namespace FoodStoreAPI.DAO
{
    public class AccountDAO
    {

        public static List<AccountLDTO> getAccount()
        {
            FoodStoreContext context = new FoodStoreContext();
            var listAccount = new List<AccountLDTO>();
            try
            {
                listAccount = context.Accounts
                    .Include(x => x.Role)
                    .Select(x => new AccountLDTO
                    {
                        AccId = x.AccId,
                        Username = x.Username,
                        CreateAt = x.CreateAt,
                        RoleId = x.RoleId,
                        Email = x.Email,
                        Phone = x.Phone,
                        RoleName = x.Role.RoleName
                    })
                    .ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return listAccount;
        }


        public static List<AccountLDTO> getAccountSearch(string searchAccount)
        {
            FoodStoreContext context = new FoodStoreContext();
            var listAccount = new List<AccountLDTO>();
            try
            {
                listAccount = context.Accounts.Include(x => x.Role)
                    .Where(x => (x.Username.ToLower().Contains(searchAccount.ToLower())
                    || x.AccId.ToString().Contains(searchAccount)
                    || x.RoleId.ToString().Contains(searchAccount)))
                    .Select(x => new AccountLDTO
                    {
                        AccId = x.AccId,
                        Username = x.Username,
                        CreateAt = x.CreateAt,
                        RoleId = x.RoleId,
                        Email = x.Email,
                        Phone = x.Phone,
                        RoleName = x.Role.RoleName
                    }).ToList();
            }catch(Exception ex)
            {
                throw new Exception (ex.Message);
            }
            return listAccount;
        }

        public static void UpdateRoleAccount(int accId, int roleId)
        {
            FoodStoreContext context = new FoodStoreContext();
            try
            {
                Account acc = context.Accounts.SingleOrDefault(x => x.AccId == accId);
                acc.UpdateAt = DateTime.Now;
                acc.RoleId = roleId;
                context.Accounts.Update(acc);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
