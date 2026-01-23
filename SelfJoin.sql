-- Self JOIN in SQL Demonstration
-- This script demonstrates how to use Self JOINs to query hierarchical and relational data
-- within the same table, using an employee management system example.

-- Create and use database
CREATE DATABASE self_join_tutorial;
USE self_join_tutorial;

-- Create employees table with manager_id referencing the same table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    job_title VARCHAR(100),
    salary DECIMAL(10, 2),
    department VARCHAR(50),
    manager_id INT,
    hire_date DATE
);

-- Insert sample employee data with hierarchical management structure
INSERT INTO employees VALUES
(1, 'James', 'Smith', 'CEO', 150000.00, 'Executive', NULL, '2010-01-15'),
(2, 'Sarah', 'Johnson', 'CTO', 140000.00, 'Technology', 1, '2011-03-10'),
(3, 'Michael', 'Williams', 'CFO', 140000.00, 'Finance', 1, '2012-07-22'),
(4, 'Jessica', 'Brown', 'HR Director', 110000.00, 'Human Resources', 1, '2013-05-18'),
(5, 'David', 'Miller', 'Senior Developer', 95000.00, 'Technology', 2, '2014-11-05'),
(6, 'Emily', 'Davis', 'Developer', 80000.00, 'Technology', 5, '2016-08-12'),
(7, 'Robert', 'Wilson', 'Junior Developer', 65000.00, 'Technology', 5, '2019-02-28'),
(8, 'Jennifer', 'Taylor', 'Accountant', 75000.00, 'Finance', 3, '2015-09-17'),
(9, 'Thomas', 'Anderson', 'Accountant', 72000.00, 'Finance', 3, '2017-06-24'),
(10, 'Lisa', 'Martinez', 'HR Specialist', 68000.00, 'Human Resources', 4, '2018-04-30');



-- department are same 

select distinct e1.job_title, e2.job_title,e1.department from employees e1
join employees e2 on e1.employee_id < e2.employee_id;


select  group_concat(distinct emp.job_title) as'boss',
group_concat(mgr.job_title), emp.department  
from employees emp join employees mgr 
on emp.employee_id = mgr.manager_id 
group by emp.department;


-- employees who earns more than there managers

select e1.salary as manager_salary, e1.job_title as manager, 
e2.job_title as employee, e2.salary as employee_salary from employees e1 
join employees e2 on e1.employee_id = e2.manager_id where e2.salary > e1.salary;

-- calaculate average salary diffrene between employees and manager
select avg(e1.salary - e2.salary) from employees e1 
join employees e2 on e1.employee_id = e2.manager_id;