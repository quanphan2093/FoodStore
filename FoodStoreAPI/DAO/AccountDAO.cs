using AutoMapper;
using FoodStoreAPI.DTO;
using FoodStoreAPI.Models;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace FoodStoreAPI.DAO
{
    public class AccountDAO
    {
        private static readonly IMapper _mapper;

        static AccountDAO()
        {
            var config = new MapperConfiguration(cfg =>
            {
                cfg.CreateMap<Account, AccountDTO>();
            });
            _mapper = config.CreateMapper();
        }

        public static AccountDTO Login(string email, string password)
        {
            
            string passHash = HashPassword(password);
            Account account = FoodStoreContext.Ins.Accounts.Include(x => x.Role).
                FirstOrDefault(x => x.Email == email && x.Password == passHash);
            if (account != null)
            {
                return _mapper.Map<AccountDTO>(account);
            }
            return null;
        }

        public static string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }

        public static void Register(AccountDTO accountdto)
        {
            try
            {
                if (string.IsNullOrEmpty(accountdto.Email) || string.IsNullOrEmpty(accountdto.Password))
                {
                    throw new ArgumentException("Email và Password không được để trống.");
                }
                Account account = new Account
                {
                    Email = accountdto.Email,
                    Phone = accountdto.Phone,
                    Name = accountdto.Name,
                    Username = accountdto.Username,
                    Password = HashPassword(accountdto.Password),
                    CreateAt = DateTime.Now,
                    RoleId = 3,
                    Address = accountdto.Address
                };
                var context = FoodStoreContext.Ins;
                context.Accounts.Add(account);
                context.SaveChanges();
            }
            catch (DbUpdateException ex)
            {
                throw new Exception($"Lỗi Database: {ex.InnerException?.Message}");
            }
            catch (Exception e)
            {
                throw new Exception($"Lỗi hệ thống: {e.Message}");
            }
        }

        public static Account findAccountByUsernameAndEmail(string username, string email)
        {
            Account account = new Account();
            try
            {
                account = FoodStoreContext.Ins.Accounts.FirstOrDefault(x => x.Username == username && x.Email == email);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return account;
        }
    }
}
