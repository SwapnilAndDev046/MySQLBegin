-- LEFT JOIN (LEFT OUTER JOIN) Tutorial
-- It returns ALL records from the left table and only the matching records from the right table.
-- If no match exists in the right table, NULL values will be returned for the right table's columns.

-- Basic LEFT JOIN syntax
-- SELECT columns
-- FROM table1
-- LEFT JOIN table2
-- ON table1.column = table2.column;

-- Create and set up database
CREATE DATABASE left_join_tutorial;
USE left_join_tutorial;

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    city VARCHAR(50)
);

-- Create orders table with foreign key
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert sample customer data
INSERT INTO customers (customer_id, customer_name, email, city)
VALUES 
    (1, 'John Smith', 'john@example.com', 'New York'),
    (2, 'Jane Doe', 'jane@example.com', 'Los Angeles'),
    (3, 'Robert Johnson', 'robert@example.com', 'Chicago'),
    (4, 'Emily Davis', 'emily@example.com', 'Houston'),
    (5, 'Michael Brown', 'michael@example.com', 'Phoenix');

-- Insert sample order data
INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES 
    (101, 1, '2023-01-15', 150.75),
    (102, 3, '2023-01-16', 89.50),
    (103, 1, '2023-01-20', 45.25),
    (104, 2, '2023-01-25', 210.30),
    (105, 3, '2023-02-01', 75.00);

select * from customers a left join orders b on a.customer_id = b.customer_id;


-- how much order customer have put
select a.customer_id,a.customer_name, 
count(b.order_id) as 'no. of orders', 
group_concat(b.order_id) as 'orders',sum(b.total_amount)
from customers a 
left join orders b 
on a.customer_id = b.customer_id 
group by customer_id;



CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipping_date DATE,
    carrier VARCHAR(50),
    tracking_number VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Insert sample shipping data
INSERT INTO shipping (shipping_id, order_id, shipping_date, carrier, tracking_number)
VALUES 
    (1001, 101, '2023-01-16', 'FedEx', 'FDX123456789'),
    (1002, 104, '2023-01-26', 'UPS', 'UPS987654321'),
    (1003, 105, '2023-02-02', 'USPS', 'USPS456789123');




-- 30 days ago order or no order placed

select c.customer_id, c.customer_name, max(o.order_date) as last_order from customers c 
left join orders o on c.customer_id = o.customer_id 
left join shipping s on o.order_id = s.order_id 
group by c.customer_id
having last_order is null 
or last_order < date_sub( '2023-01-21' , interval 30 day);

