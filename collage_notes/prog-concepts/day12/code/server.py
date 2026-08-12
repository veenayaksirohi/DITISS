# import socket package (built in package)
import socket

# create a TCP socket
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# bind this socket to the IP address and a port
server.bind(("0.0.0.0", 4100))

# listen for incoming connections
server.listen()

print("server started listening on port 4100")

# accept the incoming connection
client, address = server.accept()

# receive a message from client
message = client.recv(1024).decode()
print(f"message received from client = {message}")

# send a message to the client
client.send("hi from sever..".encode())

# close the client connection
client.close()

# close the server connection
server.close()
