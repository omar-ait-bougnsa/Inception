FROM debian:latest

RUN apt update && apt upgrade && apt install -y nginx  openssl

COPY	conf/nginx.conf /etc/nginx/nginx.conf
RUN     chmod 755 /etc/nginx/nginx.conf
# COPY    conf/index.html /usr/share/nginx/html/index.html
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=oait-bou.42.fr"

EXPOSE 443
CMD ["nginx","-g","daemon off;"]

