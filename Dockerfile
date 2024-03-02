# Use the Alpine base image
FROM alpine

# Install OpenSSH and create necessary directories
RUN apk add --no-cache openssh \
    && mkdir /var/run/sshd \
    && echo 'root:password' | chpasswd

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
