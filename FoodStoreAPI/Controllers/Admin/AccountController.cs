using Microsoft.AspNetCore.Mvc;
using FoodStoreAPI.DAO;
using FoodStoreAPI.DTO;

namespace FoodStoreAPI.Controllers.Admin
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : Controller
    {
        [HttpGet("Admin/Accounts")]
        public ActionResult<IEnumerable<AccountLDTO>> GetAccount()
        {
            return AccountDAO.getAccount();
        }

        [HttpGet("Admin/Account/Search")]
        public ActionResult<IEnumerable<AccountLDTO>> GetAccountSearch(string searchAccount)
        {
            return AccountDAO.getAccountSearch(searchAccount);
        }

        [HttpPut("Admin/Update/Account")]
        public IActionResult UpdateRoleAccount(int accId, int roleId)
        {
            AccountDAO.UpdateRoleAccount(accId, roleId);
            return Ok();
        }

    }
}
