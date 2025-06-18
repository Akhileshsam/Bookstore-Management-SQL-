create database project1;
use project1;


-- : Create Tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    BookID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- STEP 2: Insert Sample Data
INSERT INTO Customers VALUES
(1, 'Alice Smith', 'alice@example.com', '1234567890'),
(2, 'Bob Johnson', 'bob@example.com', '9876543210'),
(3, 'Clara Kent', 'clara@example.com', '5551234567');
select * from customers;

INSERT INTO Books VALUES
(101, 'The Alchemist', 'Paulo Coelho', 15.99, 10),
(102, '1984', 'George Orwell', 12.49, 5),
(103, 'Clean Code', 'Robert C. Martin', 35.00, 8);
select * from books;

INSERT INTO Orders VALUES
(201, 1, 101, 2, '2025-05-01'),
(202, 2, 103, 1, '2025-05-02'),
(203, 1, 102, 3, '2025-05-03');
select * from orders;
--  Simple JOIN Queries

-- 1. Show customer names and their order IDs
SELECT Customers.Name, Orders.OrderID
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 2. Show book titles and their order IDs
SELECT Books.Title, Orders.OrderID
FROM Books
JOIN Orders ON Books.BookID = Orders.BookID;

-- 3. Show customer name and book title for each order
SELECT Customers.Name, Books.Title
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Books ON Orders.BookID = Books.BookID;

--  Simple Subqueries

-- 1. Books that cost more than the average price
SELECT Title FROM Books
WHERE Price > (SELECT AVG(Price) FROM Books);

-- 2. Customers who have placed an order
SELECT Name FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders);

-- 3. Titles of books that have been ordered
SELECT Title FROM Books
WHERE BookID IN (SELECT BookID FROM Orders);

--  Views

-- 1. View with order and customer name
CREATE VIEW SimpleOrderView AS
SELECT OrderID, Name
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
select * from SimpleOrderView;

-- 2. View with book title and price
CREATE VIEW BookPriceView AS
SELECT Title, Price FROM Books;
select * from BookPriceView;

-- 3. View with customer and book they ordered
CREATE VIEW CustomerBookView AS
SELECT Customers.Name, Books.Title
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Books ON Orders.BookID = Books.BookID;
select * from CustomerBookView;

describe customers;

describe books;

describe orders;