# step 1: import the required package
import mysql.connector

# step 2: create the connection
connection = mysql.connector.connect(
    host="127.0.0.1",
    database="my_new_db",
    user="root",
    password="root"
)

# step 3: perform insert operation

# step 3.1: create the query
sql = """
insert into employees 
(first_name, last_name, email, phone, password, city, department_id, salary) 
values ('john', 'doe', 'john@test.com', '+12323342', 'test', 'pune', 1, 10000);
"""

# step 3.2: open a cursor
# cursor: in memory table (used to execute a query using the connection) 
cursor = connection.cursor()

# step 3.3: execute the query
cursor.execute(sql)

# step 3.4: commit the changes (write the changes to the disk)
# note: for every DML query it is important to commit the changes
connection.commit()

# step 3.5: close the cursor
cursor.close()

# step 4: close the connection
connection.close()