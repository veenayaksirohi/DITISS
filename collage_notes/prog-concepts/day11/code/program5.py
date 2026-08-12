import mysql.connector

# create a connection with the database
connection = mysql.connector.connect(
    host="127.0.0.1",
    database="my_new_db",
    user="root",
    password="root"
)

def insert_department():
    # get name and description from user
    name = input("enter department name: ")
    description = input("enter department description: ")

    # create a cursor
    cursor = connection.cursor()

    # create the insert query
    # %s: placeholder which will receive the value later at the time of execution
    query = """
    insert into departments (name, description) values (%s, %s)
    """

    # collect the data 
    values = (name, description)

    # execute the query
    cursor.execute(query, values)

    # commit the changes
    connection.commit()

    # close the cursor
    cursor.close()

def update_department():
    # get name and description from user
    id = input("enter department id to be updated: ")
    name = input("enter new name: ")
    description = input("enter new description: ")

    # create a cursor
    cursor = connection.cursor()

    # create the insert query
    # %s: placeholder which will receive the value later at the time of execution
    query = """
    update departments set name=%s, description=%s 
    where id = %s
    """

    # collect the data 
    values = (name, description, id)

    # execute the query
    cursor.execute(query, values)

    # commit the changes
    connection.commit()

    # close the cursor
    cursor.close()

def delete_department():
    # get name and description from user
    id = input("enter department id to be deleted: ")

    # create a cursor
    cursor = connection.cursor()

    # create the insert query
    # %s: placeholder which will receive the value later at the time of execution
    query = """
    delete from departments where id = %s
    """

    # collect the data 
    values = (id,)

    # execute the query
    cursor.execute(query, values)

    # commit the changes
    connection.commit()    

    # close the cursor
    cursor.close()

def get_all_departments():
    # create a cursor
    cursor = connection.cursor()

    # create the insert query
    query = "select * from departments"

    # execute the query
    cursor.execute(query)

    # get all the records from cursor
    departments = cursor.fetchall()
    
    # iterate over the result
    print('-' * 44)
    print(f"| {'id':<4} | {'name':<10} | {'description':<20} |")
    print('-' * 44)
    for (id, name, description) in departments:
        print(f"| {id:<4} | {name:<10} | {description:<20} |")
    print('-' * 44)

    # close the cursor
    cursor.close()

def print_menu_and_get_choice():
    print("-" * 80)
    print("welcome to database connectivity")
    print("1. print all departments")
    print("2. insert a new department")
    print("3. update existing department")
    print("4. delete existing department")
    print("x. exit")

    choice = input("enter your choice: ")
    return choice

while True:
    ch = print_menu_and_get_choice()
    if ch == '1':
        get_all_departments()
    elif ch == '2':
        insert_department()
    elif ch == '3':
        update_department()
    elif ch == '4':
        delete_department()
    elif ch == 'x':
        break

# close the connection
connection.close()