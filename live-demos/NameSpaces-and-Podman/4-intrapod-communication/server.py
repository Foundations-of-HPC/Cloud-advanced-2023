import socket
import os

socket_name = "/workdir/application.socket"

s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

try:
    os.remove(socket_name)
except OSError:
    pass

s.bind(socket_name)
s.listen(1)
conn, addr = s.accept()

while True:
    data = conn.recv(1024)
    if data:
        print('Recived form client: ', data)
        data = b'hello client!'
        conn.send(data)
    else:
        break

conn.close()
