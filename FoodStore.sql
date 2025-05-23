create database FoodStore
Go
USE FoodStore
GO
/****** Object:  Table [dbo].[Account]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccID] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](30) NULL,
	[phone] [nvarchar](10) NULL,
	[name] [nvarchar](30) NULL,
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](max) NULL,
	[wallet] [float] NULL,
	[create_at] [datetime] NULL,
	[update_at] [datetime] NULL,
	[RoleID] [int] NULL,
	[Address] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[AccID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Username] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountShipped]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountShipped](
	[AccID] [int] NOT NULL,
	[TransId] [int] NULL,
	[AddressShop] [nvarchar](max) NULL,
	[AddressCustomer] [nvarchar](max) NULL,
	[create_at] [datetime] NULL,
	[update_at] [datetime] NULL,
	[Status] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[AccID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CateID] [int] IDENTITY(1,1) NOT NULL,
	[CateName] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[CateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messagess]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messagess](
	[messId] [int] IDENTITY(1,1) NOT NULL,
	[FromUserId] [int] NULL,
	[ToUserId] [int] NULL,
	[messageText] [nvarchar](500) NULL,
	[sentTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[messId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OrderItemId] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[create_at] [datetime] NULL,
	[update_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[Gtotal] [float] NULL,
	[create_at] [datetime] NULL,
	[update_at] [datetime] NULL,
	[Status] [nvarchar](30) NULL,
	[OrderDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NULL,
	[Price] [money] NULL,
	[OriginalPrice] [float] NULL,
	[Unit] [nvarchar](30) NULL,
	[images] [nvarchar](max) NULL,
	[create_at] [datetime] NULL,
	[update_at] [datetime] NULL,
	[quantity] [int] NULL,
	[productStatus] [nvarchar](20) NULL,
	[AccID] [int] NULL,
	[CateID] [int] NULL,
	[DiscountStartTime] [datetime] NULL,
	[DiscountEndTime] [datetime] NULL,
	[DiscountPercentage] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductReviews]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductReviews](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[images] [nvarchar](max) NULL,
	[create_at] [datetime] NULL,
	[update_at] [datetime] NULL,
	[star] [int] NULL,
	[ProID] [int] NULL,
	[AccID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Revenue]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Revenue](
	[revenueId] [int] IDENTITY(1,1) NOT NULL,
	[revenuePrice] [float] NULL,
	[interestRate] [float] NULL,
	[FloorFee] [float] NULL,
	[create_At] [datetime] NULL,
	[AccID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[revenueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Token]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Token](
	[TokenId] [int] IDENTITY(1,1) NOT NULL,
	[create_at] [datetime] NULL,
	[tokenString] [nvarchar](max) NULL,
	[ExpirationDate] [datetime] NULL,
	[Status] [int] NULL,
	[AccID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TokenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 11/11/2024 7:58:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[TransId] [int] IDENTITY(1,1) NOT NULL,
	[AccID] [int] NULL,
	[ProID] [int] NULL,
	[TransDate] [datetime] NULL,
	[Amount] [decimal](18, 0) NULL,
	[Status] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[TransId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[AccountShipped]  WITH CHECK ADD FOREIGN KEY([AccID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[AccountShipped]  WITH CHECK ADD FOREIGN KEY([TransId])
REFERENCES [dbo].[Transactions] ([TransId])
GO
ALTER TABLE [dbo].[Messagess]  WITH CHECK ADD FOREIGN KEY([FromUserId])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[Messagess]  WITH CHECK ADD FOREIGN KEY([ToUserId])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([AccID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CateID])
REFERENCES [dbo].[Category] ([CateID])
GO
ALTER TABLE [dbo].[ProductReviews]  WITH CHECK ADD FOREIGN KEY([AccID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[ProductReviews]  WITH CHECK ADD FOREIGN KEY([ProID])
REFERENCES [dbo].[Product] ([ProID])
GO
ALTER TABLE [dbo].[Revenue]  WITH CHECK ADD FOREIGN KEY([AccID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[Token]  WITH CHECK ADD FOREIGN KEY([AccID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD FOREIGN KEY([AccID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD FOREIGN KEY([ProID])
REFERENCES [dbo].[Product] ([ProID])
GO


insert into Category
values ('Breakfast'),('Launch'),('Dinner'),('Drinks')

insert into Role
values('Admin'),('Shipper'),('Customer'),('Sale')

--mk: 123456
insert into Account(email,username,password,RoleID)
values ('Admin@gmail.com','Admin','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1),
       ('Customer@gmail.com','Customer','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 3),
	   ('Shipper@gamil.com','Ship','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',2),
	   ('Saler@gamil.com','Sale','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',4);
insert into Token(Status, AccID)
values (1,1),(1,2),(1,3),(1,4);

INSERT INTO Product (Name, OriginalPrice, Price, Unit, quantity, images, AccID, CateID, productStatus)
VALUES (N'Phở', 20000, 35000, 'Meal',10,'https://photo.znews.vn/w660/Uploaded/anqyy/2024_08_12/pho_bo_ivivu_2.jpeg',4, 1,'On'),
       (N'Bún Bò', 20000, 35000, 'Meal',10,'https://satrafoods.com.vn/uploads/Images/mon-ngon-moi-ngay/bun-bo-hue.jpg',4, 1,'On'),
       (N'Bánh Cuốn', 20000, 35000, 'Meal',10,'https://upload.wikimedia.org/wikipedia/commons/8/8c/Banh_Cuon_VN.jpg',4, 1,'On'),
       (N'Phở Cuốn', 20000, 35000, 'Meal',10,'https://cdn-i.vtcnews.vn/resize/th/upload/2023/04/22/pho-cuon-ha-noi-1-911x1024-00423100.jpg',4, 1,'On'),
       (N'Xôi', 20000, 35000, 'Meal',10,'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171330393361.jpg',4, 1,'On'),
       (N'Cháo', 20000, 35000, 'Meal',10,'https://luongthuc.org/wp-content/uploads/2022/09/Tieu-chi-chon-gao-tam-nau-chao-dinh-duong-ngon-chat-luong.jpg',4, 1,'On'),
       (N'Cơm Gà', 20000, 40000, 'Meal',10,'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:quality(100)/2023_12_18_638385185797352600_bat-mi-cach-lam-com-ga-thom-ngon-dam-da-chuan-vi-cua-tung-vung-mien-khac-nhau.jpg',4, 2,'On'),
	   (N'Cơm Lươn', 20000, 40000, 'Meal',10,'https://nguyenhafood.vn/uploads/files/com-luon-nhat-ban%20%281%29.jpg',4, 2,'On'),
	   (N'Cơm Tấm', 20000, 40000, 'Meal',10,'https://bizweb.dktcdn.net/100/442/328/files/hi-nh-avatar-website-cnsg.jpg?v=1644485704509',4, 2,'On'),
	   (N'Cơm Vịt', 20000, 40000, 'Meal',10,'https://lh4.googleusercontent.com/proxy/eSgOHySkD2nCAXAU7xNShS5mS8R1WUtQSOi-ku1Ywr2XkGA3aQB7gvJTEf5nLXlEtOczkQ0rjh9RyOrL6zVkqvEshykFbjiNY4hFmE1WNuS0HQ',4, 2,'On'),
       (N'Salad', 20000, 40000, 'Meal',10,'https://www.foodandwine.com/thmb/IuZPWAXBp4YaT9hn1YLHhuijT3k=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/FAW-recipes-big-italian-salad-hero-83e6ea846722478f8feb1eea33158b00.jpg',4, 2,'On'),
       (N'Khoai Tây Chiên', 20000, 35000, 'Meal',10,'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:quality(100)/2023_9_28_638315154313184024_cach-lam-khoai-tay-chien-1.JPG',4, 2,'On'),
       (N'Sushi', 20000, 200000, 'Meal',10,'https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Sushi_platter.jpg/1200px-Sushi_platter.jpg',4, 3,'On'),
       (N'Ramen', 20000, 70000, 'Meal',10,'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Shoyu_Ramen.jpg/800px-Shoyu_Ramen.jpg',4, 3,'On'),
       (N'Tempura', 20000, 70000, 'Meal',10,'https://www.allrecipes.com/thmb/xWetQsyyrT2R0V4hgS00m2961Hk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/129467-crispy-shrimp-tempura-ddmfs-4x3-1279-0d2e8debf0e04481acb89f60366bd405.jpg',4, 3,'On'),
       (N'Pad Thai', 20000, 50000, 'Meal',10,'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Phat_Thai_kung_Chang_Khien_street_stall.jpg/1200px-Phat_Thai_kung_Chang_Khien_street_stall.jpg',4, 3,'On'),
       (N'Green Curry', 20000, 45000, 'Meal',10,'https://saltedmint.com/wp-content/uploads/2024/03/Thai-green-curry-vegetarian-2.jpg',4, 3,'On'),
       (N'Tom Yum Soup', 20000, 90000, 'Meal',10,'https://minimalistbaker.com/wp-content/uploads/2019/01/Vegan-Tom-Yum-SQUARE.jpg',4, 3,'On');


INSERT INTO Product (Name, OriginalPrice, Price, Unit, quantity, images, AccID, CateID, productStatus)
VALUES (N'Coca Cola', 20000, 15000, 'Can',10,'https://www.coca-cola.com/content/dam/onexp/vn/home-image/coca-cola/Coca-Cola_OT%20320ml_VN-EX_Desktop.png',4, 4,'On'),
       (N'Orange Juice', 20000, 50000, 'Glass',10,'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/12/orange-juice-recipe.jpg',4, 4,'On'),
       (N'Iced Coffee', 20000, 45000, 'Cup',10,'https://images.immediate.co.uk/production/volatile/sites/2/2021/08/coldbrew-iced-latte-with-my-recipe-photo-by-@ellamiller_photo-f1e3d9e.jpg?quality=90&resize=556,505',4, 4,'On'),
       (N'Mango Smoothie', 20000, 50000, 'Cup',10,'https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/B6821ADB-CB37-47B2-8091-C61A43487506/Derivates/35e35439-6bf2-4840-9c46-971393239c29.jpg',4, 4,'On'),
       (N'Green Tea', 20000, 70000, 'Cup',10,'https://product.hstatic.net/200000467213/product/l-intro-1642516069_95836a45219e4251a7284f0b94007f91_1024x1024.jpg',4, 4,'On');