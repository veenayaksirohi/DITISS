# step 1: import the required package
import mysql.connector

# step 2: create connection
connection = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="root",
    database="my_new_db"
)

# step 3: perform the operation

# step 3.1: create the query
sql = """
update departments 
set name = 'New Sales'
where id = 5;
"""

# step 3.2: create a cursor
cursor = connection.cursor()

# step 3.4: execute the query
cursor.execute(sql)

# step 3.5: commit the changes
connection.commit()

# step 3.6: close the cursor
cursor.close()

# step 4: close the connection
connection.close()