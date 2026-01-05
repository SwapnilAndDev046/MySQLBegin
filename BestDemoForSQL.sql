-- Initial commands 
create database school_db;-- create new database
show databases;-- shows all databases
use school_db;-- selects database from all databases

SELECT database(); -- use to what database is selected

DROP database college_db; -- use to delete any database

create database company;

use company;

-- Creating a new table in selected databases  
-- column datatype constraint  e.g employee_id    int    primary key
create table employee(
-- unique and primary key creates index due to that finding becomes easy

	employee_id int primary key auto_increment, -- primary key
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    hire_date date default (current_date()), -- use default when data is not assign 
    phone_number varchar(100) unique,
    email_id varchar (100) unique,
    Salary decimal(10,2) check (Salary > 0), -- expression in ()
    employement_status enum('active','on leave','terminated') default 'active',
    -- best practice must have
    created_at timestamp default current_timestamp, -- this is the column in table update when something new row added 
    updated_at timestamp default current_timestamp on update current_timestamp -- this 

);
-- Inserting into created table 
INSERT INTO employee(
	employee_id,
    first_name,
    last_name,
    hire_date,
    phone_number,
    email_id,
    Salary
)
VALUE(
	1,
    'Swapnil',
    'Devkate',
    '2026-08-05',
    '+91 9283665212',
    'swapnildevkate@gmail.com',
    140000.45
);


-- To see the whole table SELECT

SELECT * from employee;

 




