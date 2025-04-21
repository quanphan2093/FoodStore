using FoodStoreAPI.DTO;
using FoodStoreAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace FoodStoreAPI.DAO
{
    public class OrderDAO
    {
        public static List<OrderItemDTO> getListOrderRevenueAdmin(DateTime dateNow, DateTime dateSevenDay)
        {
            FoodStoreContext context = new FoodStoreContext();
            List<OrderItemDTO> list = new List<OrderItemDTO>();
            try
            {
                list = context.OrderItems
                        .Include(x => x.Order)
                        .Include(x => x.Product)
                        .Where(x => x.Order.UpdateAt >= dateSevenDay && x.Order.UpdateAt <= dateNow && x.Order.Status == "Close Order")
                        .Select(o => new OrderItemDTO
                        {
                            Images = o.Product.Images,
                            Name = o.Product.Name,
                            Price = o.Product.Price,
                            OrderId = o.OrderId,
                            ProductId = o.ProductId,
                            OrderItemId = o.OrderItemId,
                            Quantity = o.Quantity,
                            CreateAt = o.Order.OrderDate,
                            OriginalPrice = o.Product.OriginalPrice
                        })
                        .ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return list;
        }
    }
}
