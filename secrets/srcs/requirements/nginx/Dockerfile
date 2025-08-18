FROM debian:latest

RUN apt update && apt upgrade && apt install -y nginx

COPY	conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx","-g","doemon off;"]