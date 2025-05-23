﻿using System;
using System.Collections.Generic;

namespace FoodStoreAPI.Models
{
    public partial class Product
    {
        public Product()
        {
            OrderItems = new HashSet<OrderItem>();
            ProductReviews = new HashSet<ProductReview>();
            Transactions = new HashSet<Transaction>();
        }

        public int ProId { get; set; }
        public string? Name { get; set; }
        public decimal? Price { get; set; }
        public double? OriginalPrice { get; set; }
        public string? Unit { get; set; }
        public string? Images { get; set; }
        public DateTime? CreateAt { get; set; }
        public DateTime? UpdateAt { get; set; }
        public int? Quantity { get; set; }
        public string? ProductStatus { get; set; }
        public int? AccId { get; set; }
        public int? CateId { get; set; }
        public DateTime? DiscountStartTime { get; set; }
        public DateTime? DiscountEndTime { get; set; }
        public decimal? DiscountPercentage { get; set; }

        public virtual Account? Acc { get; set; }
        public virtual Category? Cate { get; set; }
        public virtual ICollection<OrderItem> OrderItems { get; set; }
        public virtual ICollection<ProductReview> ProductReviews { get; set; }
        public virtual ICollection<Transaction> Transactions { get; set; }
    }
}
