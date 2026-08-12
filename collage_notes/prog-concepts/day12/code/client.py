# import socket package
import socket

# create a TCT socket
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# connect to the server process
client.connect(("127.0.0.1", 4100))

# send a message to the server
client.send("hi from client... ".encode())

# receive a message sent by the server
message = client.recv(1024).decode()
print(f"message received from server: {message}")

# close the connection
client.close()
