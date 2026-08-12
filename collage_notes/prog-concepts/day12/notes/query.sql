-- create a database my_db
create database my_db;
use my_db;

-- create a table named customers
create table customers(
    id integer primary key auto_increment,
    name varchar(20),
    email varchar(20),
    password varchar(20),
    address varchar(20)
);

-- create a table named orders
create table orders(
    id integer primary key auto_increment,
    customer_id integer,
    order_date timestamp default CURRENT_TIMESTAMP,
    total_amount float,
    status varchar(15),
    foreign key (customer_id) references customers(id)
);

-- drop column named address from customers
alter table customers drop column address;

-- create a table named addresses with a required foreign key
create table addresses (
    id integer primary key auto_increment,
    name varchar(20),
    city varchar(20),
    zipcode varchar(6),
    state varchar(20),
    customer_id integer,
    foreign key (customer_id) references customers(id)
);

-- insert addresses only for 
-- allan (chicago, 123456, chicago), 
-- jane (boston, 456785, boston)
-- alice (chicago, 345676, chicago)
insert into addresses (customer_id, name, city, zipcode, state) values 
(1, 'home', 'chicago', 123456, 'chicago'),
(3, 'office', 'boston', 456785, 'boston'),
(4, 'home', 'chicago', 345676, 'chicago');

-- insert dummy data in customers
insert into customers (name, email, password, address) values 
('allan', 'allan@test.com', 'test', 'Chicago'),
('john', 'john@test.com', 'test', 'New York'),
('jane', 'jane@test.com', 'test', 'Boston'),
('alice', 'alice@test.com', 'test', 'Chicago'),
('jerry', 'jerry@test.com', 'test', 'Boston');

-- insert dummy data in orders
insert into orders (customer_id, total_amount, status) values
(1, 100, 'placed'),
(2, 150, 'placed'),
(3, 200, 'cancelled'),
(4, 500, 'delivered'),
(NULL, 600, 'placed');


-- find customers who have placed orders (inner join)
select 
    customers.id as customerId, customers.name, customers.email,
    orders.total_amount, orders.order_date, orders.status
from customers
inner join orders on customers.id = orders.customer_id;

-- find all customers and their orders (if exists)
select 
    customers.id, customers.name, customers.email,
    orders.total_amount, orders.order_date, orders.status
from customers
left join orders on customers.id = orders.customer_id;

-- find all the orders and their customers (if exists)
select 
    customers.id, customers.name, customers.email,
    orders.total_amount, orders.order_date, orders.status
from customers
right join orders on customers.id = orders.customer_id;

-- find the customers who have valid addresses (if exists)
select 
    customers.id, customers.name, 
    addresses.name, addresses.city, addresses.zipcode, addresses.state
from customers 
inner join addresses on customers.id = addresses.customer_id;

-- find the customers and their addresses (if exists)
select 
    customers.id, customers.name, 
    addresses.name, addresses.city, addresses.zipcode, addresses.state
from customers 
left join addresses on customers.id = addresses.customer_id;

-- find all addresses and their customers (if exists)
select 
    customers.id, customers.name, 
    addresses.name, addresses.city, addresses.zipcode, addresses.state
from customers 
right join addresses on customers.id = addresses.customer_id;

-- create table named departments
create table departments(
    id integer primary key auto_increment,
    name varchar(10)
);

-- insert dummy data
insert into departments (name) values ('account'), ('hr'), ('finance');

-- create table named employees
create table employees (
    id integer primary key auto_increment,
    name varchar(10),
    department_id integer,
    foreign key (department_id) references departments(id)
);

-- insert dummy data in employees table
insert into employees (name, department_id) values
('john', 1),
('jane', 2),
('alice', 3),
('jerry', NULL),
('arnold', NULL);

-- find all employees who have valid departments
select employees.id, employees.name, departments.name
from employees
inner join departments on employees.department_id = departments.id;

-- find all departments and their employees
select employees.id, employees.name, departments.name
from departments
left join employees on employees.department_id = departments.id;

select employees.id, employees.name, departments.name
from employees
right join departments on employees.department_id = departments.id;

-- find all employees and their departments
select employees.id, employees.name, departments.name
from departments
right join employees on employees.department_id = departments.id;

select employees.id, employees.name, departments.name
from employees
left join departments on employees.department_id = departments.id;

-- get the list of all users
select User from mysql.user;

-- create a new user
create user user1@localhost identified by 'test';

-- grant select privilege to user1 on mydb.customers
grant select on my_db.customers to user1@localhost;

-- grant insert privilege to user1 on mydb.customers;
grant insert on my_db.customers to user1@localhost;

-- flush the privilege
flush privileges

-- create a user2 with password 'test'
create user user2@localhost identified by 'test';

-- grant insert, select, update and delete privileges 
-- on customers and orders to user2
grant select, update, insert, delete on my_db.customers to user2@localhost;
grant select, update, insert, delete on my_db.orders to user2@localhost;

-- revoke insert permission from my_db.customers for user2
revoke insert on my_db.customers from user2@localhost

-- create a function to calculate bonus (10%)
delimiter $$

create function calculate_bonus(salary int)
returns float
deterministic
BEGIN
    declare bonus float;
    set bonus = salary * 0.10;
    return bonus;
end$$

delimiter ;

-- call the function
select calculate_bonus(10000);

-- convert c to f

delimiter $$

create function convert_c2f(temperature float)
returns float
deterministic
begin
    declare temperature_f float;
    set temperature_f = 32 + (temperature * 1.8);
    return temperature_f;
end$$

delimiter ;

-- call the convert_c2f function
select convert_c2f(32);


-- create a stored procedure to return list of customers
delimiter $$

create procedure get_customers()
begin
    select id, name, email, password from customers;
end$$

delimiter ;

-- call the get_customers() procedure
call get_customers();

-- write a procedure to find list of customers with their orders (if exists)

delimiter $$

create procedure get_customers_with_orders()
begin
    select 
        customers.id, customers.name, customers.email,
        orders.order_date, orders.total_amount
    from customers
    left join orders on customers.id = orders.customer_id;
end $$

delimiter ;

-- call the get_customers_with_orders() procedure
call get_customers_with_orders();


-- create a procedure to get customer details with orders using customer_id
delimiter $$

create procedure get_customer_details(IN customer_id int)
begin
    select 
        customers.id, customers.name, customers.email,
        orders.order_date, orders.total_amount
    from customers
    left join orders on customers.id = orders.customer_id
    where customers.id = customer_id;
end $$

delimiter ;

-- call the procedure
call get_customer_details(1);
    

-- create a table named users with name, email and password
create table users (
    id integer primary key auto_increment,
    name varchar(20),
    email varchar(50),
    password varchar(10)
);

-- insert dummy data in the users table
insert into users (name, email, password) values
('john', 'john@test.com', 'test'),
('jane', 'jane@test.com', 'test');

-- check if user is authenticated
select id, name, email 
from users
where email = 'john@test.com' and password = 'test';
