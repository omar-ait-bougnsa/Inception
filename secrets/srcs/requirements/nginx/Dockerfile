FROM debian:latest

RUN apt update && apt upgrade && apt install -y nginx

COPY	conf/nginx.conf /etc/nginx/nginx.conf
COPY    conf/index.html /usr/share/nginx/html/index.html
CMD ["nginx","-g","daemon off;"]