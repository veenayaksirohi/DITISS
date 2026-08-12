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

# to attack the code, use ' OR '1' = '1
password = input("enter your password: ")

# write the query to check if user can be authenticated
# this code is vulnerable for SQL injection (bypass authentication) attack
query = f"select id, name, email from users where email = '{email}' and password = '{password}';"
print(f"query = {query}")

# create a cursor
cursor = connection.cursor()

# execute the query
cursor.execute(query)

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
