import socket
import threading

def handle_client(client_socket, remote_host, remote_port):
    remote_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    remote_socket.connect((remote_host, remote_port))
    
    def forward(src, dst):
        while True:
            data = src.recv(4096)
            if not data:
                break
            dst.send(data)
    
    client_thread = threading.Thread(target=forward, args=(client_socket, remote_socket))
    remote_thread = threading.Thread(target=forward, args=(remote_socket, client_socket))
    
    client_thread.start()
    remote_thread.start()

def main():
    local_host = "0.0.0.0"  # Bind to all available interfaces
    local_port = 4747  # Change to desired local port
    remote_host = "remote_target_ip"  # Change to target server address
    
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind((local_host, local_port))
    server.listen(5)
    
    print(f"[*] Listening on {local_host}:{local_port}")
    
    while True:
        client_socket, addr = server.accept()
        print(f"[*] Accepted connection from {addr[0]}:{addr[1]}")
        
        # Ganti nilai port target sesuai dengan kebutuhan, misalnya 80, 443, 22, dll.
        remote_port =  remote_target_port  # Change to target server port
        
        client_handler = threading.Thread(target=handle_client, args=(client_socket, remote_host, remote_port))
        client_handler.start()

if __name__ == "__main__":
    main()
