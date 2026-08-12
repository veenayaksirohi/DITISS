-- Drop existing tables if they exist (optional, to start fresh)
DROP DATABASE IF EXISTS sample_db;
CREATE DATABASE sample_db;
USE sample_db;

-- Create customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(100) NOT NULL
);

-- Create orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert 10 dummy customers
INSERT INTO customers (first_name, last_name, email, phone, city) VALUES
('John', 'Doe', 'john.doe@example.com', '+1234567890', 'New York'),
('Jane', 'Smith', 'jane.smith@example.com', '+1234567891', 'Los Angeles'),
('Michael', 'Johnson', 'michael.johnson@example.com', '+1234567892', 'Chicago'),
('Emily', 'Brown', 'emily.brown@example.com', '+1234567893', 'Miami'),
('David', 'Wilson', 'david.wilson@example.com', '+1234567894', 'Boston'),
('Sarah', 'Lee', 'sarah.lee@example.com', '+1234567895', 'San Francisco'),
('Robert', 'Taylor', 'robert.taylor@example.com', '+1234567896', 'Seattle'),
('Lisa', 'Anderson', 'lisa.anderson@example.com', '+1234567897', 'Denver'),
('Thomas', 'Martin', 'thomas.martin@example.com', '+1234567898', 'Portland'),
('Anna', 'Thompson', 'anna.thompson@example.com', '+1234567899', 'Boston');

INSERT INTO orders (customer_id,  total_amount, status) VALUES
(1,  125.50, 'Processing'),
(2,  89.99, 'Delivered'),
(3,  245.00, 'Pending'),
(4,  150.75, 'Shipped'),
(5,  75.25, 'Cancelled'),
(6,  300.00, 'Processing'),
(7,  120.50, 'Delivered'),
(8,  210.00, 'Pending'),
(9,  180.25, 'Shipped'),
(10, 99.99, 'Processing');

-- find customers from 'new york'
select customer_id, first_name, last_name, city 
from customers 
where city = 'New York';

-- find customers from 'new york' or 'chicago' or 'Boston'
select customer_id, first_name, last_name, city 
from customers 
where city = 'New York' or city = 'Chicago' or city = 'Boston';

select customer_id, first_name, last_name, city 
from customers 
where city in ('New York', 'Chicago', 'Boston');

-- find customers having last name 'Wilson' and the person should be from 'Boston'
select customer_id, first_name, last_name, city 
from customers 
where city = 'Boston' and last_name = 'Wilson';

-- find the customers having first_name starting with 'S'
select customer_id, first_name, last_name, city 
from customers 
where first_name LIKE 'J%';

-- find the customers having last_name ending with 'e'
select customer_id, first_name, last_name, city 
from customers 
where last_name LIKE '%e';

-- find the customers having valid email (email containing @ character)
select customer_id, first_name, last_name, city 
from customers 
where email LIKE '%@%';

-- find the orders where the total amount is between 150 and 250
-- between works only for numeric and date/time types
select order_id, customer_id, total_amount, status
from orders
where total_amount between 150 and 250;

-- find all the customers arranged in descending order of their first names
select customer_id, first_name, last_name, email, phone
from customers
order by first_name desc;

-- find all customers arranged in ascending order of their last name 
-- and descending order of their cities
select customer_id, first_name, last_name, email, phone, city
from customers
order by last_name asc, city desc;

-- original data --
-- doe, chicago
-- thomson, boston
-- doe, boston
-- doe, new york

-- result --
-- doe, new york
-- doe, chicago
-- doe, boston
-- thomson, boston

-- find the customers in boston, chicago and new york 
-- arranged in descending order of their emails
select customer_id, first_name, last_name, email, city
from customers
where city in ('Boston', 'Chicago', 'New York')
order by email desc;

-- find the total number of customers
select count(*) from customers;
select count(*) as total_no_of_customers from customers;

-- find the total number of customers from unique cities
select count(distinct city) from customers;

-- find total number of orders
select count(*) from orders;
select count(*) as total_no_of_orders from orders;

-- find the total revenue based on the orders placed
select sum(total_amount) from orders;
select sum(total_amount) as revenue from orders;

-- find the order with highest amount
select max(total_amount) from orders;
select max(total_amount) as max_amount from orders;

-- find the order with lowest amount
select min(total_amount) from orders;
select min(total_amount) as min_amount from orders;

-- find the average total amount
select avg(total_amount) from orders;
select avg(total_amount) as avg_amount from orders;

-- find min, max, average and total amount
select 
    min(total_amount) as min_amount, 
    max(total_amount) as max_amount,
    avg(total_amount) as avg_amount,
    sum(total_amount) as revenue
from orders;