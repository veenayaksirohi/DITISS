# exercise 1

- create a table named products with following fields
  - title
  - description
  - price
  - brand
  - ratings
  - image

```sql
create table products(
    id integer primary key,
    title varchar(50),
    description varchar(100),
    price float,
    brand varchar(20),
    ratings float,
    image varchar(50)
);
```

- rename the column image to profileImage

```sql
alter table products rename column image to profileImage;
```

- remove column ratings

```sql
alter table products drop column ratings;
```

- add column keywords

```sql
alter table products add column keywords varchar(100);
```

- change the data type of description to varchar(1024)

```sql
alter table products modify column description varchar(1024);
```

# exercise 2

- create cart tables
  - customerId (foreign key)
  - productId (foreign key)
  - quantity
  - price

```sql
create table cart(
    id integer primary key,
    customerId integer,
    productId integer,
    quantity integer,
    price float
);

alter table cart add constraint foreign key (customerId) references customers(id);

alter table cart add constraint foreign key (productId) references products(id);
```
