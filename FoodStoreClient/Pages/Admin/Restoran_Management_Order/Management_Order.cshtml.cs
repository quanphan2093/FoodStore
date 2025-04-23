using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using FoodStoreClient.Models;
using System.Net.Http.Headers;
using System.Text.Json;

namespace FoodStoreClient.Pages.Admin.Restoran_Management_Order
{
    public class Management_OrderModel : PageModel
    {
        private readonly HttpClient client;
        private readonly string GetOrderApiUrl = "http://localhost:7031/api/Order/Admin/GetAll";

        public string errorMessage { get; set; } = "";
        public DateTime? dateNow { get; set; } = DateTime.Now;
        public DateTime? datePast { get; set; } = DateTime.Now.AddYears(-2);
        public DateTime? dateSevenDay { get; set; } = new DateTime(2024, 4, 1);

        public List<Order> Orders { get; set; } = new List<Order>();
        public List<Order> FilteredOrders { get; set; } = new List<Order>();

        public Management_OrderModel()
        {
            client = new HttpClient();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public async Task<IActionResult> OnGet()
        {
            string accId = HttpContext.Session.GetString("accId");
            if (accId == null)
                return RedirectToPage("/Guest/Restoran_Login/Login");

            await LoadAllOrders();
            FilteredOrders = FilterOrders(dateSevenDay, dateNow);
            return Page();
        }

        public async Task<IActionResult> OnPost(string? from, string? to)
        {
            string accId = HttpContext.Session.GetString("accId");
            if (accId == null)
                return RedirectToPage("/Guest/Restoran_Login/Login");

            if (!DateTime.TryParse(from, out DateTime fromDate) || !DateTime.TryParse(to, out DateTime toDate))
            {
                errorMessage = "Invalid date range.";
                return Page();
            }

            await LoadAllOrders();
            FilteredOrders = FilterOrders(fromDate, toDate);
            dateSevenDay = fromDate;
            dateNow = toDate;

            return Page();
        }

        private async Task LoadAllOrders()
        {
            try
            {
                var response = await client.GetAsync(GetOrderApiUrl);
                if (response.IsSuccessStatusCode)
                {
                    var responseBody = await response.Content.ReadAsStringAsync();
                    var jsonDoc = JsonDocument.Parse(responseBody);
                    var valuesJson = jsonDoc.RootElement.GetProperty("$values").ToString();
                    Orders = JsonSerializer.Deserialize<List<Order>>(valuesJson, new JsonSerializerOptions { PropertyNameCaseInsensitive = true }) ?? new List<Order>();
                    Console.WriteLine(">>> Orders loaded from API: " + Orders.Count);

                }
                else
                {
                    errorMessage = $"API Error: {response.StatusCode}";
                }
            }
            catch (Exception ex)
            {
                errorMessage = $"Exception: {ex.Message}";
            }
        }

        private List<Order> FilterOrders(DateTime? fromDate, DateTime? toDate)
        {
            if (fromDate == null || toDate == null)
                return Orders;

            return Orders
                .Where(o => o.OrderDate.HasValue && o.OrderDate.Value.Date >= fromDate.Value.Date && o.OrderDate.Value.Date <= toDate.Value.Date)
                .ToList();

        }
    }
}
