FROM debian:latest

RUN apt update && apt upgrade && apt install -y nginx  openssl

COPY	conf/nginx.conf /etc/nginx/nginx.conf
RUN     chmod 755 /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=MA/ST=BG/L=1337/O=42/OU=42/CN=oait-bou.42.fr"

EXPOSE 443
CMD ["nginx","-g","daemon off;"]

