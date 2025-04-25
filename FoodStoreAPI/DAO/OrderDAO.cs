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

        public static List<Order> GetAllOrders()
        {
            using (var context = new FoodStoreContext())
            {
                return context.Orders.ToList();
            }
        }

        public static bool Add(Order order)
        {
            using var db = new FoodStoreContext();
            db.Orders.Add(order);
            return db.SaveChanges() > 0;
        }

        public static bool Update(Order order)
        {
            using var db = new FoodStoreContext();
            var existing = db.Orders.FirstOrDefault(o => o.OrderId == order.OrderId);
            if (existing == null) return false;

            existing.CustomerId = order.CustomerId;
            existing.Gtotal = order.Gtotal;
            existing.OrderDate = order.OrderDate;
            existing.Status = order.Status;
            existing.UpdateAt = DateTime.Now;

            return db.SaveChanges() > 0;
        }

        public static bool Delete(int id)
        {
            using var db = new FoodStoreContext();
            var order = db.Orders.Find(id);
            if (order == null) return false;
            db.Orders.Remove(order);
            return db.SaveChanges() > 0;
        }

    }
}
