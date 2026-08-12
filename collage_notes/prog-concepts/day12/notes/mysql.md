# mysql shell

```bash

# start the mysql shell
# > mysql -u <user name> -p
> mysql -u root -p

```

# Database commands

```bash

# get the list of databases
> show databases;

# create a new database
# > CREATE DATABASE <db name>
> create database mydb;

# create a database if it does not exist
# if db exists, the command will not be fired
# if db does not exist, the command will be fired to create the database
> create database if not exists mydb;

# delete a database
# > drop database <db name>
> drop database mydb;

# delete a database if exists
> drop database if exists mydb;

# use a database for further query execution
# > use <db name>
> use mydb;

```

# table commands

```bash

# get a list of tables
> show tables;

# create a table named customers
# > create table if not exists customers (
> create table customers (
    id integer primary key,
    name varchar(20),
    address varchar(20),
    city varchar(20),
    zipcode int,
    email varchar(50),
    password varchar(50)
);

> create table customers (
    id integer primary key auto_increment,
    name varchar(20),
    address varchar(20),
    city varchar(20),
    zipcode int,
    email varchar(50),
    password varchar(50)
);


# create a table with foreign key
> create table addresses (
    id integer primary key,
    customerId integer,
    address varchar(50),
    city varchar(10),
    state varchar(10),
    foreign key (customerId) references customers(id)
);

# get the structure of selected table
# > describe <table name>
> describe customers;
> desc customers;

# get the create table statement for a table
> show create table customers;

# rename a table from old to new name
# > rename table <old name> to <new name>
> rename table customers to customer;

# remove all the rows from a table
# note: only data from the table will be deleted
# and the table itself will NOT be deleted
# > truncate <table name>
> truncate customers;

# remove a table
# note: this command deletes both: data and the table itself
# > drop table <table name>
> drop table customers;

# change the data type of existing column
# > alter table <table name> modify column <column name> <datatype>;
> alter table customers modify column zipcode varchar(6);

# remove existing column
# > alter table <table name> drop column <column name>;
> alter table customers drop column address;
> alter table customers drop column city;
> alter table customers drop column zipcode;

# add a new column to a table
# > alter table <table name> add column <column name> <data type>;
> alter table customers add column phone varchar(10);

```

# dml

```bash

# insert a single record with id (primary key)
# > insert into <table name> (<col1>, <col2>...) values (<value1>, <value2>...);
> insert into department (id, name, description) values (1, 'computer', 'computer department');

# insert a single record without passing the id (primary key)
> insert into departments (name, description) values ('computer', 'computer department');
> insert into departments (name, description) values ('Account', 'Account department');
> insert into departments (name, description) values ('HR', 'HR department');
> insert into departments (name, description) values ('Admin', 'Admin department');

# insert multiple records
# > insert into <table name> (<col1>, <col2>, ...), values (<v1>, <v2>...), (<v1>, <v2> ...);
> insert into employees (first_name, last_name, email, password, department_id, phone, salary) values
('john', 'doe', 'john@test.com', 'test', 1, '+1234234', 10000),
('jane', 'doe', 'jane@test.com', 'test', 2, '+1234346', 11000),
('allan', 'kay', 'allan@test.com', 'test', 4, '+1234238', 50000);

# ignore the record while inserting into a table if it encounters an error
> insert ignore into departments (id, name, description) values (4, 'TCT', 'TCT department');

# update a record if an entry exists for a primary key column
# > insert into <table name> (<col1>, <col2>..) values (<v1>, <v2>..) on duplicate key update <col1> = values(<col1>), <col2> = values(<col2>)..;
> insert into departments (id, name, description) values (4, 'TCT', 'TCT department') on duplicate key update name=values(name), description=values(description);

# update existing record(s)
# > update <table name> set <col1>=<value>, <col2>=<value> where <condition>
> update employees set salary = 25000 where id = 3;

# delete a record
# > delete from <table name> where <condition>
> delete from employees where id = 3;

# delete all records
# note: the id column will NOT get reset
> delete from employees;

# delete all records
# note: the id column gets reset to 0
> truncate table employees;

```

# dql

```bash

# select all the records from a table
# > select * from <table name>
> select * from departments;

# select all records with specific columns
> select id, first_name, last_name from employees;

# selecting records with column alias
# alias: temporary name given to an existing column
# > select <col name> as <alias> from <table name>
> select id as Id, first_name as FirstName, last_name as LastName from employees;

# selecting records with selection criteria
# > select <projection> from <table name> where <condition>
> select id, name, description from departments where id = 2;

```

# joins

```bash

# inner join
# - find out the common rows between two tables (left and right table)
# > select <projection> from <left table> inner join <right table> on <condition>
> select customers.id, customers.name, orders.order_date, orders.total_amount from customers inner join orders on customers.id = orders.customer_id;

# inner join
# - find out the common rows between two tables (left and right table)
# > select <projection> from <left table> inner join <right table> on <condition>
> select customers.id, customers.name, orders.order_date, orders.total_amount from customers inner join orders on customers.id = orders.customer_id;

# inner join
# - find out the common rows between two tables (left and right table)
# > select <projection> from <left table> inner join <right table> on <condition>
> select customers.id, customers.name, orders.order_date, orders.total_amount from customers inner join orders on customers.id = orders.customer_id;


```

# dcl

```bash

# create a user
# > create user <username>@<machine name> identified by <password>;
> create user user1@localhost identified by 'test';

# login with newly created user
# > mysql -u user1 -p

# grant privileges to a user on a table
# > grant <permission> on <database name>.<table name> to <username>@<machine name>;

```

# mysql connection with python code

```bash

# install mysql connector
> pip install mysql-connector-python

```
