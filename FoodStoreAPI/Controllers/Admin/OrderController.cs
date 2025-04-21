using FoodStoreAPI.DAO;
using Microsoft.AspNetCore.Mvc;

namespace FoodStoreAPI.Controllers.Admin
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        //GET:
        [HttpGet("Admin/RevenueCaculate")]
        public IActionResult getRevenue(DateTime dateNow, DateTime dateSevenDay)
        {
            return Ok(RevenueDAO.getRevenueAdmin(dateNow, dateSevenDay));
        }
        //GET:
        [HttpGet("Admin/OrderCloseCaculate")]
        public IActionResult getListOrderRevenue(DateTime dateNow, DateTime dateSevenDay)
        {
            return Ok(OrderDAO.getListOrderRevenueAdmin(dateNow, dateSevenDay));
        }
    }
}
