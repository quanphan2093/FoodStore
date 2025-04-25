using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using FoodStoreClient.Models;
using System.Net.Http.Headers;
using System.Text.Json;

namespace FoodStoreClient.Pages.Admin.Restoran_Management_Revenue
{
    public class Management_RevenueModel : PageModel
    {
        private readonly HttpClient client;
        private readonly string RevenueCaculateApiUrl = "http://localhost:7031/api/Order/Admin/RevenueCaculate";
        private readonly string OrderCloseCaculateApiUrl = "http://localhost:7031/api/Order/Admin/OrderCloseCaculate";
        public string errorMessage { get; set; } = "";
        public DateTime? dateNow { get; set; } = DateTime.Now.AddDays(+1);
        public DateTime? datePast { get; set; } = DateTime.Now.AddYears(-2);
        public DateTime? dateSevenDay { get; set; } = DateTime.Now.AddDays(-7);
        public List<OrderItem> product { get; set; } = new List<OrderItem>();
        public List<Revenue> revenue { get; set; } = new List<Revenue>();
        public Management_RevenueModel()
        {
            client = new HttpClient();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }
        public async Task<IActionResult> OnGet()
        {
            string accId = HttpContext.Session.GetString("accId");
            if (accId == null)
            {
                return RedirectToPage("/Guest/Restoran_Login/Login");
            }
            else
            {
                string requestOrderItemslUrl = $"{OrderCloseCaculateApiUrl}?dateNow={dateNow}&dateSevenDay={dateSevenDay}";
                var responseOrderItems = await client.GetAsync(requestOrderItemslUrl);
                if (!responseOrderItems.IsSuccessStatusCode)
                {
                    TempData["ErrorMessage"] = $"API Error: {responseOrderItems.StatusCode}";
                    return Page();
                }
                var responseOrderItemsBody = await responseOrderItems.Content.ReadAsStringAsync();
                var jsonDoc = JsonDocument.Parse(responseOrderItemsBody);
                var valuesJson = jsonDoc.RootElement.GetProperty("$values").ToString();
                product = JsonSerializer.Deserialize<List<OrderItem>>(valuesJson, new JsonSerializerOptions { PropertyNameCaseInsensitive = true }) ?? new List<OrderItem>();

                string requestRevenuelUrl = $"{RevenueCaculateApiUrl}?dateNow={dateNow}&dateSevenDay={dateSevenDay}";
                var responseRevenue = await client.GetAsync(requestRevenuelUrl);
                if (!responseRevenue.IsSuccessStatusCode)
                {
                    TempData["ErrorMessage"] = $"API Error: {responseRevenue.StatusCode}";
                    return Page();
                }
                var responseRevenueBody = await responseRevenue.Content.ReadAsStringAsync();
                var jsonRevenueDoc = JsonDocument.Parse(responseRevenueBody);
                var valuesRevenueJson = jsonRevenueDoc.RootElement.GetProperty("$values").ToString();
                revenue = JsonSerializer.Deserialize<List<Revenue>>(valuesRevenueJson, new JsonSerializerOptions { PropertyNameCaseInsensitive = true }) ?? new List<Revenue>();
                if (revenue.Count > 0)
                {
                    foreach (var item in revenue)
                    {
                        revenuePrice += (float)item.RevenuePrice;
                        interestRate += (float)item.InterestRate;
                        FloorFee += (float)item.FloorFee;
                    }
                }
            }
            return Page();
        }
        public float revenuePrice { get; set; } = 0;
        public float interestRate { get; set; } = 0;
        public float FloorFee { get; set; } = 0;
        public async Task<IActionResult> OnPost(string? from, string? to)
        {
            string accId = HttpContext.Session.GetString("accId");
            if (accId != null)
            {
                if (!DateTime.TryParse(from, out DateTime fromDate) || !DateTime.TryParse(to, out DateTime toDate))
                {
                    return Page();
                }
                string requestOrderItemslUrl = $"{OrderCloseCaculateApiUrl}?dateNow={to}&dateSevenDay={from}";
                var responseOrderItems = await client.GetAsync(requestOrderItemslUrl);
                if (!responseOrderItems.IsSuccessStatusCode)
                {
                    TempData["ErrorMessage"] = $"API Error: {responseOrderItems.StatusCode}";
                    return Page();
                }
                var responseOrderItemsBody = await responseOrderItems.Content.ReadAsStringAsync();
                var jsonDoc = JsonDocument.Parse(responseOrderItemsBody);
                var valuesJson = jsonDoc.RootElement.GetProperty("$values").ToString();
                product = product = JsonSerializer.Deserialize<List<OrderItem>>(valuesJson, new JsonSerializerOptions { PropertyNameCaseInsensitive = true }) ?? new List<OrderItem>();

                string requestRevenuelUrl = $"{RevenueCaculateApiUrl}?dateNow={to}&dateSevenDay={from}";
                var responseRevenue = await client.GetAsync(requestRevenuelUrl);
                if (!responseRevenue.IsSuccessStatusCode)
                {
                    TempData["ErrorMessage"] = $"API Error: {responseRevenue.StatusCode}";
                    return Page();
                }
                var responseRevenueBody = await responseRevenue.Content.ReadAsStringAsync();
                var jsonRevenueDoc = JsonDocument.Parse(responseRevenueBody);
                var valuesRevenueJson = jsonRevenueDoc.RootElement.GetProperty("$values").ToString();
                revenue = JsonSerializer.Deserialize<List<Revenue>>(valuesRevenueJson, new JsonSerializerOptions { PropertyNameCaseInsensitive = true }) ?? new List<Revenue>();
                if (revenue.Count > 0)
                {
                    foreach (var item in revenue)
                    {
                        revenuePrice += (float)item.RevenuePrice;
                        interestRate += (float)item.InterestRate;
                        FloorFee += (float)item.FloorFee;
                    }
                }
                dateSevenDay = fromDate;
                dateNow = toDate;
                return Page();
            }
            return RedirectToPage("/Guest/Restoran_Login/Login");
        }
    }
}