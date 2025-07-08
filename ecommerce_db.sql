-- ========================================
-- FULL SQL FILE FOR E-COMMERCE DATABASE WITH INSERTS + DML
-- ========================================

-- USERS TABLE
CREATE TABLE Users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(100),
  phone VARCHAR(20),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ADDRESSES TABLE
CREATE TABLE Addresses (
  address_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  address_line1 VARCHAR(255),
  address_line2 VARCHAR(255),
  city VARCHAR(100),
  state VARCHAR(100),
  postal_code VARCHAR(10),
  country VARCHAR(100),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- CATEGORIES TABLE
CREATE TABLE Categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);

-- PRODUCTS TABLE
CREATE TABLE Products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  description TEXT,
  price DECIMAL(10,2),
  stock_quantity INT
);

-- PRODUCT_CATEGORIES TABLE
CREATE TABLE Product_Categories (
  product_id INT,
  category_id INT,
  PRIMARY KEY (product_id, category_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id),
  FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- CART TABLES
CREATE TABLE Cart (
  cart_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Cart_Items (
  cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
  cart_id INT,
  product_id INT,
  quantity INT,
  FOREIGN KEY (cart_id) REFERENCES Cart(cart_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- WISHLIST TABLES
CREATE TABLE Wishlist (
  wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Wishlist_Items (
  wishlist_item_id INT AUTO_INCREMENT PRIMARY KEY,
  wishlist_id INT,
  product_id INT,
  FOREIGN KEY (wishlist_id) REFERENCES Wishlist(wishlist_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- ORDERS TABLES
CREATE TABLE Orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  address_id INT,
  order_date DATETIME,
  total_amount DECIMAL(10,2),
  status VARCHAR(50),
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (address_id) REFERENCES Addresses(address_id)
);

CREATE TABLE Order_Items (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- SHIPMENTS TABLE
CREATE TABLE Shipments (
  shipment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  shipped_date DATETIME,
  delivery_date DATETIME,
  status VARCHAR(50),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- PAYMENTS TABLE
CREATE TABLE Payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  payment_mode VARCHAR(50),
  amount DECIMAL(10,2),
  payment_date DATETIME,
  status VARCHAR(50),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- REVIEWS TABLE
CREATE TABLE Reviews (
  review_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  user_id INT,
  rating INT CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES Products(product_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ========================================
-- INSERTS INTO ALL TABLES
-- ========================================
-- USERS
INSERT INTO Users (name, email, password, phone) VALUES
('Alice Sharma', 'alice@example.com', 'pass123', '9876543210'),
('Bob Kumar', 'bob@example.com', 'pass456', '9876501234'),
('Charlie Verma', 'charlie@example.com', 'pass789', '9876567890'),
('Deepa Singh', 'deepa@example.com', 'pass321', '9876512345'),
('Esha Rani', 'esha@example.com', 'pass654', '9876598765');

-- CATEGORIES
INSERT INTO Categories (name) VALUES
('Electronics'), ('Books'), ('Fashion'), ('Footwear'), ('Accessories');

-- PRODUCTS
INSERT INTO Products (name, description, price, stock_quantity) VALUES
('Smartphone', 'Android phone 6GB RAM', 15000.00, 50),
('Laptop', 'i5 10th Gen 8GB RAM', 55000.00, 20),
('Bluetooth Headphones', 'Wireless headphones with mic', 2500.00, 100),
('Python Book', 'Learn Python Programming', 500.00, 200),
('Running Shoes', 'Running shoes size 9', 3000.00, 75);

-- PRODUCT_CATEGORIES
INSERT INTO Product_Categories VALUES
(1, 1), (2, 1), (3, 1), (3, 5), (4, 2), (5, 4);

-- ADDRESSES
INSERT INTO Addresses (user_id, address_line1, address_line2, city, state, postal_code, country) VALUES
(1, '123 Street', 'Apt 1', 'Delhi', 'Delhi', '110001', 'India'),
(2, '456 Avenue', NULL, 'Mumbai', 'Maharashtra', '400001', 'India'),
(3, '789 Road', 'Block B', 'Bengaluru', 'Karnataka', '560001', 'India'),
(4, '321 Lane', NULL, 'Chennai', 'Tamil Nadu', '600001', 'India'),
(5, '654 Blvd', 'Suite 5', 'Hyderabad', 'Telangana', '500001', 'India');

-- CARTS
INSERT INTO Cart (user_id) VALUES (1), (2), (3), (4), (5);
INSERT INTO Cart_Items (cart_id, product_id, quantity) VALUES
(1, 1, 1), (2, 2, 1), (3, 4, 2), (4, 3, 1), (5, 5, 1);

-- WISHLISTS
INSERT INTO Wishlist (user_id) VALUES (1), (2), (3), (4), (5);
INSERT INTO Wishlist_Items (wishlist_id, product_id) VALUES
(1, 2), (2, 1), (3, 3), (4, 5), (5, 4);

-- ORDERS
INSERT INTO Orders (user_id, address_id, order_date, total_amount, status) VALUES
(1, 1, '2025-07-01 10:00:00', 17500.00, 'Shipped'),
(2, 2, '2025-07-02 11:00:00', 55000.00, 'Delivered'),
(3, 3, '2025-07-03 12:00:00', 1000.00, 'Processing'),
(4, 4, '2025-07-04 13:00:00', 5500.00, 'Shipped'),
(5, 5, '2025-07-05 14:00:00', 3000.00, 'Delivered');
INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 15000.00), (1, 3, 1, 2500.00), (2, 2, 1, 55000.00), (3, 4, 2, 1000.00), (4, 3, 2, 5000.00), (5, 5, 1, 3000.00);

-- SHIPMENTS
INSERT INTO Shipments (order_id, shipped_date, delivery_date, status) VALUES
(1, '2025-07-02', '2025-07-05', 'In Transit'),
(2, '2025-07-03', '2025-07-06', 'Delivered'),
(3, '2025-07-04', NULL, 'Processing'),
(4, '2025-07-05', NULL, 'In Transit'),
(5, '2025-07-06', '2025-07-09', 'Delivered');

-- PAYMENTS
INSERT INTO Payments (order_id, payment_mode, amount, payment_date, status) VALUES
(1, 'Credit Card', 17500.00, '2025-07-01', 'Paid'),
(2, 'UPI', 55000.00, '2025-07-02', 'Paid'),
(3, 'COD', 1000.00, NULL, 'Pending'),
(4, 'Net Banking', 5500.00, '2025-07-04', 'Paid'),
(5, 'Credit Card', 3000.00, '2025-07-05', 'Paid');

-- REVIEWS
INSERT INTO Reviews (product_id, user_id, rating, comment) VALUES
(1, 1, 5, 'Great phone!'), (2, 2, 4, 'Good laptop for work'), (3, 3, 3, 'Sound could be better'), (4, 4, 5, 'Excellent book'), (5, 5, 4, 'Comfortable shoes');

-- SAMPLE DML
UPDATE Products SET stock_quantity = stock_quantity - 1 WHERE product_id = 1;
UPDATE Orders SET status = 'Delivered' WHERE order_id = 1;
DELETE FROM Wishlist_Items WHERE wishlist_item_id = 3;
INSERT INTO Categories (name) VALUES ('Home Appliances');
SELECT * FROM Users;
SELECT o.order_id, u.name, o.status FROM Orders o JOIN Users u ON o.user_id = u.user_id;
SELECT product_id, AVG(rating) AS avg_rating FROM Reviews GROUP BY product_id;
DELETE FROM Cart_Items WHERE cart_item_id = 2;
UPDATE Addresses SET city = 'New Delhi' WHERE address_id = 1;
