create database Retail_Project;
use Retail_Project;

CREATE TABLE customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Gender VARCHAR(10),
    City VARCHAR(50),
    JoinDate DATE
);


CREATE TABLE products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price INT
);


CREATE TABLE sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    TotalAmount INT,
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);


SHOW TABLES;

-- Total Revenue --
SELECT SUM(TotalAmount) AS Total_Revenue
FROM sales;


-- Category-wise Revenue -- 
SELECT p.Category,
       SUM(s.TotalAmount) AS Category_Revenue
FROM sales s
JOIN products p
ON s.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY Category_Revenue DESC;


-- Monthly Sales Trend --
SELECT MONTH(OrderDate) AS Month_No,
       MONTHNAME(OrderDate) AS Month_Name,
       SUM(TotalAmount) AS Monthly_Sales
FROM sales
GROUP BY Month_No, Month_Name
ORDER BY Month_No;


-- Top 10 Best-Selling Products--
SELECT p.ProductName,
       SUM(s.TotalAmount) AS Total_Sales
FROM sales s
JOIN products p
ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY Total_Sales DESC
LIMIT 10;


-- City-wise Customers --
SELECT City,
       COUNT(CustomerID) AS Total_Customers
FROM customers
GROUP BY City
ORDER BY Total_Customers DESC;


-- Repeat Customers -- 
SELECT CustomerID,
       COUNT(SaleID) AS Total_Orders
FROM sales
GROUP BY CustomerID
HAVING Total_Orders > 1;


-- Average Order Value --
SELECT AVG(TotalAmount) AS Average_Order_Value
FROM sales;


-- YEAR-WISE SALES -- 
SELECT YEAR(OrderDate) AS Year,
       SUM(TotalAmount) AS Yearly_Sales
FROM sales
GROUP BY YEAR(OrderDate)
ORDER BY Year;


-- MONTH-WISE SALES --
SELECT EXTRACT(MONTH FROM OrderDate) AS Month_No,
       SUM(TotalAmount) AS Monthly_Sales
FROM sales
GROUP BY EXTRACT(MONTH FROM OrderDate)
ORDER BY Month_No;


-- CUSTOMER-WISE TOTAL SPEND --
SELECT c.CustomerID,
       c.Name,
       SUM(s.TotalAmount) AS Total_Spent
FROM sales s
JOIN customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.Name
ORDER BY Total_Spent DESC
LIMIT 10;


-- LOW PERFORMING PRODUCTS --
SELECT p.ProductName,
       SUM(s.TotalAmount) AS Total_Sales
FROM sales s
JOIN products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY Total_Sales ASC
LIMIT 5;


-- ORDERS COUNT PER MONTH --
SELECT MONTH(OrderDate) AS Month,
       COUNT(SaleID) AS Total_Orders
FROM sales
GROUP BY MONTH(OrderDate)
ORDER BY Month;
