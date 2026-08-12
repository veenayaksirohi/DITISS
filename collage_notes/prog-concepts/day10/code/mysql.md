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
