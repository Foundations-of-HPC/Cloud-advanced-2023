# Echo client program
import socket

 
socket_name = "/workdir/application.socket"

s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
s.connect(socket_name)

s.send(b'Hello, server!')
data = s.recv(1024)
s.close()

print('Received form server: ' + repr(data))
