using FoodStoreAPI.DTO;
using FoodStoreAPI.Models;

namespace FoodStoreAPI.DAO
{
    public class RevenueDAO
    {


        public static List<RevenueDTO> getRevenueAdmin(DateTime dateNow, DateTime dateSevenDay)
        {
            FoodStoreContext context = new FoodStoreContext();
            List<RevenueDTO> revenue = new List<RevenueDTO>();
            try
            {
                revenue = context.Revenues.Where(x => x.CreateAt >= dateSevenDay && x.CreateAt <= dateNow)
                    .Select(x => new RevenueDTO
                    {
                        RevenueId = x.RevenueId,
                        RevenuePrice = x.RevenuePrice,
                        InterestRate = x.InterestRate,
                        FloorFee = x.FloorFee,
                        CreateAt = x.CreateAt,
                        AccId = x.AccId
                    })
                    .ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return revenue;
        }
    }
}
