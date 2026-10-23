-- Data Transformer
-- Simple MySQL practice project

CREATE DATABASE IF NOT EXISTS data_transformer;
USE data_transformer;

-- 1. Create tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    RegistrationDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2)
);

-- 2. Add sample data
INSERT INTO Customers VALUES
(1, 'John', 'Doe', ' john.doe@email.com ', '2022-03-15'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '2021-11-02'),
(3, 'Alex', 'Patel', 'alex.patel@email.com', '2023-01-10');

INSERT INTO Orders VALUES
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 650.75),
(103, 1, '2023-08-12', 1200.00);

INSERT INTO Employees VALUES
(1, 'Mark', 'Johnson', 'Sales', '2020-01-15', 50000.00),
(2, 'Susan', 'Lee', 'HR', '2021-03-20', 55000.00),
(3, 'Ravi', 'Shah', 'IT', '2022-06-10', 40000.00);

-- 3. INNER JOIN: orders with matching customer details
SELECT o.OrderID, c.FirstName, c.LastName, o.OrderDate, o.TotalAmount
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 4. LEFT JOIN: all customers, including those without orders
SELECT c.CustomerID, c.FirstName, c.LastName, o.OrderID, o.TotalAmount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 5. RIGHT JOIN: all orders and matching customer details
SELECT o.OrderID, c.FirstName, c.LastName, o.TotalAmount
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 6. FULL OUTER JOIN alternative for MySQL (LEFT JOIN + unmatched right rows)
SELECT c.CustomerID, c.FirstName, o.OrderID, o.TotalAmount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
UNION
SELECT c.CustomerID, c.FirstName, o.OrderID, o.TotalAmount
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 7. Customers with an order above the average order amount
SELECT DISTINCT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);

-- 8. Employees earning above the average salary
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- 9. Get year and month from order date
SELECT OrderID, YEAR(OrderDate) AS OrderYear,
       MONTH(OrderDate) AS OrderMonth
FROM Orders;

-- 10. Days between order date and today
SELECT OrderID, OrderDate, DATEDIFF(CURDATE(), OrderDate) AS DaysPassed
FROM Orders;

-- 11. Show order date as DD-MMM-YYYY
SELECT OrderID, DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedDate
FROM Orders;

-- 12. Combine first and last name
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers;

-- 13. Replace John with Jonathan in the first name
SELECT REPLACE(FirstName, 'John', 'Jonathan') AS UpdatedFirstName
FROM Customers;

-- 14. Uppercase first name and lowercase last name
SELECT UPPER(FirstName) AS FirstName, LOWER(LastName) AS LastName
FROM Customers;

-- 15. Remove extra spaces around email
SELECT TRIM(Email) AS CleanEmail
FROM Customers;

-- 16. Running total of order amounts
SELECT OrderID, OrderDate, TotalAmount,
       SUM(TotalAmount) OVER (ORDER BY OrderDate, OrderID) AS RunningTotal
FROM Orders;

-- 17. Rank orders by amount (highest amount gets rank 1)
SELECT OrderID, TotalAmount,
       RANK() OVER (ORDER BY TotalAmount DESC) AS OrderRank
FROM Orders;

-- 18. Discount based on order amount
SELECT OrderID, TotalAmount,
       CASE
           WHEN TotalAmount > 1000 THEN TotalAmount * 0.10
           WHEN TotalAmount > 500 THEN TotalAmount * 0.05
           ELSE 0
       END AS DiscountAmount
FROM Orders;

-- 19. Categorize employee salary
SELECT EmployeeID, FirstName, LastName, Salary,
       CASE
           WHEN Salary >= 55000 THEN 'High'
           WHEN Salary >= 45000 THEN 'Medium'
           ELSE 'Low'
       END AS SalaryCategory
FROM Employees;
