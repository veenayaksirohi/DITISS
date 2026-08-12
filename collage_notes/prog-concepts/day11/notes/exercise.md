# exercise 1

- create a database my_new_db
  - create a table named departments
    - id (primary key)
    - name
    - description

  ```sql
  create table departments (
    id integer primary key auto_increment,
    name varchar(10),
    description varchar(100)
  );
  ```

  - create a table named employees
    - id (primary key)
    - first_name
    - last_name
    - email
    - password
    - phone
    - department_id (foreign key)
    - salary

  ```sql
  create table employees (
      id integer primary key auto_increment,
      first_name varchar(10),
      last_name varchar(10),
      email varchar(10),
      password varchar(50),
      phone varchar(10),
      department_id integer,
      salary integer,
      foreign key (department_id) references departments(id)
  );
  ```

  - increase length of email to 100

  ```sql
  alter table employees modify email varchar(100);
  ```

  - insert employees

  ```sql
  insert into employees (first_name, last_name, email, password, department_id, phone, salary) values
  ('john', 'doe', 'john@test.com', 'test', 1, '+1234234', 10000),
  ('jane', 'doe', 'jane@test.com', 'test', 2, '+1234346', 11000),
  ('allan', 'kay', 'allan@test.com', 'test', 4, '+1234238', 50000);
  ```

  - insert a new employee named arnold with id as 3

  ```sql
  insert into employees (id, first_name, last_name, email, phone, password) values (3, 'arnold', 'sch', 'arnold@test.com', '+123423234', 'test');
  ```

  - insert a new employee named arnold with id as 3 and ignore if there is any error

  ```sql
  insert ignore into employees (id, first_name, last_name, email, phone, password) values (3, 'arnold', 'sch', 'arnold@test.com', '+123423234', 'test');
  ```

  - insert a new employee named arnold with id as 3 and if id 3 already exists, update the record with new values of first_name, last_name, email, password and phone

  ```sql
  insert into employees (id, first_name, last_name, email, phone, password) values (3, 'arnold', 'sch', 'arnold@test.com', '+123423234', 'test') on duplicate key update first_name=values(first_name), last_name=values(last_name), email=values(email), phone=values(phone), password=values(password);
  ```

  - update record of john: salary to 5000 and email to john@company.in

  ```sql
  update employees set salary = 5000, email = 'john@company.in' where id = 1;
  ```

  - update phone number of jane to '+9123432434'

  ```sql
  alter table employees modify phone varchar(20);
  update employees set phone='+9123432434'  where id = 2;
  ```

  - add a new column named city in employees and update it with value 'pune' for all the records

  ```sql
  alter table employees add city varchar(20);
  update employees set city='pune';
  ```
