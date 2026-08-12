# exercise 1

```bash

# create a container of nginx with name as nginx
> docker container run -d --name nginx nginx

# find the ip address
> docker container inspect nginx | grep IPAddress

# send a http request to the container using its IP address using curl command
> curl 172.17.0.2

# get the terminal of the container
> docker container exec -it nginx bash

# create a directory named local-directory
> mkdir local-directory

# create 100 files inside local-directory
> cd local-directory
> touch file{1..100}

# exit from the command prompt
> exit

# delete the container
> docker container rm --force nginx

```

# exercise 2

```bash

# create a container for MySQL
> docker container run -d --name mysql -e MYSQL_ROOT_PASSWORD=root mysql

# get the mysql command prompt from container
> docker container exec -it mysql mysql -u root -p

# create a database named mydb
mysql> create database mydb;
mysql> use mdb;

# create a table named users
mysql> create table users (id integer primary key auto_increment, name varchar(20));

# insert dummy data
> insert into users (name) values ('user1'), ('user2'), ('user3');
> select * from users;

# remove the container
> docker container rm --force mysql

```

# exercise 3

```bash

# create a volume
> docker volume create mysql-volume

# create a container for MySQL with root password set as `root` and with volume name mysql-volume
> docker container run -d --name mysql -e MYSQL_ROOT_PASSWORD=root -v mysql-volume:/var/lib/mysql mysql

# get the mysql command prompt from container
> docker container exec -it mysql mysql -u root -p

# create a database named mydb
mysql> create database mydb;
mysql> use mdb;

# create a table named users
mysql> create table users (id integer primary key auto_increment, name varchar(20));

# insert dummy data
> insert into users (name) values ('user1'), ('user2'), ('user3');
> select * from users;

# remove the container
> docker container rm --force mysql

```
