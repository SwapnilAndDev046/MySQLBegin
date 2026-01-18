
-- =================
-- STRING FUNCTIONS
-- =================


-- String Functions
use companya;
CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(200) DEFAULT NULL,
    department VARCHAR(100) NOT NULL,
    email_id VARCHAR(100) NOT NULL,
    phone_number VARCHAR(100) NOT NULL,
    salary FLOAT DEFAULT 14000.3,
    PRIMARY KEY (id),
    UNIQUE KEY email_id (email_id),
    UNIQUE KEY phone_number (phone_number),
    CONSTRAINT employees_chk_1 CHECK (salary > 0)
);

INSERT INTO employees (name, department, email_id, phone_number, salary)
VALUES
('John Doe', 'IT', 'john.doe@example.com', '9876543210', 25000.50),
('Jane Smith', 'HR', 'jane.smith@example.com', '9876543211', 22000.00),
('Michael Brown', 'Finance', 'michael.brown@example.com', '9876543212', 30000.75),
('Emily Davis', 'Marketing', 'emily.davis@example.com', '9876543213', 21000.00),
('Robert Wilson', 'IT', 'robert.wilson@example.com', '9876543214', 28000.25);

select * from employees;

select concat_ws(' ',name,department) as 'Name' from employees; -- concatenation String Function
select ucase(name) as "Name" from employees; -- Makes the column uppercase
select lcase(name) as "Name" from employees; -- lowercase the String
select length(name) as 'Each name length' from employees; -- length() function 
select trim("     Hello orld!!!   ") as 'trimming' from employees; -- trims the blank space from back and front
select name, substring(name,1,9) as 'substring of name' from employees;-- gives the substring of any string (ColName,from , end)
select char_length('स्वप्नील'); -- means actual length
select name , locate('sh' , name) as 'index of charater' from employees;-- locates the perticular character in (characterName, ColnName)
select name , locate('a' , name) as 'index of charater' from employees;-- locates the perticular character in (characterName, ColnName)
select name, replace(email_id,'sajeedpathan@gmail.com','AbcReplace@hotmail.com') as 'Replce in email' from employees;
select count(*) from employees; -- calculate number of rows
select name , reverse(name) from employees;-- reverse the column
select name, left(name,2) as "From left selected", right(name, 2) as "from right selected" from employees;
select name, ascii(name) as 'ascii' from employees; -- ascii of the words
select name, department from employees 
order by field(department,'IT','HR','SDE','Marketing','Finance'); -- custom order by 
select * from employees where soundex('sunita nair') = soundex(name); -- similar sounding

USE db_inner_join; 
select b.title, a.first_name, a.last_name, group_concat(d.category_name)  from authors a 
inner join books b on b.author_id  = a.author_id 
inner join book_categories c on c.book_id = b.book_id
inner join categories d on d.category_id = c.category_id group by b.book_id;-- group concate make the things form grouping

-- =================
-- NUMERIC FUNCTIONS
-- =================


-- Mathmatics Functions
CREATE DATABASE NumericFunctionsDB;
USE NumericFunctionsDB;

CREATE TABLE numbers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    num_value DECIMAL(10,5)
);

INSERT INTO numbers (num_value) VALUES
(25.6789),
(-17.5432),
(100.999),
(-0.4567),
(9.5),
(1234.56789),
(0);


USE NumericFunctionsDB;
select * from numbers;

select num_value , ABS(num_value) from numbers; -- absolute value in maths
select num_value , ceil(num_value),floor(num_value) from numbers;-- round down and round up
select num_value , round(num_value,2) from numbers;-- custom round  
select num_value , truncate(num_value, 2) from numbers;-- doesn't round just cut 
select num_value , power(num_value, 3) from numbers; -- find power of number
select num_value , mod(num_value, 2) from numbers; -- mod(x,y)
select num_value , sqrt(num_value) from numbers; -- square root

select num_value , exp(num_value) from numbers; -- e power num_value - exponential
-- Error Code: 1690. DOUBLE value is out of range in 'exp(`numericfunctionsdb`.`numbers`.`num_value`)'
-- solution:

select num_value, 
case when num_value > 709 
then 'value too large for exp()'
else exp(num_value)
end as 'exp_value' from numbers;-- when num value greate 

select num_value, log2(num_value),log10(num_value) from numbers; -- log base 2 and log base 10
select num_value, sin(num_value), cos(num_value), tan(num_value) from numbers; -- trignometry
select pi();
select num_value, radians(num_value), degrees(num_value) from numbers; -- degree and radian
select bit_and(num_value) from numbers; -- the function are round and taking only numbers not decimal
select bit_or(num_value) from numbers;
select bit_xor(num_value) from numbers;


-- =================
-- DATE FUNCTIONS
-- =================

-- date and time functions

-- Date and time data types:
-- DATE	        YYYY-MM-DD           Stores only date without time
-- DATETIME     YYYY-MM-DD HH:MI:SS  Stores date and time
-- TIMESTAMP    YYYY-MM-DD HH:MI:SS  Stores date/time with automatic UTC conversion
-- TIME         HH:MI:SS             Stores only time
-- YEAR         YYYY                 Stores only a four-digit year


select now(); -- current time and date
select curdate(); -- gives only date current 
select curtime(); -- gives current time 
select year(now()); -- current year
select month(now()); -- current month
select week(now()); -- current week
select day(now()); -- current day
select hour(now()); -- current hour
select minute(now()); -- current minute
select second(now()); -- current second

select date_format('2004-08-23', '%e/%m/%Y') as formatted_date; -- yyyy-mm-dd

-- date adding and subtracting
select date_add('2004-08-05', interval 22 year) as 'add shit';
select date_add('2004-08-05', interval 22 month) as 'add shit';
select date_add('2004-08-05', interval 22 day) as 'add shit'; -- addition
select date_sub('2024-07-31', interval 21 year);-- subtraction

select (datediff('2024-08-04','2014-05-12'));-- date in between diffrence

-- Date function examples with a database
CREATE DATABASE DateExamplesDB;
USE DateExamplesDB;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATETIME
);

INSERT INTO orders (customer_name, order_date) VALUES
('Alice', '2025-03-01 10:15:00'),
('Bob', '2025-03-02 14:45:30'),
('Charlie', '2025-03-03 09:30:15'),
('Akshay', '2024-03-01 10:15:00');

select * from orders;
select * from orders where datediff(now(),order_date) < 365;
-- =================
-- AGGREGATE FUNCTIONS
-- =================
-- Used to perform calculations on multiple rows of data and return a single summarized value
-- COUNT() – Returns the number of rows
-- SUM() – Returns the sum of a numeric column
-- AVG() – Returns the average value of a numeric column
-- MIN() – Returns the minimum value
-- MAX() – Returns the maximum value

use companya;
show tables;

select * from employees;
select count(*) from employees where department = 'HR';
select sum(salary) from employees where department = 'HR';
select avg(salary) from employees where department = 'HR';

select 
count(*) as num_employees, 
sum(salary) as total_salary,
avg(salary) as average_salary,
max(salary) as max_salary,
min(salary) as Min_salary
from employees;

