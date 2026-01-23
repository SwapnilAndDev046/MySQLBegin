-- ====================================================================
-- MySQL FULL JOIN Lecture - Complete SQL Script
-- ====================================================================

-- Introduction to FULL JOIN
-- ====================================================================
-- FULL JOIN
-- - It returns all matching rows from both tables where the join condition is met
-- - It also returns all non-matching rows from the left table (with NULL values for columns from the right table)
-- - It also returns all non-matching rows from the right table (with NULL values for columns from the left table)
-- - It combines the results of both LEFT JOIN and RIGHT JOIN, including all records from both tables and matching records from both sides where available.
--
-- Note: MySQL does not natively support FULL JOIN, but we can emulate it using UNION of LEFT JOIN and RIGHT JOIN

-- Join Types Comparison:
-- - INNER JOIN (only returns matching rows between tables)
-- - LEFT JOIN (returns all rows from left table and matching from right)
-- - RIGHT JOIN (returns all rows from right table and matching from left)
-- - FULL JOIN (returns all rows from both tables)

-- Database Setup - Friends Theme
-- ====================================================================
CREATE DATABASE friends_db;
USE friends_db;

-- Create tables for our demonstration
CREATE TABLE characters (
    character_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    occupation VARCHAR(100)
);

CREATE TABLE apartments (
    apartment_id INT PRIMARY KEY,
    building_address VARCHAR(100) NOT NULL,
    apartment_number VARCHAR(10) NOT NULL,
    monthly_rent DECIMAL(8, 2),
    current_tenant_id INT
);

-- Sample Data
-- ====================================================================
-- Insert data into characters
INSERT INTO characters (character_id, first_name, last_name, occupation) VALUES
(1, 'Ross', 'Geller', 'Paleontologist'),
(2, 'Rachel', 'Green', 'Fashion Executive'),
(3, 'Chandler', 'Bing', 'IT Procurement Manager'),
(4, 'Monica', 'Geller', 'Chef'),
(5, 'Joey', 'Tribbiani', 'Actor'),
(6, 'Phoebe', 'Buffay', 'Massage Therapist'),
(7, 'Gunther', 'Smith', 'Coffee Shop Manager'),
(8, 'Janice', 'Hosenstein', 'Unknown');

-- Insert data into apartments
INSERT INTO apartments (apartment_id, building_address, apartment_number, monthly_rent, current_tenant_id) VALUES
(101, '90 Bedford Street', '20', 3500.00, 3),
(102, '90 Bedford Street', '19', 3500.00, 4),
(103, '5 Morton Street', '14', 2800.00, 6),
(104, '17 Grove Street', '3B', 2200.00, NULL),
(105, '15 Yemen Road', 'Yemen', 900.00, NULL),
(106, '495 Grove Street', '7', 2400.00, 1);

-- View table data
-- ====================================================================
SELECT * FROM characters;
SELECT * FROM apartments;


-- full join
-- left join
select c.character_id, c.first_name, c.last_name, 
a.apartment_id, a.building_address, a.apartment_number, a.monthly_rent 
from characters c 
left join apartments a on c.character_id = a.current_tenant_id 
 
union 
 
-- right join
select d.character_id,d.first_name,d.last_name,
b.apartment_id, b.building_address, b.apartment_number, b.monthly_rent 
from characters d 
right join apartments b on d.character_id = b.current_tenant_id;