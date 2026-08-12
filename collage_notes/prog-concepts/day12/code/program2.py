import mysql.connector

# create connection
connection = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="root",
    database="my_db"
)

# get input from user
email = input("enter your email: ")
password = input("enter your password: ")

# write the query to check if user can be authenticated
query = "select id, name, email from users where email = %s and password = %s;"

# create a cursor
cursor = connection.cursor()

# create values collection
values = (email, password)

# execute the query
cursor.execute(query, values)

# get the results
users = cursor.fetchall()
print(users)

# check if user exists
if len(users) > 0:
    print("you are authenticated")
else:
    print("invalid email or password")

# close the cursor
cursor.close()

# close the connection
connection.close()
